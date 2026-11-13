# Modelo lógico relacional

Issue #4 · Banco de Dados I · Prof. Luiz Fernando de Oliveira Silva.

Projeto: Sistema Web para Gestão de Pesquisas por Questionários. SGBD escolhido: Oracle. Autor da entrega: Richard de Oliveira Barra Junior.

## Origem e decisões de conversão

Este modelo desenvolve as entidades, os atributos e os relacionamentos já registrados em [bd o.txt](bd%20o.txt). Esse arquivo contém a descrição do MER anterior e o mapeamento de origem. A figura do DER não foi localizada nesta pasta; a equivalência com uma eventual imagem externa deve ser conferida pelo grupo. O esquema abaixo é o modelo lógico adotado nesta entrega, e os tipos Oracle constituem seu mapeamento físico.

- Cada entidade dá origem a uma tabela. As relações 1:N recebem a FK no lado N.
- Cada linha possui PK. Campos obrigatórios recebem NOT NULL.
- A identidade de alternativa passa a ser local à pergunta: PK (id_pergunta, id_alternativa). Assim, a alternativa 1 pode existir em perguntas diferentes. A referência em resposta usa essas duas colunas.
- A resposta por submissão/pergunta é única. Não se guardam nomes de perfil, categoria ou pergunta como cópias nas tabelas filhas.
- Submissão não contém id_usuario, id_senha nem codigo. Isso evita vínculo direto com a identificação, mas não garante anonimato contra texto livre e metadados.

## Tabelas e dicionário de dados

PK = chave primária; FK = chave estrangeira; UQ = combinação única. “Sim” na coluna Obrigatório significa NOT NULL. As colunas de PK são obrigatórias.

### 1. perfil

PK: (id_perfil).

| Coluna | Tipo Oracle | Obrigatório | Chave / referência |
| --- | --- | --- | --- |
| id_perfil | NUMBER(10) | Sim | PK |
| nome | VARCHAR2(50) | Sim | — |

Combinações únicas: (nome).

### 2. usuario

PK: (id_usuario).

| Coluna | Tipo Oracle | Obrigatório | Chave / referência |
| --- | --- | --- | --- |
| id_usuario | NUMBER(10) | Sim | PK |
| id_perfil | NUMBER(10) | Sim | FK para perfil (id_perfil) |
| nome | VARCHAR2(120) | Sim | — |
| email | VARCHAR2(180) | Sim | — |
| senha_hash | VARCHAR2(255) | Sim | — |
| ativo | NUMBER(1) | Sim | — |

Combinações únicas: (email).

### 3. pesquisa

PK: (id_pesquisa).

| Coluna | Tipo Oracle | Obrigatório | Chave / referência |
| --- | --- | --- | --- |
| id_pesquisa | NUMBER(10) | Sim | PK |
| id_criador | NUMBER(10) | Sim | FK para usuario (id_usuario) |
| titulo | VARCHAR2(200) | Sim | — |
| descricao | VARCHAR2(4000) | Não | — |
| data_inicio | DATE | Sim | — |
| data_fim | DATE | Sim | — |
| status | VARCHAR2(15) | Sim | — |

### 4. categoria

PK: (id_categoria).

| Coluna | Tipo Oracle | Obrigatório | Chave / referência |
| --- | --- | --- | --- |
| id_categoria | NUMBER(10) | Sim | PK |
| nome | VARCHAR2(100) | Sim | — |
| codigo | VARCHAR2(1) | Sim | — |
| descricao | VARCHAR2(4000) | Não | — |

Combinações únicas: (nome); (codigo).

### 5. questionario

PK: (id_questionario).

| Coluna | Tipo Oracle | Obrigatório | Chave / referência |
| --- | --- | --- | --- |
| id_questionario | NUMBER(10) | Sim | PK |
| id_pesquisa | NUMBER(10) | Sim | FK para pesquisa (id_pesquisa) |
| id_categoria | NUMBER(10) | Sim | FK para categoria (id_categoria) |
| titulo | VARCHAR2(200) | Sim | — |
| descricao | VARCHAR2(4000) | Não | — |
| ativo | NUMBER(1) | Sim | — |

