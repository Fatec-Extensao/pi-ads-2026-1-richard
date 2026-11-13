// Adaptador de teste: converte somente a localização das FKs para SQLite.
// Os arquivos SQL entregues continuam Oracle e não devem ser substituídos por isto.
function adaptOracleDDL(source) {
  const links=new Map();
  const schema=source.replace(/--[^\n]*/g,'').replace(/ALTER TABLE (\w+) ADD CONSTRAINT (\w+)\s+(FOREIGN KEY \([^)]+\) REFERENCES \w+ \([^)]+\));/g,(_,table,name,fk)=>{
    if(!links.has(table))links.set(table,[]);
    links.get(table).push(`CONSTRAINT ${name} ${fk}`);
    return '';
  });
  if([...links.values()].reduce((n,l)=>n+l.length,0)!==14)throw new Error('O adaptador esperava 14 FKs.');
  return schema.replace(/CREATE TABLE (\w+) \(([\s\S]*?)\);/g,(_,table,body)=>`CREATE TABLE ${table} (${body}${links.has(table)?',\n'+links.get(table).join(',\n'):''});`);
}
module.exports={adaptOracleDDL};
