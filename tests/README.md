# Verificações locais

Na raiz do repositório:

1. Instale as dependências de teste com npm install --prefix tests.
2. Use npm --prefix tests run ddl para testar o DDL e dez rejeições de dados inválidos.
3. Use npm --prefix tests run db para conferir os dados e as cinco consultas da Issue #5.
4. Use npm --prefix tests run links para conferir destinos de links locais.
5. Use npm --prefix tests run ui para testar a interface em Chrome.

Os testes ddl e db usam SQLite/WASM, com adaptação explícita das FKs de ALTER TABLE para CREATE TABLE. O teste db também adapta DATE, NVL e divisão numérica. Não equivalem à execução Oracle. O SQL entregue permanece em sintaxe Oracle.

check-ddl.cjs testa as chaves, domínios e rollback com dados sintéticos, inclusive a FK composta de alternativa. check-db.cjs usa os arquivos de povoamento e consultas da Issue #5. Não publica dados ou acessa o Oracle.

O teste ui usa Playwright e Chrome instalado. Por padrão procura C:/Program Files/Google/Chrome/Application/chrome.exe. Em outros sistemas, defina CHROME_PATH para o executável. As dependências são exclusivas de teste e não fazem parte do site publicado.

[Registro de testes do DDL](../2026-2/banco-de-dados/validacao-ddl.md).
