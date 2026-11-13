-- Issue #5 | Oracle | Dados exclusivamente fictícios.
-- Pré-requisito: schema.sql em esquema vazio. Execute UMA vez.
-- IDs explícitos: sem sequences, triggers ou recursos avançados.
-- Em SQL Developer, executar como script (F5), interrompendo em caso de erro.
WHENEVER SQLERROR EXIT SQL.SQLCODE ROLLBACK
SET DEFINE OFF

-- perfil
INSERT INTO perfil (id_perfil, nome) VALUES (1, 'Administrador');
INSERT INTO perfil (id_perfil, nome) VALUES (2, 'Coordenador');
INSERT INTO perfil (id_perfil, nome) VALUES (3, 'Distribuidor');

-- usuario
INSERT INTO usuario (id_usuario, id_perfil, nome, email, senha_hash, ativo) VALUES (1, 1, 'Administrador Fictício', 'admin@example.test', 'HASH_FICTICIO_SEM_LOGIN', 1);
INSERT INTO usuario (id_usuario, id_perfil, nome, email, senha_hash, ativo) VALUES (2, 2, 'Coordenador Fictício', 'coordenador@example.test', 'HASH_FICTICIO_SEM_LOGIN', 1);
INSERT INTO usuario (id_usuario, id_perfil, nome, email, senha_hash, ativo) VALUES (3, 3, 'Distribuidor Fictício', 'distribuidor@example.test', 'HASH_FICTICIO_SEM_LOGIN', 1);

-- pesquisa
INSERT INTO pesquisa (id_pesquisa, id_criador, titulo, descricao, data_inicio, data_fim, status) VALUES (1, 2, 'Avaliação dos serviços acadêmicos', 'Pesquisa fictícia para testes.', DATE '2026-11-01', DATE '2026-11-30', 'ABERTA');
INSERT INTO pesquisa (id_pesquisa, id_criador, titulo, descricao, data_inicio, data_fim, status) VALUES (2, 2, 'Avaliação do ambiente de trabalho', 'Pesquisa fictícia encerrada.', DATE '2026-10-01', DATE '2026-10-31', 'ENCERRADA');

-- categoria
INSERT INTO categoria (id_categoria, nome, codigo, descricao) VALUES (1, 'Alunos', 'A', 'Categoria acadêmica');
INSERT INTO categoria (id_categoria, nome, codigo, descricao) VALUES (2, 'Professores', 'P', 'Categoria docente');
INSERT INTO categoria (id_categoria, nome, codigo, descricao) VALUES (3, 'Funcionários', 'F', 'Categoria administrativa');

-- questionario
INSERT INTO questionario (id_questionario, id_pesquisa, id_categoria, titulo, descricao, ativo) VALUES (1, 1, 1, 'Serviços para alunos', 'Dados fictícios', 1);
INSERT INTO questionario (id_questionario, id_pesquisa, id_categoria, titulo, descricao, ativo) VALUES (2, 1, 2, 'Serviços para professores', 'Dados fictícios', 1);
INSERT INTO questionario (id_questionario, id_pesquisa, id_categoria, titulo, descricao, ativo) VALUES (3, 2, 3, 'Ambiente de trabalho', 'Dados fictícios', 0);
INSERT INTO questionario (id_questionario, id_pesquisa, id_categoria, titulo, descricao, ativo) VALUES (4, 1, 3, 'Questionário sem participação', 'Caso de teste com zero senhas e respostas', 1);

