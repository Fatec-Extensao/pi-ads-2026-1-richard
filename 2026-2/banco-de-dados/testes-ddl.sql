-- Issue #4 | Oracle SQL Developer: execute como script (F5).
-- Pre-requisito: schema.sql ja executado em esquema de TESTES.
-- Nao execute em producao. IDs 900001..900099 reservados para este teste.
-- As linhas de teste sao removidas no fim com ROLLBACK TO.
-- Os erros da secao NEGATIVA sao ESPERADOS; confira os codigos no documento.
WHENEVER SQLERROR CONTINUE
SET DEFINE OFF

-- 1. Inventario: esperar 12 tabelas, 12 PKs, 14 FKs, 8 UQs e 13 CHECKs nomeados.
SELECT table_name FROM user_tables
WHERE table_name IN ('PERFIL', 'USUARIO', 'PESQUISA', 'CATEGORIA', 'QUESTIONARIO', 'PERGUNTA', 'ALTERNATIVA', 'LOTE_SENHA', 'SENHA_ACESSO', 'SUBMISSAO', 'RESPOSTA', 'AUDITORIA')
ORDER BY table_name;

SELECT constraint_type, COUNT(*) AS quantidade FROM user_constraints
WHERE table_name IN ('PERFIL', 'USUARIO', 'PESQUISA', 'CATEGORIA', 'QUESTIONARIO', 'PERGUNTA', 'ALTERNATIVA', 'LOTE_SENHA', 'SENHA_ACESSO', 'SUBMISSAO', 'RESPOSTA', 'AUDITORIA')
  AND (constraint_type IN ('P', 'R', 'U')
       OR (constraint_type = 'C' AND constraint_name LIKE 'CK\_%' ESCAPE '\'))
GROUP BY constraint_type ORDER BY constraint_type;

-- Esperar zero linhas: nenhuma constraint do modelo desabilitada ou sem validacao.
SELECT table_name, constraint_name, status, validated FROM user_constraints
WHERE table_name IN ('PERFIL', 'USUARIO', 'PESQUISA', 'CATEGORIA', 'QUESTIONARIO', 'PERGUNTA', 'ALTERNATIVA', 'LOTE_SENHA', 'SENHA_ACESSO', 'SUBMISSAO', 'RESPOSTA', 'AUDITORIA')
  AND (status <> 'ENABLED' OR validated <> 'VALIDATED');

SAVEPOINT teste_ddl;

-- 2. CASOS POSITIVOS: todas as insercoes abaixo devem ser aceitas.
INSERT INTO perfil VALUES (900001, 'Perfil teste DDL');
INSERT INTO usuario VALUES (900001, 900001, 'Usuario ficticio', 'ddl@example.test', 'HASH_FICTICIO', 1);
INSERT INTO pesquisa VALUES (900001, 900001, 'Pesquisa teste DDL', NULL, DATE '2026-11-01', DATE '2026-11-30', 'ABERTA');
INSERT INTO categoria VALUES (900001, 'Categoria teste DDL', 'T', NULL);
INSERT INTO questionario VALUES (900001, 900001, 900001, 'Questionario teste DDL', NULL, 1);
INSERT INTO pergunta VALUES (900001, 900001, 'Escolha uma opcao', 'MULTIPLA_ESCOLHA', 1, 1);
INSERT INTO pergunta VALUES (900002, 900001, 'Informe uma nota', 'ESCALA', 2, 1);
INSERT INTO pergunta VALUES (900003, 900001, 'Comentario opcional', 'ABERTA', 3, 0);
INSERT INTO pergunta VALUES (900004, 900001, 'Outra escolha', 'MULTIPLA_ESCOLHA', 4, 0);
INSERT INTO alternativa VALUES (1, 900001, 'Opcao da primeira pergunta', 1);
INSERT INTO alternativa VALUES (1, 900004, 'Opcao de outra pergunta', 1);
INSERT INTO lote_senha VALUES (900001, 900001, 900001, DATE '2026-11-01');
INSERT INTO senha_acesso VALUES (900001, 900001, 'TST40001', 'DISPONIVEL', NULL);
INSERT INTO submissao VALUES (900001, 900001, DATE '2026-11-10');
INSERT INTO submissao VALUES (900002, 900001, DATE '2026-11-10');
INSERT INTO resposta VALUES (900001, 900001, 900001, 1, NULL, NULL);
INSERT INTO resposta VALUES (900002, 900001, 900002, NULL, 4, NULL);
INSERT INTO resposta VALUES (900003, 900001, 900003, NULL, NULL, 'Texto ficticio de teste');
INSERT INTO auditoria VALUES (900001, 900001, 'TESTE_DDL', 'pesquisa', 900001, DATE '2026-11-10');

-- Deve retornar tres respostas e duas alternativas com numero 1 em perguntas distintas.
SELECT COUNT(*) AS respostas_teste FROM resposta WHERE id_submissao = 900001;
SELECT id_pergunta, id_alternativa FROM alternativa WHERE id_pergunta IN (900001, 900004) ORDER BY id_pergunta;

-- 3. CASOS NEGATIVOS: cada comando deve falhar pelo motivo indicado.
-- N1: PK duplicada -> ORA-00001.
INSERT INTO perfil VALUES (900001, 'Outro perfil teste');
-- N2: FK para perfil inexistente -> ORA-02291.
INSERT INTO usuario VALUES (900002, 999999999, 'Orfao ficticio', 'orfao@example.test', 'HASH_FICTICIO', 1);
-- N3: NOT NULL -> ORA-01400.
INSERT INTO perfil VALUES (900002, NULL);
-- N4: email duplicado -> ORA-00001.
INSERT INTO usuario VALUES (900003, 900001, 'Duplicado ficticio', 'ddl@example.test', 'HASH_FICTICIO', 1);
-- N5: nota fora de 1..5 -> ORA-02290.
INSERT INTO resposta VALUES (900004, 900002, 900002, NULL, 6, NULL);
-- N6: alternativa nao existe nessa pergunta -> ORA-02291 (FK composta).
INSERT INTO resposta VALUES (900005, 900002, 900002, 1, NULL, NULL);
-- N7: resposta repetida por submissao/pergunta -> ORA-00001.
INSERT INTO resposta VALUES (900006, 900001, 900001, 1, NULL, NULL);
-- N8: dois campos de conteudo preenchidos -> ORA-02290.
INSERT INTO resposta VALUES (900007, 900002, 900003, NULL, 4, 'Dois valores');
-- N9: periodo invertido -> ORA-02290.
INSERT INTO pesquisa VALUES (900002, 900001, 'Periodo invalido', NULL, DATE '2026-11-30', DATE '2026-11-01', 'ABERTA');
-- N10: pai com dependentes -> ORA-02292.
DELETE FROM perfil WHERE id_perfil = 900001;

-- 4. FIM: desfaz somente os dados criados depois deste savepoint.
ROLLBACK TO teste_ddl;
-- Resultado esperado: zero.
SELECT COUNT(*) AS registros_teste_restantes FROM perfil WHERE id_perfil = 900001;