### 6. pergunta

PK: (id_pergunta).

| Coluna | Tipo Oracle | Obrigatório | Chave / referência |
| --- | --- | --- | --- |
| id_pergunta | NUMBER(10) | Sim | PK |
| id_questionario | NUMBER(10) | Sim | FK para questionario (id_questionario) |
| enunciado | VARCHAR2(4000) | Sim | — |
| tipo | VARCHAR2(20) | Sim | — |
| ordem | NUMBER(10) | Sim | — |
| obrigatoria | NUMBER(1) | Sim | — |

Combinações únicas: (id_questionario, ordem).

### 7. alternativa

PK: (id_pergunta, id_alternativa).

| Coluna | Tipo Oracle | Obrigatório | Chave / referência |
| --- | --- | --- | --- |
| id_alternativa | NUMBER(10) | Sim | PK |
| id_pergunta | NUMBER(10) | Sim | PK; FK para pergunta (id_pergunta) |
| texto | VARCHAR2(500) | Sim | — |
| ordem | NUMBER(10) | Sim | — |

Combinações únicas: (id_pergunta, ordem).

### 8. lote_senha

PK: (id_lote).

| Coluna | Tipo Oracle | Obrigatório | Chave / referência |
| --- | --- | --- | --- |
| id_lote | NUMBER(10) | Sim | PK |
| id_questionario | NUMBER(10) | Sim | FK para questionario (id_questionario) |
| id_gerador | NUMBER(10) | Sim | FK para usuario (id_usuario) |
| gerado_em | DATE | Sim | — |

### 9. senha_acesso

PK: (id_senha).

| Coluna | Tipo Oracle | Obrigatório | Chave / referência |
| --- | --- | --- | --- |
| id_senha | NUMBER(10) | Sim | PK |
| id_lote | NUMBER(10) | Sim | FK para lote_senha (id_lote) |
| codigo | VARCHAR2(8) | Sim | — |
| status | VARCHAR2(15) | Sim | — |
| utilizada_em | DATE | Não | — |

Combinações únicas: (codigo).

### 10. submissao

PK: (id_submissao).

| Coluna | Tipo Oracle | Obrigatório | Chave / referência |
| --- | --- | --- | --- |
| id_submissao | NUMBER(10) | Sim | PK |
| id_questionario | NUMBER(10) | Sim | FK para questionario (id_questionario) |
| enviada_em | DATE | Sim | — |

### 11. resposta

PK: (id_resposta).

| Coluna | Tipo Oracle | Obrigatório | Chave / referência |
| --- | --- | --- | --- |
| id_resposta | NUMBER(10) | Sim | PK |
| id_submissao | NUMBER(10) | Sim | FK para submissao (id_submissao) |
| id_pergunta | NUMBER(10) | Sim | FK para pergunta (id_pergunta); FK para alternativa (id_pergunta, id_alternativa) — parte de referência composta |
| id_alternativa | NUMBER(10) | Não | FK para alternativa (id_pergunta, id_alternativa) — parte de referência composta |
| nota_escala | NUMBER(1) | Não | — |
| texto_aberto | VARCHAR2(4000) | Não | — |

Combinações únicas: (id_submissao, id_pergunta).

### 12. auditoria

PK: (id_auditoria).

| Coluna | Tipo Oracle | Obrigatório | Chave / referência |
| --- | --- | --- | --- |
| id_auditoria | NUMBER(10) | Sim | PK |
| id_usuario | NUMBER(10) | Sim | FK para usuario (id_usuario) |
| acao | VARCHAR2(80) | Sim | — |
| entidade | VARCHAR2(80) | Sim | — |
| id_registro | NUMBER(10) | Não | — |
| realizado_em | DATE | Sim | — |

## Relações e cardinalidades

