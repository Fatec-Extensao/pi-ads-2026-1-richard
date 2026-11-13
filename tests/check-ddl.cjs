// Teste comportamental em SQLite/WASM. Não constitui execução Oracle.
const fs=require('fs'),path=require('path'),assert=require('assert/strict');
const initSqlJs=require('sql.js');const {adaptOracleDDL}=require('./ddl-adapter.cjs');
const root=path.resolve(__dirname,'..'),base=path.join(root,'2026-2/banco-de-dados');
const source=fs.readFileSync(path.join(base,'schema.sql'),'utf8');
const clean=s=>s.replace(/--[^\n]*/g,'').replace(/^(?:WHENEVER|SET) .+$/gm,'').replace(/DATE '([^']+)'/g,"'$1'");
(async()=>{
 const SQL=await initSqlJs(),db=new SQL.Database();db.run('PRAGMA foreign_keys = ON');db.run(adaptOracleDDL(source));
 const names=db.exec("SELECT name FROM sqlite_master WHERE type='table' ORDER BY name")[0].values.map(r=>r[0]);assert.equal(names.length,12);
 const count={P:0,R:0,U:0,C:0};for(const m of source.matchAll(/CONSTRAINT \w+\s+(PRIMARY KEY|FOREIGN KEY|UNIQUE|CHECK)/g))count[{'PRIMARY KEY':'P','FOREIGN KEY':'R','UNIQUE':'U','CHECK':'C'}[m[1]]]++;
 assert.deepEqual(count,{P:12,R:14,U:8,C:13});
 const tests=clean(fs.readFileSync(path.join(base,'testes-ddl.sql'),'utf8'));
 const positive=tests.slice(tests.indexOf('SAVEPOINT teste_ddl;'),tests.indexOf("INSERT INTO perfil VALUES (900001, 'Outro perfil teste');"));
 db.run(positive);assert.equal(db.exec('SELECT COUNT(*) FROM resposta WHERE id_submissao=900001')[0].values[0][0],3);
 assert.equal(db.exec('SELECT COUNT(*) FROM alternativa WHERE id_alternativa=1')[0].values[0][0],2);
 const negative=tests.slice(tests.indexOf("INSERT INTO perfil VALUES (900001, 'Outro perfil teste');"),tests.indexOf('ROLLBACK TO teste_ddl;')).split(';').map(s=>s.trim()).filter(Boolean);
 assert.equal(negative.length,10);const expected=[/UNIQUE/,/FOREIGN KEY/,/NOT NULL/,/UNIQUE/,/CHECK/,/FOREIGN KEY/,/UNIQUE/,/CHECK/,/CHECK/,/FOREIGN KEY/];
 const rejected=[];for(const [i,sql] of negative.entries()){let err;try{db.run(sql)}catch(e){err=e}assert(err,'Deveria rejeitar N'+(i+1));assert.match(err.message,expected[i]);rejected.push({case:'N'+(i+1),result:'rejeitado',reason:err.message});}
 db.run('ROLLBACK TO teste_ddl;');assert.equal(db.exec('SELECT COUNT(*) FROM perfil')[0].values[0][0],0);
 console.log(JSON.stringify({engine:'SQLite/WASM; FKs convertidas de ALTER TABLE para CREATE TABLE. Não executado em Oracle.',tables:names,constraints:count,positiveInserts:19,negativeCases:rejected,rollback:'sem registros de teste restantes'},null,2));db.close();
})().catch(e=>{console.error(e);process.exitCode=1});
