# Validação do DDL — Issue #4

Data: 13/11/2026. SGBD de destino: Oracle. Esta entrega não registra uma execução Oracle que não ocorreu.

## O que foi executado neste ambiente

| Verificação | Resultado |
| --- | --- |
| Estrutura do DDL | 12 CREATE TABLE, 12 PKs, 14 FKs via ALTER TABLE, 8 UNIQUEs e 13 CHECKs nomeados. |
| Inserções válidas no adaptador | 19 comandos aceitos. Três respostas registradas e duas alternativas com número 1 em perguntas diferentes. |
| Dados inválidos no adaptador | Dez comandos rejeitados pelos tipos de restrição esperados. |
| Rollback dos testes | Nenhum registro de perfil de teste permaneceu. |
| Compatibilidade com a Issue #5 | Povoamento completo aceito, seis verificações de consistência sem ocorrências e resultados das cinco consultas mantidos. |

Essas verificações ocorreram em SQLite/WASM. O [adaptador](../../tests/ddl-adapter.cjs) reposiciona FKs de ALTER TABLE para CREATE TABLE, pois o SQLite não admite essa forma de ADD CONSTRAINT. O teste das consultas também adapta DATE, NVL e divisão numérica. Isso valida comportamento no adaptador e compatibilidade dos dados, sem comprovar sintaxe ou comportamento do Oracle.

## Como concluir a comprovação no Oracle

1. Abra o SQL Developer e conecte a um esquema de testes vazio, com permissão para criar tabelas.
2. Execute [schema.sql](schema.sql) como script (F5). Esperado: 12 criações de tabela e 14 alterações concluídas sem erro.
3. Execute [testes-ddl.sql](testes-ddl.sql) como script (F5). Confira o inventário, os casos positivos e os erros esperados abaixo.
4. No teste, as primeiras inserções devem ser aceitas. As três respostas aparecem e o número 1 pode existir em duas perguntas distintas. O rollback final deve deixar zero perfis de teste.
5. Registre neste documento versão do Oracle, data, resultados e eventuais erros. Somente então marque o item de execução Oracle da issue como concluído.

Se já houver tabelas com os mesmos nomes, não rode o DDL por cima. Use outro esquema de testes. Não há DROP TABLE automático nesta entrega. Se uma criação falhar, interrompa, corrija o problema e não interprete criações parciais como sucesso integral.

## Casos negativos do arquivo de teste

| Caso | Tentativa inválida | Erro Oracle esperado |
| --- | --- | --- |
| N1 | PK duplicada | ORA-00001 |
| N2 | Usuário com perfil inexistente | ORA-02291 |
| N3 | Nome obrigatório nulo | ORA-01400 |
| N4 | E-mail administrativo repetido | ORA-00001 |
| N5 | Nota 6 em escala de 1 a 5 | ORA-02290 |
| N6 | Alternativa que não pertence à pergunta informada | ORA-02291 |
| N7 | Duas respostas para a mesma submissão/pergunta | ORA-00001 |
| N8 | Nota e texto preenchidos na mesma resposta | ORA-02290 |
| N9 | Período invertido | ORA-02290 |
| N10 | Exclusão de perfil usado por usuário | ORA-02292 |

O teste usa WHENEVER SQLERROR CONTINUE para permitir todos esses casos na mesma execução. Não se espera execução inteira sem mensagens de erro: as dez rejeições são parte do teste. O motivo de cada erro deve coincidir com a tabela.

## Registro da execução Oracle

- Estado: **pendente**.
- Versão do Oracle: a preencher após a execução.
- Ferramenta/versão: a preencher após a execução.
- Data e responsável: a preencher após a execução.
- Resultado do DDL: a preencher após a execução.
- Resultado dos casos positivos, negativos e rollback: a preencher após a execução.

## Saída efetiva dos testes locais

As saídas a seguir pertencem ao adaptador SQLite/WASM e não são logs Oracle.

### check-ddl.cjs

```json
{
  "engine": "SQLite/WASM; FKs convertidas de ALTER TABLE para CREATE TABLE. Não executado em Oracle.",
  "tables": [
    "alternativa",
    "auditoria",
    "categoria",
    "lote_senha",
    "perfil",
    "pergunta",
    "pesquisa",
    "questionario",
    "resposta",
    "senha_acesso",
    "submissao",
    "usuario"
  ],
  "constraints": {
    "P": 12,
    "R": 14,
    "U": 8,
    "C": 13
  },
  "positiveInserts": 19,
  "negativeCases": [
    {
      "case": "N1",
      "result": "rejeitado",
      "reason": "UNIQUE constraint failed: perfil.id_perfil"
    },
    {
      "case": "N2",
      "result": "rejeitado",
      "reason": "FOREIGN KEY constraint failed"
    },
    {
      "case": "N3",
      "result": "rejeitado",
      "reason": "NOT NULL constraint failed: perfil.nome"
    },
    {
      "case": "N4",
      "result": "rejeitado",
      "reason": "UNIQUE constraint failed: usuario.email"
    },
    {
      "case": "N5",
      "result": "rejeitado",
      "reason": "CHECK constraint failed: ck_resposta_escala"
    },
    {
      "case": "N6",
      "result": "rejeitado",
      "reason": "FOREIGN KEY constraint failed"
    },
    {
      "case": "N7",
      "result": "rejeitado",
      "reason": "UNIQUE constraint failed: resposta.id_submissao, resposta.id_pergunta"
    },
    {
      "case": "N8",
      "result": "rejeitado",
      "reason": "CHECK constraint failed: ck_resposta_um_valor"
    },
    {
      "case": "N9",
      "result": "rejeitado",
      "reason": "CHECK constraint failed: ck_pesquisa_periodo"
    },
    {
      "case": "N10",
      "result": "rejeitado",
      "reason": "FOREIGN KEY constraint failed"
    }
  ],
  "rollback": "sem registros de teste restantes"
}
```

