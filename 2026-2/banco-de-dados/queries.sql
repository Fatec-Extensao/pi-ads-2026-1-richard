-- Issue #5 | Consultas Oracle | Somente dados fictícios ou acesso interno autorizado.
-- Não publicar os resultados detalhados de grupos pequenos nem textos livres reais.

-- Q1. Participação por pesquisa/categoria. Pré-agregação evita produto entre
-- senhas, submissões e respostas. Mantém questionários sem participação.
SELECT p.titulo AS pesquisa, c.nome AS categoria, q.id_questionario,
       NVL(s.geradas, 0) AS senhas_geradas,
       NVL(s.utilizadas, 0) AS senhas_utilizadas,
       NVL(e.total, 0) AS submissoes,
       CASE WHEN NVL(s.geradas, 0) = 0 THEN 0
            ELSE ROUND(100 * NVL(e.total, 0) / s.geradas, 2) END AS participacao_pct
FROM questionario q
JOIN pesquisa p ON p.id_pesquisa = q.id_pesquisa
JOIN categoria c ON c.id_categoria = q.id_categoria
LEFT JOIN (
    SELECT l.id_questionario, COUNT(sa.id_senha) AS geradas,
           SUM(CASE WHEN sa.status = 'UTILIZADA' THEN 1 ELSE 0 END) AS utilizadas
    FROM lote_senha l
    LEFT JOIN senha_acesso sa ON sa.id_lote = l.id_lote
    GROUP BY l.id_questionario
) s ON s.id_questionario = q.id_questionario
LEFT JOIN (
    SELECT id_questionario, COUNT(*) AS total
    FROM submissao GROUP BY id_questionario
) e ON e.id_questionario = q.id_questionario
ORDER BY p.id_pesquisa, q.id_questionario;

-- Q2. Distribuição de alternativas, incluindo alternativas com zero escolhas.
SELECT q.id_questionario, pe.id_pergunta, pe.enunciado, a.texto AS alternativa,
       COUNT(r.id_resposta) AS quantidade
FROM questionario q
JOIN pergunta pe ON pe.id_questionario = q.id_questionario
JOIN alternativa a ON a.id_pergunta = pe.id_pergunta
LEFT JOIN resposta r ON r.id_alternativa = a.id_alternativa
                    AND r.id_pergunta = pe.id_pergunta
WHERE pe.tipo = 'MULTIPLA_ESCOLHA'
GROUP BY q.id_questionario, pe.id_pergunta, pe.enunciado, a.id_alternativa, a.texto, a.ordem
ORDER BY q.id_questionario, pe.id_pergunta, a.ordem;

-- Q3. Média das escalas e quantidade de avaliações, preservando zero respostas.
SELECT p.titulo AS pesquisa, c.nome AS categoria, pe.id_pergunta,
       COUNT(r.nota_escala) AS avaliacoes,
       ROUND(AVG(r.nota_escala), 2) AS media,
       MIN(r.nota_escala) AS menor_nota, MAX(r.nota_escala) AS maior_nota
FROM pesquisa p
JOIN questionario q ON q.id_pesquisa = p.id_pesquisa
JOIN categoria c ON c.id_categoria = q.id_categoria
JOIN pergunta pe ON pe.id_questionario = q.id_questionario
LEFT JOIN resposta r ON r.id_pergunta = pe.id_pergunta
WHERE pe.tipo = 'ESCALA'
GROUP BY p.id_pesquisa, p.titulo, c.nome, q.id_questionario, pe.id_pergunta
ORDER BY p.id_pesquisa, q.id_questionario;

-- Q4. Respostas recebidas por tipo de questão; não exporta textos livres.
SELECT p.titulo AS pesquisa, pe.tipo, COUNT(r.id_resposta) AS respostas
FROM pesquisa p
JOIN questionario q ON q.id_pesquisa = p.id_pesquisa
JOIN pergunta pe ON pe.id_questionario = q.id_questionario
LEFT JOIN resposta r ON r.id_pergunta = pe.id_pergunta
GROUP BY p.id_pesquisa, p.titulo, pe.tipo
ORDER BY p.id_pesquisa, pe.tipo;

-- Q5. Exemplo restrito de relatório agregado: mínimo de cinco avaliações.
-- Limiar didático; não é garantia de anonimização. Revisar cruzamentos,
-- inferência por diferença e conhecimento externo antes de divulgar.
SELECT q.id_questionario, c.nome AS categoria, pe.id_pergunta,
       COUNT(r.id_resposta) AS avaliacoes, ROUND(AVG(r.nota_escala), 2) AS media
FROM questionario q
JOIN categoria c ON c.id_categoria = q.id_categoria
JOIN pergunta pe ON pe.id_questionario = q.id_questionario
JOIN resposta r ON r.id_pergunta = pe.id_pergunta
WHERE pe.tipo = 'ESCALA'
GROUP BY q.id_questionario, c.nome, pe.id_pergunta
HAVING COUNT(r.id_resposta) >= 5
ORDER BY q.id_questionario;