-- pergunta
INSERT INTO pergunta (id_pergunta, id_questionario, enunciado, tipo, ordem, obrigatoria) VALUES (1, 1, 'Como você avalia o serviço?', 'MULTIPLA_ESCOLHA', 1, 1);
INSERT INTO pergunta (id_pergunta, id_questionario, enunciado, tipo, ordem, obrigatoria) VALUES (2, 1, 'Qual sua satisfação de 1 a 5?', 'ESCALA', 2, 1);
INSERT INTO pergunta (id_pergunta, id_questionario, enunciado, tipo, ordem, obrigatoria) VALUES (3, 1, 'Sugestão sem dados pessoais', 'ABERTA', 3, 0);
INSERT INTO pergunta (id_pergunta, id_questionario, enunciado, tipo, ordem, obrigatoria) VALUES (4, 2, 'Como você avalia o serviço?', 'MULTIPLA_ESCOLHA', 1, 1);
INSERT INTO pergunta (id_pergunta, id_questionario, enunciado, tipo, ordem, obrigatoria) VALUES (5, 2, 'Qual sua satisfação de 1 a 5?', 'ESCALA', 2, 1);
INSERT INTO pergunta (id_pergunta, id_questionario, enunciado, tipo, ordem, obrigatoria) VALUES (6, 2, 'Sugestão sem dados pessoais', 'ABERTA', 3, 0);
INSERT INTO pergunta (id_pergunta, id_questionario, enunciado, tipo, ordem, obrigatoria) VALUES (7, 3, 'Como você avalia o serviço?', 'MULTIPLA_ESCOLHA', 1, 1);
INSERT INTO pergunta (id_pergunta, id_questionario, enunciado, tipo, ordem, obrigatoria) VALUES (8, 3, 'Qual sua satisfação de 1 a 5?', 'ESCALA', 2, 1);
INSERT INTO pergunta (id_pergunta, id_questionario, enunciado, tipo, ordem, obrigatoria) VALUES (9, 3, 'Sugestão sem dados pessoais', 'ABERTA', 3, 0);
INSERT INTO pergunta (id_pergunta, id_questionario, enunciado, tipo, ordem, obrigatoria) VALUES (10, 4, 'Qual sua satisfação de 1 a 5?', 'ESCALA', 1, 1);

-- alternativa
INSERT INTO alternativa (id_alternativa, id_pergunta, texto, ordem) VALUES (1, 1, 'Bom', 1);
INSERT INTO alternativa (id_alternativa, id_pergunta, texto, ordem) VALUES (2, 1, 'Regular', 2);
INSERT INTO alternativa (id_alternativa, id_pergunta, texto, ordem) VALUES (3, 1, 'Ruim', 3);
INSERT INTO alternativa (id_alternativa, id_pergunta, texto, ordem) VALUES (4, 4, 'Bom', 1);
INSERT INTO alternativa (id_alternativa, id_pergunta, texto, ordem) VALUES (5, 4, 'Regular', 2);
INSERT INTO alternativa (id_alternativa, id_pergunta, texto, ordem) VALUES (6, 4, 'Ruim', 3);
INSERT INTO alternativa (id_alternativa, id_pergunta, texto, ordem) VALUES (7, 7, 'Bom', 1);
INSERT INTO alternativa (id_alternativa, id_pergunta, texto, ordem) VALUES (8, 7, 'Regular', 2);
INSERT INTO alternativa (id_alternativa, id_pergunta, texto, ordem) VALUES (9, 7, 'Ruim', 3);

-- lote_senha
INSERT INTO lote_senha (id_lote, id_questionario, id_gerador, gerado_em) VALUES (1, 1, 3, DATE '2026-11-01');
INSERT INTO lote_senha (id_lote, id_questionario, id_gerador, gerado_em) VALUES (2, 2, 3, DATE '2026-11-01');
INSERT INTO lote_senha (id_lote, id_questionario, id_gerador, gerado_em) VALUES (3, 3, 3, DATE '2026-10-01');