### check-db.cjs

```json
{
  "engine": "SQLite WASM com adaptação de DATE/NVL, localização das FKs e divisão numérica; Oracle não executado",
  "tables": {
    "perfil": 3,
    "usuario": 3,
    "pesquisa": 2,
    "categoria": 3,
    "questionario": 4,
    "pergunta": 10,
    "alternativa": 9,
    "lote_senha": 3,
    "senha_acesso": 12,
    "submissao": 9,
    "resposta": 21,
    "auditoria": 2
  },
  "queries": [
    {
      "query": 1,
      "columns": [
        "pesquisa",
        "categoria",
        "id_questionario",
        "senhas_geradas",
        "senhas_utilizadas",
        "submissoes",
        "participacao_pct"
      ],
      "rows": [
        [
          "Avaliação dos serviços acadêmicos",
          "Alunos",
          1,
          6,
          5,
          5,
          83.33
        ],
        [
          "Avaliação dos serviços acadêmicos",
          "Professores",
          2,
          4,
          3,
          3,
          75
        ],
        [
          "Avaliação dos serviços acadêmicos",
          "Funcionários",
          4,
          0,
          0,
          0,
          0
        ],
        [
          "Avaliação do ambiente de trabalho",
          "Funcionários",
          3,
          2,
          1,
          1,
          50
        ]
      ]
    },
    {
      "query": 2,
      "columns": [
        "id_questionario",
        "id_pergunta",
        "enunciado",
        "alternativa",
        "quantidade"
      ],
      "rows": [
        [
          1,
          1,
          "Como você avalia o serviço?",
          "Bom",
          3
        ],
        [
          1,
          1,
          "Como você avalia o serviço?",
          "Regular",
          1
        ],
        [
          1,
          1,
          "Como você avalia o serviço?",
          "Ruim",
          1
        ],
        [
          2,
          4,
          "Como você avalia o serviço?",
          "Bom",
          2
        ],
        [
          2,
          4,
          "Como você avalia o serviço?",
          "Regular",
          1
        ],
        [
          2,
          4,
          "Como você avalia o serviço?",
          "Ruim",
          0
        ],
        [
          3,
          7,
          "Como você avalia o serviço?",
          "Bom",
          0
        ],
        [
          3,
          7,
          "Como você avalia o serviço?",
          "Regular",
          0
        ],
        [
          3,
          7,
          "Como você avalia o serviço?",
          "Ruim",
          1
        ]
      ]
    },
    {
      "query": 3,
      "columns": [
        "pesquisa",
        "categoria",
        "id_pergunta",
        "avaliacoes",
        "media",
        "menor_nota",
        "maior_nota"
      ],
      "rows": [
        [
          "Avaliação dos serviços acadêmicos",
          "Alunos",
          2,
          5,
          4,
          2,
          5
        ],
        [
          "Avaliação dos serviços acadêmicos",
          "Professores",
          5,
          3,
          4,
          3,
          5
        ],
        [
          "Avaliação dos serviços acadêmicos",
          "Funcionários",
          10,
          0,
          null,
          null,
          null
        ],
        [
          "Avaliação do ambiente de trabalho",
          "Funcionários",
          8,
          1,
          2,
          2,
          2
        ]
      ]
    },
    {
      "query": 4,
      "columns": [
        "pesquisa",
        "tipo",
        "respostas"
      ],
      "rows": [
        [
          "Avaliação dos serviços acadêmicos",
          "ABERTA",
          3
        ],
        [
          "Avaliação dos serviços acadêmicos",
          "ESCALA",
          8
        ],
        [
          "Avaliação dos serviços acadêmicos",
          "MULTIPLA_ESCOLHA",
          8
        ],
        [
          "Avaliação do ambiente de trabalho",
          "ABERTA",
          0
        ],
        [
          "Avaliação do ambiente de trabalho",
          "ESCALA",
          1
        ],
        [
          "Avaliação do ambiente de trabalho",
          "MULTIPLA_ESCOLHA",
          1
        ]
      ]
    },
    {
      "query": 5,
      "columns": [
        "id_questionario",
        "categoria",
        "id_pergunta",
        "avaliacoes",
        "media"
      ],
      "rows": [
        [
          1,
          "Alunos",
          2,
          5,
          4
        ]
      ]
    }
  ],
  "integrityChecks": 6
}
```

## Referências técnicas

- [Oracle Database — constraints](https://docs.oracle.com/en/database/oracle/oracle-database/21/sqlrf/constraint.html).
- [SQL Developer — execução de scripts](https://docs.oracle.com/en/database/oracle/sql-developer/21.2/rptug/sql-developer-concepts-usage.html).

[Modelo lógico](modelo-logico.md) · [Normalização](normalizacao-3fn.md) · [Orientações do banco](readme.md).