| Tabela pai | Tabela filha | FK na filha | Cardinalidade |
| --- | --- | --- | --- |
| perfil | usuario | id_perfil | Um pai pode ter 0..N filhos; cada filho referencia exatamente 1 pai |
| usuario | pesquisa | id_criador | Um pai pode ter 0..N filhos; cada filho referencia exatamente 1 pai |
| pesquisa | questionario | id_pesquisa | Um pai pode ter 0..N filhos; cada filho referencia exatamente 1 pai |
| categoria | questionario | id_categoria | Um pai pode ter 0..N filhos; cada filho referencia exatamente 1 pai |
| questionario | pergunta | id_questionario | Um pai pode ter 0..N filhos; cada filho referencia exatamente 1 pai |
| pergunta | alternativa | id_pergunta | Um pai pode ter 0..N filhos; cada filho referencia exatamente 1 pai |
| questionario | lote_senha | id_questionario | Um pai pode ter 0..N filhos; cada filho referencia exatamente 1 pai |
| usuario | lote_senha | id_gerador | Um pai pode ter 0..N filhos; cada filho referencia exatamente 1 pai |
| lote_senha | senha_acesso | id_lote | Um pai pode ter 0..N filhos; cada filho referencia exatamente 1 pai |
| questionario | submissao | id_questionario | Um pai pode ter 0..N filhos; cada filho referencia exatamente 1 pai |
| submissao | resposta | id_submissao | Um pai pode ter 0..N filhos; cada filho referencia exatamente 1 pai |
| pergunta | resposta | id_pergunta | Um pai pode ter 0..N filhos; cada filho referencia exatamente 1 pai |
| alternativa | resposta | id_pergunta, id_alternativa | Um pai pode ter 0..N filhos; cada filho pode referenciar 0..1 alternativa |
| usuario | auditoria | id_usuario | Um pai pode ter 0..N filhos; cada filho referencia exatamente 1 pai |

Na FK composta resposta → alternativa, id_alternativa pode ser NULL quando o conteúdo é nota ou texto. Quando preenchida, a combinação deve existir em alternativa. O CHECK exige exatamente um campo de conteúdo preenchido.

## Regras de domínio e integridade

- Flags ativo e obrigatoria aceitam 0 ou 1.
- data_fim não pode ser anterior a data_inicio. Pesquisa admite RASCUNHO, ABERTA ou ENCERRADA.
- Tipos: MULTIPLA_ESCOLHA (uma opção), ESCALA (1 a 5) ou ABERTA.
- Ordem é positiva e única dentro de cada questionário ou pergunta, conforme a tabela.
- Códigos possuem oito caracteres, são únicos e têm estado coerente com utilizada_em.
- E-mail administrativo é único segundo a comparação de strings da configuração Oracle. Este modelo não implementa normalização de maiúsculas/minúsculas.
- Exclusão de pai referenciado é bloqueada pelas FKs, sem ON DELETE CASCADE.

## Limites que exigem validação adicional

O DDL não verifica por si só que a pergunta pertence ao mesmo questionário da submissão, nem que o campo escolhido corresponde ao tipo da pergunta. São regras entre tabelas que devem ser validadas pelo backend ou por implementação específica posterior. O CHECK desta entrega garante somente o formato de conteúdo exclusivo; a FK composta também garante que a alternativa pertence à pergunta informada. A validação completa de perguntas obrigatórias e o consumo atômico de códigos continuam responsabilidade da aplicação futura.

O campo auditoria.id_registro é uma referência informativa a diferentes tipos de entidade, sem FK genérica. Não se usa essa coluna para relacionar respostas a códigos.

## Arquivos relacionados

- [Normalização até a 3FN](normalizacao-3fn.md).
- [DDL completo](schema.sql).
- [Teste do DDL no Oracle](testes-ddl.sql).
- [Registro de validação](validacao-ddl.md).

## Referência técnica

[Oracle Database — constraints](https://docs.oracle.com/en/database/oracle/oracle-database/21/sqlrf/constraint.html). Consulta em 13/11/2026.