-- senha_acesso
INSERT INTO senha_acesso (id_senha, id_lote, codigo, status, utilizada_em) VALUES (1, 1, 'ATEST001', 'UTILIZADA', DATE '2026-11-10');
INSERT INTO senha_acesso (id_senha, id_lote, codigo, status, utilizada_em) VALUES (2, 1, 'ATEST002', 'UTILIZADA', DATE '2026-11-10');
INSERT INTO senha_acesso (id_senha, id_lote, codigo, status, utilizada_em) VALUES (3, 1, 'ATEST003', 'UTILIZADA', DATE '2026-11-10');
INSERT INTO senha_acesso (id_senha, id_lote, codigo, status, utilizada_em) VALUES (4, 1, 'ATEST004', 'UTILIZADA', DATE '2026-11-10');
INSERT INTO senha_acesso (id_senha, id_lote, codigo, status, utilizada_em) VALUES (5, 1, 'ATEST005', 'UTILIZADA', DATE '2026-11-10');
INSERT INTO senha_acesso (id_senha, id_lote, codigo, status, utilizada_em) VALUES (6, 1, 'ATEST006', 'DISPONIVEL', NULL);
INSERT INTO senha_acesso (id_senha, id_lote, codigo, status, utilizada_em) VALUES (7, 2, 'PTEST001', 'UTILIZADA', DATE '2026-11-10');
INSERT INTO senha_acesso (id_senha, id_lote, codigo, status, utilizada_em) VALUES (8, 2, 'PTEST002', 'UTILIZADA', DATE '2026-11-10');
INSERT INTO senha_acesso (id_senha, id_lote, codigo, status, utilizada_em) VALUES (9, 2, 'PTEST003', 'UTILIZADA', DATE '2026-11-10');
INSERT INTO senha_acesso (id_senha, id_lote, codigo, status, utilizada_em) VALUES (10, 2, 'PTEST004', 'DISPONIVEL', NULL);
INSERT INTO senha_acesso (id_senha, id_lote, codigo, status, utilizada_em) VALUES (11, 3, 'FTEST001', 'UTILIZADA', DATE '2026-10-15');
INSERT INTO senha_acesso (id_senha, id_lote, codigo, status, utilizada_em) VALUES (12, 3, 'FTEST002', 'DISPONIVEL', NULL);

-- submissao
INSERT INTO submissao (id_submissao, id_questionario, enviada_em) VALUES (101, 1, DATE '2026-11-10');
INSERT INTO submissao (id_submissao, id_questionario, enviada_em) VALUES (102, 1, DATE '2026-11-10');
INSERT INTO submissao (id_submissao, id_questionario, enviada_em) VALUES (103, 1, DATE '2026-11-10');
INSERT INTO submissao (id_submissao, id_questionario, enviada_em) VALUES (104, 1, DATE '2026-11-10');
INSERT INTO submissao (id_submissao, id_questionario, enviada_em) VALUES (105, 1, DATE '2026-11-10');
INSERT INTO submissao (id_submissao, id_questionario, enviada_em) VALUES (106, 2, DATE '2026-11-10');
INSERT INTO submissao (id_submissao, id_questionario, enviada_em) VALUES (107, 2, DATE '2026-11-10');
INSERT INTO submissao (id_submissao, id_questionario, enviada_em) VALUES (108, 2, DATE '2026-11-10');
INSERT INTO submissao (id_submissao, id_questionario, enviada_em) VALUES (109, 3, DATE '2026-10-15');

