-- Execute após schema.sql e povoamento.sql. Cada contagem deve coincidir.
SELECT 'perfil' AS tabela, COUNT(*) AS obtido, 3 AS esperado FROM perfil;
SELECT 'usuario' AS tabela, COUNT(*) AS obtido, 3 AS esperado FROM usuario;
SELECT 'pesquisa' AS tabela, COUNT(*) AS obtido, 2 AS esperado FROM pesquisa;
SELECT 'categoria' AS tabela, COUNT(*) AS obtido, 3 AS esperado FROM categoria;
SELECT 'questionario' AS tabela, COUNT(*) AS obtido, 4 AS esperado FROM questionario;
SELECT 'pergunta' AS tabela, COUNT(*) AS obtido, 10 AS esperado FROM pergunta;
SELECT 'alternativa' AS tabela, COUNT(*) AS obtido, 9 AS esperado FROM alternativa;
SELECT 'lote_senha' AS tabela, COUNT(*) AS obtido, 3 AS esperado FROM lote_senha;
SELECT 'senha_acesso' AS tabela, COUNT(*) AS obtido, 12 AS esperado FROM senha_acesso;
SELECT 'submissao' AS tabela, COUNT(*) AS obtido, 9 AS esperado FROM submissao;
SELECT 'resposta' AS tabela, COUNT(*) AS obtido, 21 AS esperado FROM resposta;
SELECT 'auditoria' AS tabela, COUNT(*) AS obtido, 2 AS esperado FROM auditoria;

-- Todas as verificações abaixo devem retornar ZERO linhas.
-- Consistência de origem das respostas (FKs simples não cobrem essa regra).
SELECT r.id_resposta FROM resposta r
JOIN submissao s ON s.id_submissao = r.id_submissao
JOIN pergunta p ON p.id_pergunta = r.id_pergunta
LEFT JOIN alternativa a ON a.id_alternativa = r.id_alternativa
                         AND a.id_pergunta = r.id_pergunta
WHERE s.id_questionario <> p.id_questionario
   OR (r.id_alternativa IS NOT NULL AND a.id_alternativa IS NULL);

SELECT id_submissao, id_pergunta FROM resposta
GROUP BY id_submissao, id_pergunta HAVING COUNT(*) > 1;

SELECT codigo FROM senha_acesso GROUP BY codigo HAVING COUNT(*) > 1;

SELECT id_resposta FROM resposta
WHERE (CASE WHEN id_alternativa IS NOT NULL THEN 1 ELSE 0 END
     + CASE WHEN nota_escala IS NOT NULL THEN 1 ELSE 0 END
     + CASE WHEN texto_aberto IS NOT NULL THEN 1 ELSE 0 END) <> 1
   OR (nota_escala IS NOT NULL AND nota_escala NOT BETWEEN 1 AND 5);

SELECT s.id_senha FROM senha_acesso s
WHERE (s.status = 'UTILIZADA' AND s.utilizada_em IS NULL)
   OR (s.status = 'DISPONIVEL' AND s.utilizada_em IS NOT NULL);

-- Cada submissão possui uma resposta por pergunta obrigatória.
SELECT s.id_submissao, p.id_pergunta FROM submissao s
JOIN pergunta p ON p.id_questionario = s.id_questionario AND p.obrigatoria = 1
LEFT JOIN resposta r ON r.id_submissao = s.id_submissao AND r.id_pergunta = p.id_pergunta
WHERE r.id_resposta IS NULL;
