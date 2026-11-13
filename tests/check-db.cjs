// Verificação de lógica em SQLite/WASM. NÃO substitui executar os scripts Oracle.
const fs=require('fs'),path=require('path'),assert=require('assert/strict');
const initSqlJs=require('sql.js');
const base=path.resolve(__dirname,'../2026-2/banco-de-dados');
const read=name=>fs.readFileSync(path.join(base,name),'utf8');
const clean=text=>text.replace(/--[^\n]*/g,'').replace(/^(?:WHENEVER|SET) .+$/gm,'').replace(/DATE '([^']+)'/g,"'$1'");
(async()=>{
  const SQL=await initSqlJs();const db=new SQL.Database();
  db.run('PRAGMA foreign_keys = ON');db.create_function('NVL',(a,b)=>a===null?b:a);
  db.run(clean(read('schema.sql')));db.run('BEGIN');db.run(clean(read('povoamento.sql')));
  const expected={perfil:3,usuario:3,pesquisa:2,categoria:3,questionario:4,pergunta:10,alternativa:9,lote_senha:3,senha_acesso:12,submissao:9,resposta:21,auditoria:2};
  for(const [table,n] of Object.entries(expected))assert.equal(db.exec(`SELECT COUNT(*) FROM ${table}`)[0].values[0][0],n,table);
  const checks=clean(read('validacao.sql')).split(';').map(s=>s.trim()).filter(Boolean);
  for(const stmt of checks.slice(12))assert.equal(db.exec(stmt).length,0,'Regra de integridade: '+stmt);
  // Numeric arithmetic in Oracle is fractional even for integer COUNT values.
  const queries=clean(read('queries.sql')).replace('100 *','100.0 *').split(';').map(s=>s.trim()).filter(Boolean);
  assert.equal(queries.length,5);
  const result=queries.map(q=>db.exec(q)[0]);
  const q1=Object.fromEntries(result[0].values.map(r=>[r[2],r.slice(3)]));
  assert.deepEqual(q1,{'1':[6,5,5,83.33],'2':[4,3,3,75],'3':[2,1,1,50],'4':[0,0,0,0]});
  assert.deepEqual(result[1].values.map(r=>r[4]),[3,1,1,2,1,0,0,0,1]);
  const q3=Object.fromEntries(result[2].values.map(r=>[r[2],r.slice(3)]));
  assert.deepEqual(q3,{'2':[5,4,2,5],'5':[3,4,3,5],'8':[1,2,2,2],'10':[0,null,null,null]});
  assert.deepEqual(result[3].values.map(r=>r[2]),[3,8,8,0,1,1]);
  assert.deepEqual(result[4].values,[[1,'Alunos',2,5,4]]);
  // O esquema herdado não pode associar submissão a uma senha ou usuário.
  const cols=db.exec('PRAGMA table_info(submissao)')[0].values.map(r=>r[1]);
  assert.deepEqual(cols,['id_submissao','id_questionario','enviada_em']);
  console.log(JSON.stringify({engine:'SQLite WASM com adaptação de DATE/NVL e divisão numérica; Oracle não executado',tables:expected,queries:result.map((r,i)=>({query:i+1,columns:r.columns,rows:r.values})),integrityChecks:checks.length-12},null,2));
  db.close();
})().catch(e=>{console.error(e);process.exitCode=1});
