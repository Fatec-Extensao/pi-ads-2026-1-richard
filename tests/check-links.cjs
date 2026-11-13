const fs = require('fs'), path = require('path'), assert = require('assert/strict');
const root = path.resolve(__dirname, '..');
const files = [];
function walk(dir) {
  for (const ent of fs.readdirSync(dir,{withFileTypes:true})) {
    if (['.git','node_modules'].includes(ent.name)) continue;
    const p=path.join(dir,ent.name);
    if(ent.isDirectory()) walk(p); else if(/\.(md|html)$/.test(p)) files.push(p);
  }
}
walk(root);
let count=0;const broken=[];
for(const f of files) {
  const text=fs.readFileSync(f,'utf8');
  const refs=f.endsWith('.html')?[...text.matchAll(/(?:href|src)="([^"]+)"/g)].map(m=>m[1]):[...text.matchAll(/!?\[[^\]]*\]\(([^)]+)\)/g)].map(m=>m[1]);
  for(let ref of refs) {
    ref=ref.replace(/^<|>$/g,'');
    if(/^(?:https?:|mailto:|data:|#)/.test(ref)) continue;
    // Liens de issues legados usam ../../issues/N, que não são arquivos.
    if(/^\.\.\/\.\.\/issues\/\d+$/.test(ref)) { broken.push({file:path.relative(root,f),ref,reason:'issue relativa inválida'});continue; }
    const name=decodeURIComponent(ref.split('#')[0].split('?')[0]);
    count++;
    if(!fs.existsSync(path.resolve(path.dirname(f),name))) broken.push({file:path.relative(root,f),ref});
  }
}
console.log(JSON.stringify({files:files.length,localReferences:count,broken},null,2));
assert.equal(broken.length,0,'Há links locais quebrados.');
