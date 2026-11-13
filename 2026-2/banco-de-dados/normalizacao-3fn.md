# Normalização até a Terceira Forma Normal (3FN)

Issue #4 · Sistema Web para Gestão de Pesquisas por Questionários.

## 1. Objetivo e critérios

Normalizar organiza os fatos em tabelas para evitar cópias desnecessárias e anomalias de inserção, atualização e exclusão. A avaliação considera as dependências funcionais do domínio e todas as chaves candidatas, não apenas a existência de um ID artificial.

Um registro amplo de pesquisa poderia repetir nome do criador, nome da categoria, enunciado da pergunta e texto da alternativa em cada resposta. Ao mudar uma categoria, seria necessário atualizar várias cópias. A separação em entidades do [modelo lógico](modelo-logico.md) evita esse problema.

## 2. Primeira Forma Normal (1FN)

Cada campo guarda um valor do domínio da coluna, sem listas repetidas. Perguntas ficam em linhas da tabela pergunta; alternativas ficam em linhas da tabela alternativa. Não há colunas pergunta1/pergunta2 ou alternativa1/alternativa2 no questionário. Um comentário é um valor textual, não uma lista de respostas codificada em uma célula.

Uma submissão reúne várias respostas por meio da relação submissao → resposta. Cada resposta guarda somente uma alternativa, uma nota ou um texto. Múltipla escolha nesta versão significa selecionar uma única opção.

## 3. Segunda Forma Normal (2FN)

O modelo atende à 1FN e nenhum atributo não primo depende de parte de uma chave candidata composta.

Em alternativa, a PK é (id_pergunta, id_alternativa). O número da alternativa é local à pergunta: alternativa 1 da pergunta 10 pode ter texto diferente da alternativa 1 da pergunta 20. Texto e ordem dependem da combinação completa. A outra chave candidata é (id_pergunta, ordem), também com dependência completa.

Em pergunta, existe a PK simples id_pergunta e a chave candidata (id_questionario, ordem). Enunciado, tipo e obrigatoriedade dependem da pergunta identificada pela combinação completa. Em resposta, a combinação (id_submissao, id_pergunta) identifica uma única resposta e determina seu conteúdo. Nenhuma dessas duas colunas isoladas identifica a resposta.

As demais tabelas possuem chaves candidatas simples nas regras adotadas. Nenhuma dependência parcial é introduzida por elas.

## 4. Terceira Forma Normal (3FN)

O modelo atende à 2FN. Para as dependências funcionais não triviais assumidas nesta entrega, o determinante é uma superchave ou o atributo determinado é primo. Não se mantêm atributos descritivos dependentes de outro atributo não chave dentro da mesma relação.

| Dependência que causaria repetição | Decisão do modelo |
| --- | --- |
| id_usuario → id_perfil → nome do perfil | Nome fica em perfil; usuario guarda somente id_perfil. |
| id_questionario → id_categoria → nome/código da categoria | Nome e código ficam em categoria. |
| id_questionario → id_pesquisa → datas e título da pesquisa | Datas e título da pesquisa ficam em pesquisa. O título de questionario descreve o questionário, um fato distinto. |
| id_resposta → id_pergunta → enunciado/tipo | Enunciado e tipo ficam em pergunta. |
| Resposta com opção → descrição da alternativa | Texto da opção fica em alternativa. A resposta guarda somente a referência composta. |

### Ajuste da identificação de alternativa

Se id_alternativa fosse globalmente único e a resposta armazenasse também id_pergunta, o ID global da alternativa determinaria a pergunta nas respostas de escolha. Haveria informação derivável armazenada novamente. A normalização adota ID de alternativa **local à pergunta**, com PK e FK compostas. Não existe UNIQUE isolado em id_alternativa. Assim, ele não determina sozinho id_pergunta.

Esse ajuste mantém as 12 tabelas e as colunas existentes. Os INSERTs da Issue #5 continuam válidos, pois seus IDs já formam combinações válidas. Consultas que relacionem resposta e alternativa devem usar as duas colunas. A consulta Q2 já faz essa combinação; validacao.sql foi atualizada nesta entrega.

## 5. Dependências funcionais adotadas

Cada determinante abaixo define os demais atributos da mesma tabela, omitidos à direita para evitar repetição do dicionário.

| Relação | Determinantes / chaves candidatas |
| --- | --- |
| perfil | id_perfil; nome |
| usuario | id_usuario; email |
| pesquisa | id_pesquisa |
| categoria | id_categoria; nome; codigo |
| questionario | id_questionario |
| pergunta | id_pergunta; (id_questionario, ordem) |
| alternativa | (id_pergunta, id_alternativa); (id_pergunta, ordem) |
| lote_senha | id_lote |
| senha_acesso | id_senha; codigo |
| submissao | id_submissao |
| resposta | id_resposta; (id_submissao, id_pergunta) |
| auditoria | id_auditoria |

Considera-se que nomes de perfis e categorias são únicos no cadastro. Não se assume, por exemplo, que todo questionário de uma categoria terá sempre o mesmo título ou que um usuário só poderá criar uma pesquisa. Essas dependências não fazem parte das regras do projeto.

## 6. Conclusão e limites

O modelo resultante atende à 3FN sob as dependências explicitadas. A normalização não comprova regras entre tabelas, anonimato, autenticação ou ausência de dados inválidos. Esses aspectos exigem constraints adicionais ou validação da aplicação, conforme os limites descritos em modelo-logico.md.

## Referências

- [Oracle — projeto de diagramas ER e normalização](https://github.com/oracle/skills/blob/main/db/design/erd-design.md).
- [Oracle Database — chaves e restrições](https://docs.oracle.com/en/database/oracle/oracle-database/21/sqlrf/constraint.html).

Consulta em 13/11/2026.
