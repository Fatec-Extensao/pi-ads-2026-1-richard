const {chromium}=require('playwright');
const fs=require('fs'),path=require('path'),http=require('http'),assert=require('assert/strict');
const root=path.resolve(__dirname,'../2026-2/desenvolvimento-web/src');
const executable=process.env.CHROME_PATH||'C:/Program Files/Google/Chrome/Application/chrome.exe';
const types={'.html':'text/html; charset=utf-8','.js':'text/javascript; charset=utf-8','.css':'text/css; charset=utf-8','.png':'image/png'};
const server=http.createServer((req,res)=>{
  const file=path.resolve(root,'.'+decodeURIComponent(req.url.split('?')[0]==='/'?'/index.html':req.url.split('?')[0]));
  if(!file.startsWith(root+path.sep)||!fs.existsSync(file)){res.writeHead(404);res.end();return;}
  res.setHeader('Content-Type',types[path.extname(file)]||'text/plain');res.end(fs.readFileSync(file));
});
(async()=>{
  await new Promise(resolve=>server.listen(0,'127.0.0.1',resolve));
  const base=`http://127.0.0.1:${server.address().port}`;
  const browser=await chromium.launch({executablePath:executable,headless:true});
  const context=await browser.newContext({viewport:{width:1280,height:900}});
  const page=await context.newPage();const errors=[],outbound=[],posts=[];
  page.on('pageerror',e=>errors.push(e.message));
  page.on('request',r=>{if(!r.url().startsWith(base))outbound.push(r.url());if(r.method()!=='GET')posts.push(r.url());});
  const passed=[];
  async function check(name,fn){await fn();passed.push(name);}
  await check('Acesso: código vazio, inválido e DEMO2026',async()=>{
    await page.goto(base+'/funcionalidades/rf08-acessar-pesquisa.html');
    await page.getByRole('button',{name:'Acessar pesquisa',exact:true}).click();
    assert.equal(await page.locator('#senha-acesso').getAttribute('aria-invalid'),'true');
    await page.locator('#senha-acesso').fill('INVALIDO');await page.getByRole('button',{name:'Acessar pesquisa',exact:true}).click();
    assert.match(await page.locator('[data-feedback]').innerText(),/Código não encontrado/);
    await page.locator('#senha-acesso').fill('demo2026');await page.getByRole('button',{name:'Acessar pesquisa',exact:true}).click();
    await page.waitForURL('**/rf10-responder-questionario.html');
  });
  await check('Navegação: bloqueia vazio, mantém respostas ao voltar e exige ciência',async()=>{
    await page.getByRole('button',{name:'Avançar',exact:true}).click();
    assert.equal(await page.locator('[data-step]:visible').count(),1);
    assert.equal(await page.locator('#atendimento-bom').getAttribute('aria-invalid'),'true');
    await page.locator('#atendimento-bom').check();await page.getByRole('button',{name:'Avançar',exact:true}).click();
    await page.getByRole('button',{name:'Avançar',exact:true}).click();assert.equal(await page.locator('#satisfacao').getAttribute('aria-invalid'),'true');
    await page.locator('#satisfacao').selectOption('5');await page.getByRole('button',{name:'Voltar',exact:true}).click();
    assert.equal(await page.locator('#atendimento-bom').isChecked(),true);
    await page.getByRole('button',{name:'Avançar',exact:true}).click();assert.equal(await page.locator('#satisfacao').inputValue(),'5');
    await page.getByRole('button',{name:'Avançar',exact:true}).click();
    await page.getByRole('button',{name:'Concluir demonstração',exact:true}).click();assert.equal(await page.locator('#ciencia').getAttribute('aria-invalid'),'true');
  });
  await check('Conclusão: descarta respostas, bloqueia nesta aba e permite reiniciar',async()=>{
    await page.locator('#sugestao').fill('SUGESTAO_FICTICIA_TESTE');await page.locator('#ciencia').check();
    await page.getByRole('button',{name:'Concluir demonstração',exact:true}).click();
    assert.match(await page.locator('[data-feedback]').innerText(),/respostas foram descartadas/);
    assert.equal(await page.locator('#sugestao').inputValue(),'');
    const stored=await page.evaluate(()=>({local:JSON.stringify({...localStorage}),session:JSON.stringify({...sessionStorage})}));
    assert.equal(stored.local,'{}');assert.equal(stored.session,'{"pi-demo-codigo-utilizado":"1"}');
    await page.reload();assert.equal(await page.locator('[data-wizard]').isVisible(),false);
    await page.getByRole('button',{name:'Reiniciar demonstração'}).click();assert.equal(await page.locator('[data-wizard]').isVisible(),true);
  });
  await check('Cadastro: espaços em branco e intervalo de datas inválido',async()=>{
    await page.goto(base+'/funcionalidades/rf01-cadastrar-pesquisa.html');
    await page.locator('#titulo').fill('   ');await page.locator('#descricao').fill('Teste fictício');await page.locator('#inicio').fill('2026-11-10');await page.locator('#fim').fill('2026-11-01');
    await page.getByRole('button',{name:'Cadastrar pesquisa',exact:true}).click();
    assert.equal(await page.locator('#titulo').getAttribute('aria-invalid'),'true');assert.equal(await page.locator('#fim').getAttribute('aria-invalid'),'true');
    await page.locator('#titulo').fill('Pesquisa teste');await page.locator('#fim').fill('2026-11-30');await page.getByRole('button',{name:'Cadastrar pesquisa',exact:true}).click();
    assert.match(await page.locator('[data-feedback]').innerText(),/Campos validados/);
  });
  await check('Login: e-mail inválido, senha curta e ausência de autenticação real',async()=>{
    await page.goto(base+'/login.html');await page.locator('#email').fill('invalido');await page.locator('#senha').fill('123');await page.getByRole('button',{name:'Entrar',exact:true}).click();
    assert.equal(await page.locator('#email').getAttribute('aria-invalid'),'true');assert.equal(await page.locator('#senha').getAttribute('aria-invalid'),'true');
    await page.locator('#email').fill('admin@example.test');await page.locator('#senha').fill('FICTICIA2026');await page.getByRole('button',{name:'Entrar',exact:true}).click();
    assert.match(await page.locator('[data-feedback]').innerText(),/Nenhum login foi realizado/);assert.equal(await page.locator('#senha').inputValue(),'');
  });
  await check('Quantidade: rejeita 0, fracionário e acima de 1000',async()=>{
    await page.goto(base+'/funcionalidades/rf06-gerar-senhas.html');
    for(const v of ['0','1.5','1001']){await page.locator('#quantidade').fill(v);await page.getByRole('button',{name:'Gerar senhas',exact:true}).click();assert.equal(await page.locator('#quantidade').getAttribute('aria-invalid'),'true');}
  });
  await check('Privacidade e apresentação: navegação funcional',async()=>{
    await page.goto(base+'/privacidade.html');assert.match(await page.locator('main').innerText(),/coleta real está desabilitada/);
    await page.goto(base+'/apresentacao.html');assert.equal(await page.locator('.slide:visible').count(),1);
    for(let i=0;i<6;i++)await page.getByRole('button',{name:'Próximo',exact:true}).click();
    assert.equal(await page.locator('#contador').innerText(),'7 / 7');assert.equal(await page.locator('#proximo').isDisabled(),true);
    await page.getByRole('button',{name:'Anterior',exact:true}).click();assert.equal(await page.locator('#contador').innerText(),'6 / 7');
  });
  await check('Responsividade: 390px, sem overflow horizontal',async()=>{
    await page.setViewportSize({width:390,height:844});
    for(const f of ['/index.html','/funcionalidades/rf10-responder-questionario.html','/privacidade.html','/apresentacao.html']){
      await page.goto(base+f);assert.equal(await page.evaluate(()=>document.documentElement.scrollWidth<=innerWidth),true,f);
    }
  });
  await check('JavaScript desativado: envio permanece bloqueado',async()=>{
    const nojs=await browser.newContext({javaScriptEnabled:false});const p=await nojs.newPage();
    await p.goto(base+'/funcionalidades/rf10-responder-questionario.html');assert.equal(await p.locator('[data-submit]').isDisabled(),true);
    await p.goto(base+'/login.html');assert.equal(await p.getByRole('button',{name:'Entrar',exact:true}).isDisabled(),true);await nojs.close();
  });
  assert.deepEqual(errors,[]);assert.deepEqual(outbound,[]);assert.deepEqual(posts,[]);
  console.log(JSON.stringify({passed,pageErrors:errors,externalRequests:outbound,nonGetRequests:posts},null,2));
  await browser.close();server.close();
})().catch(e=>{console.error(e);server.close();process.exit(1)});
