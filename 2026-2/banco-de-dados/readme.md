# Banco de Dados I — Issue #5

Professor: Prof. Luiz Fernando de Oliveira Silva.

O esquema Oracle foi extraído do arquivo existente [bd o.txt](bd%20o.txt), sem alterar suas 12 tabelas. Os IDs são explícitos e todos os registros são fictícios. Não usar o povoamento em produção.

## Execução

Em um esquema Oracle de testes vazio, abra os arquivos em SQL Developer e execute como script (F5), nesta ordem:

1. [schema.sql](schema.sql): cria as tabelas; não remove estruturas existentes.
2. [povoamento.sql](povoamento.sql): insere os dados uma única vez e confirma a transação.
3. [validacao.sql](validacao.sql): confere contagens e inconsistências.
4. [queries.sql](queries.sql): cinco consultas com JOIN e agregações.

O povoamento usa comandos de SQL*Plus/SQL Developer para interromper e desfazer a transação em caso de erro. Reexecuções falham por PK; use outro esquema vazio. Não há rotina de limpeza destrutiva automática.

## Dados e resultados esperados

| Tabela | Registros |
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

Q1: questionários 1, 2, 3 e 4 devem apresentar, respectivamente, senhas geradas 6/4/2/0, utilizadas 5/3/1/0, submissões 5/3/1/0 e participação 83,33%/75%/50%/0%.

Q2: alternativas do questionário 1 = 3/1/1; questionário 2 = 2/1/0; questionário 3 = 0/0/1. Q3: médias 4/4/2/NULL, com 5/3/1/0 avaliações. Q4: pesquisa 1 possui 3 respostas abertas, 8 de escala e 8 de múltipla escolha; pesquisa 2 possui 0/1/1. Q5: somente questionário 1, pergunta 2, com 5 avaliações e média 4.

As consultas Q1–Q4 são internas e de demonstração. Q5 mostra supressão de grupos pequenos, sem assegurar anonimização por si só. Não publicar textos livres ou cruzamentos identificáveis.

## Limites do modelo existente

As FKs não impedem duplicar uma resposta por submissão/pergunta, ligar alternativa à pergunta errada ou registrar tipos incompatíveis. O campo codigo não possui UNIQUE e armazena o código em claro. O backend futuro precisará aplicar constraints e transação atômica, proteger códigos e impedir correlação por timestamps. [Análise detalhada](../seguranca/lgpd-e-anonimato.md).

Validação executada e limitações estão em [validacao-final.md](../validacao-final.md). Não foi executado Oracle neste ambiente.

[Voltar ao projeto](../../README.md).
