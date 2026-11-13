# Verificações locais

## Links internos

Na raiz do repositório, execute: node tests/check-links.cjs

O script verifica destinos locais de links em HTML/Markdown. URLs externas são excluídas dessa contagem. Não comprova a existência do site publicado.

## Banco e interface

Instale apenas para testes: npm install --prefix tests

Execute:

- npm --prefix tests run db
- npm --prefix tests run ui

O teste de banco usa SQLite/WASM, adapta literais DATE, a função NVL e divisão numérica para verificar os dados e resultados das cinco consultas. Ele testa FKs e seis regras de consistência. Não equivale à execução Oracle.

O teste de interface usa Playwright e Chrome instalado. Por padrão procura C:/Program Files/Google/Chrome/Application/chrome.exe. Em outros sistemas, defina CHROME_PATH para o executável antes de rodar. O servidor temporário usa uma porta local aleatória e fecha ao fim do teste.

O teste percorre acesso, etapas, validação de datas, login fictício e quantidades. Verifica ausência de envio de formulários e de requisições externas, descarte de respostas, comportamento sem JavaScript e largura móvel de 390 px.

As dependências de teste não precisam ser publicadas no GitHub Pages.
