# Banco de Dados I — Modelagem lógica, DDL e consultas

Professor: Prof. Luiz Fernando de Oliveira Silva. Projeto: Sistema Web para Gestão de Pesquisas por Questionários.

## Issue #4 — Modelo lógico e DDL

- [Modelo lógico e dicionário das 12 tabelas](modelo-logico.md).
- [Normalização até a 3FN](normalizacao-3fn.md).
- [schema.sql](schema.sql): CREATE TABLE, PKs, UNIQUEs, CHECKs e 14 FKs em ALTER TABLE.
- [testes-ddl.sql](testes-ddl.sql): inventário, 19 inserções válidas, dez casos inválidos esperados e rollback.
- [Registro de validação e execução Oracle pendente](validacao-ddl.md).

O [modelo anterior](bd%20o.txt) permanece como origem histórica. A revisão conserva as 12 tabelas e as colunas. A PK de alternativa passa a ser (id_pergunta, id_alternativa), pois seu número é local à pergunta. A FK em resposta usa a mesma combinação. Há restrições de unicidade e domínio adicionais, documentadas no modelo lógico.

## Como executar

Use Oracle SQL Developer com conexão a um esquema de testes vazio. Abra schema.sql e execute como script (F5). Depois abra testes-ddl.sql e execute da mesma forma. A seção negativa do teste gera erros esperados, explicados no registro de validação. Esses erros não representam falha quando o código e o motivo coincidem com o esperado.

Não execute schema.sql sobre tabelas já existentes. Esta é a criação completa da estrutura revisada, não uma migração de uma base já criada. DDL no Oracle é confirmado automaticamente: uma falha posterior não desfaz tabelas já criadas. Use um esquema separado para os testes.

## Issue #5 — Dados fictícios e relatórios

Os arquivos de povoamento e consultas já existentes continuam válidos nesta estrutura. A compatibilidade foi verificada no adaptador de testes; ainda falta comprovar a execução Oracle.

Depois do DDL, execute uma única vez [povoamento.sql](povoamento.sql), depois [validacao.sql](validacao.sql) e [queries.sql](queries.sql). O teste do DDL desfaz seus próprios dados e não substitui o povoamento.

| Tabela | Registros do povoamento |
| --- | ---: |
| perfil | 3 |
| usuario | 3 |
| pesquisa | 2 |
| categoria | 3 |
| questionario | 4 |
| pergunta | 10 |
| alternativa | 9 |
| lote_senha | 3 |
| senha_acesso | 12 |
| submissao | 9 |
| resposta | 21 |
| auditoria | 2 |

Na Q1, os questionários 1/2/3/4 apresentam participação de 83,33%/75%/50%/0%. Na Q3, médias 4/4/2/NULL. A Q5 mantém somente o questionário 1 com cinco avaliações e média 4. Os dados são fictícios; os relatórios detalhados não devem ser usados para divulgar respostas reais de grupos pequenos.

## Limites da estrutura

As constraints validam chaves, alternativas da pergunta correta, unicidade e domínios. A coerência entre questionário da submissão e pergunta, a correspondência de tipo, o preenchimento obrigatório e o consumo atômico de códigos ainda exigem regras adicionais no backend. Os códigos permanecem em claro no modelo acadêmico, e metadados podem permitir identificação indireta. [Relatório de privacidade](../seguranca/lgpd-e-anonimato.md).

[Voltar ao projeto](../../README.md).