-- resposta
INSERT INTO resposta (id_resposta, id_submissao, id_pergunta, id_alternativa, nota_escala, texto_aberto) VALUES (1, 101, 1, 1, NULL, NULL);
INSERT INTO resposta (id_resposta, id_submissao, id_pergunta, id_alternativa, nota_escala, texto_aberto) VALUES (2, 101, 2, NULL, 5, NULL);
INSERT INTO resposta (id_resposta, id_submissao, id_pergunta, id_alternativa, nota_escala, texto_aberto) VALUES (3, 101, 3, NULL, NULL, 'Ampliar o horário de atendimento.');
INSERT INTO resposta (id_resposta, id_submissao, id_pergunta, id_alternativa, nota_escala, texto_aberto) VALUES (4, 102, 1, 2, NULL, NULL);
INSERT INTO resposta (id_resposta, id_submissao, id_pergunta, id_alternativa, nota_escala, texto_aberto) VALUES (5, 102, 2, NULL, 4, NULL);
INSERT INTO resposta (id_resposta, id_submissao, id_pergunta, id_alternativa, nota_escala, texto_aberto) VALUES (6, 102, 3, NULL, NULL, 'Melhorar a sinalização.');
INSERT INTO resposta (id_resposta, id_submissao, id_pergunta, id_alternativa, nota_escala, texto_aberto) VALUES (7, 103, 1, 1, NULL, NULL);
INSERT INTO resposta (id_resposta, id_submissao, id_pergunta, id_alternativa, nota_escala, texto_aberto) VALUES (8, 103, 2, NULL, 5, NULL);
INSERT INTO resposta (id_resposta, id_submissao, id_pergunta, id_alternativa, nota_escala, texto_aberto) VALUES (9, 104, 1, 3, NULL, NULL);
INSERT INTO resposta (id_resposta, id_submissao, id_pergunta, id_alternativa, nota_escala, texto_aberto) VALUES (10, 104, 2, NULL, 2, NULL);
INSERT INTO resposta (id_resposta, id_submissao, id_pergunta, id_alternativa, nota_escala, texto_aberto) VALUES (11, 105, 1, 1, NULL, NULL);
INSERT INTO resposta (id_resposta, id_submissao, id_pergunta, id_alternativa, nota_escala, texto_aberto) VALUES (12, 105, 2, NULL, 4, NULL);
INSERT INTO resposta (id_resposta, id_submissao, id_pergunta, id_alternativa, nota_escala, texto_aberto) VALUES (13, 106, 4, 4, NULL, NULL);
INSERT INTO resposta (id_resposta, id_submissao, id_pergunta, id_alternativa, nota_escala, texto_aberto) VALUES (14, 106, 5, NULL, 4, NULL);
INSERT INTO resposta (id_resposta, id_submissao, id_pergunta, id_alternativa, nota_escala, texto_aberto) VALUES (15, 106, 6, NULL, NULL, 'Ampliar o horário de atendimento.');
INSERT INTO resposta (id_resposta, id_submissao, id_pergunta, id_alternativa, nota_escala, texto_aberto) VALUES (16, 107, 4, 4, NULL, NULL);
INSERT INTO resposta (id_resposta, id_submissao, id_pergunta, id_alternativa, nota_escala, texto_aberto) VALUES (17, 107, 5, NULL, 3, NULL);
INSERT INTO resposta (id_resposta, id_submissao, id_pergunta, id_alternativa, nota_escala, texto_aberto) VALUES (18, 108, 4, 5, NULL, NULL);
INSERT INTO resposta (id_resposta, id_submissao, id_pergunta, id_alternativa, nota_escala, texto_aberto) VALUES (19, 108, 5, NULL, 5, NULL);
INSERT INTO resposta (id_resposta, id_submissao, id_pergunta, id_alternativa, nota_escala, texto_aberto) VALUES (20, 109, 7, 9, NULL, NULL);
INSERT INTO resposta (id_resposta, id_submissao, id_pergunta, id_alternativa, nota_escala, texto_aberto) VALUES (21, 109, 8, NULL, 2, NULL);

-- auditoria
INSERT INTO auditoria (id_auditoria, id_usuario, acao, entidade, id_registro, realizado_em) VALUES (1, 2, 'CRIAR_PESQUISA', 'pesquisa', 1, DATE '2026-11-01');
INSERT INTO auditoria (id_auditoria, id_usuario, acao, entidade, id_registro, realizado_em) VALUES (2, 3, 'GERAR_LOTE', 'lote_senha', 1, DATE '2026-11-01');

-- Senhas de teste não são credenciais reais. Respostas não guardam códigos.
COMMIT;
