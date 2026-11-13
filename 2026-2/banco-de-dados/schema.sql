-- Issue #4 | Oracle | Sistema Web para Gestao de Pesquisas por Questionarios
-- Versao: 13/11/2026. Execute em esquema de TESTES vazio.
-- Cria 12 tabelas; adiciona as 14 FKs com ALTER TABLE.
-- PK de alternativa composta: id_alternativa e local a cada pergunta.
-- Nao e uma migracao: nao execute sobre a versao antiga ja criada.
-- Oracle confirma DDL automaticamente. Uma falha nao desfaz DDL anterior.

CREATE TABLE perfil (
    id_perfil NUMBER(10) NOT NULL,
    nome VARCHAR2(50) NOT NULL,
    CONSTRAINT pk_perfil PRIMARY KEY (id_perfil),
    CONSTRAINT uq_perfil_1 UNIQUE (nome)
);

CREATE TABLE usuario (
    id_usuario NUMBER(10) NOT NULL,
    id_perfil NUMBER(10) NOT NULL,
    nome VARCHAR2(120) NOT NULL,
    email VARCHAR2(180) NOT NULL,
    senha_hash VARCHAR2(255) NOT NULL,
    ativo NUMBER(1) NOT NULL,
    CONSTRAINT pk_usuario PRIMARY KEY (id_usuario),
    CONSTRAINT uq_usuario_1 UNIQUE (email),
    CONSTRAINT ck_usuario_ativo CHECK (ativo IN (0, 1))
);

CREATE TABLE pesquisa (
    id_pesquisa NUMBER(10) NOT NULL,
    id_criador NUMBER(10) NOT NULL,
    titulo VARCHAR2(200) NOT NULL,
    descricao VARCHAR2(4000),
    data_inicio DATE NOT NULL,
    data_fim DATE NOT NULL,
    status VARCHAR2(15) NOT NULL,
    CONSTRAINT pk_pesquisa PRIMARY KEY (id_pesquisa),
    CONSTRAINT ck_pesquisa_periodo CHECK (data_fim >= data_inicio),
    CONSTRAINT ck_pesquisa_status CHECK (status IN ('RASCUNHO', 'ABERTA', 'ENCERRADA'))
);

CREATE TABLE categoria (
    id_categoria NUMBER(10) NOT NULL,
    nome VARCHAR2(100) NOT NULL,
    codigo VARCHAR2(1) NOT NULL,
    descricao VARCHAR2(4000),
    CONSTRAINT pk_categoria PRIMARY KEY (id_categoria),
    CONSTRAINT uq_categoria_1 UNIQUE (nome),
    CONSTRAINT uq_categoria_2 UNIQUE (codigo)
);

CREATE TABLE questionario (
    id_questionario NUMBER(10) NOT NULL,
    id_pesquisa NUMBER(10) NOT NULL,
    id_categoria NUMBER(10) NOT NULL,
    titulo VARCHAR2(200) NOT NULL,
    descricao VARCHAR2(4000),
    ativo NUMBER(1) NOT NULL,
    CONSTRAINT pk_questionario PRIMARY KEY (id_questionario),
    CONSTRAINT ck_questionario_ativo CHECK (ativo IN (0, 1))
);

CREATE TABLE pergunta (
    id_pergunta NUMBER(10) NOT NULL,
    id_questionario NUMBER(10) NOT NULL,
    enunciado VARCHAR2(4000) NOT NULL,
    tipo VARCHAR2(20) NOT NULL,
    ordem NUMBER(10) NOT NULL,
    obrigatoria NUMBER(1) NOT NULL,
    CONSTRAINT pk_pergunta PRIMARY KEY (id_pergunta),
    CONSTRAINT uq_pergunta_1 UNIQUE (id_questionario, ordem),
    CONSTRAINT ck_pergunta_tipo CHECK (tipo IN ('MULTIPLA_ESCOLHA', 'ESCALA', 'ABERTA')),
    CONSTRAINT ck_pergunta_ordem CHECK (ordem >= 1),
    CONSTRAINT ck_pergunta_obrigatoria CHECK (obrigatoria IN (0, 1))
);

CREATE TABLE alternativa (
    id_alternativa NUMBER(10) NOT NULL,
    id_pergunta NUMBER(10) NOT NULL,
    texto VARCHAR2(500) NOT NULL,
    ordem NUMBER(10) NOT NULL,
    CONSTRAINT pk_alternativa PRIMARY KEY (id_pergunta, id_alternativa),
    CONSTRAINT uq_alternativa_1 UNIQUE (id_pergunta, ordem),
    CONSTRAINT ck_alternativa_ordem CHECK (ordem >= 1)
);

CREATE TABLE lote_senha (
    id_lote NUMBER(10) NOT NULL,
    id_questionario NUMBER(10) NOT NULL,
    id_gerador NUMBER(10) NOT NULL,
    gerado_em DATE NOT NULL,
    CONSTRAINT pk_lote_senha PRIMARY KEY (id_lote)
);

CREATE TABLE senha_acesso (
    id_senha NUMBER(10) NOT NULL,
    id_lote NUMBER(10) NOT NULL,
    codigo VARCHAR2(8) NOT NULL,
    status VARCHAR2(15) NOT NULL,
    utilizada_em DATE,
    CONSTRAINT pk_senha_acesso PRIMARY KEY (id_senha),
    CONSTRAINT uq_senha_acesso_1 UNIQUE (codigo),
    CONSTRAINT ck_senha_tamanho CHECK (LENGTH(codigo) = 8),
    CONSTRAINT ck_senha_status CHECK (status IN ('DISPONIVEL', 'UTILIZADA')),
    CONSTRAINT ck_senha_utilizacao CHECK ((status = 'DISPONIVEL' AND utilizada_em IS NULL) OR (status = 'UTILIZADA' AND utilizada_em IS NOT NULL))
);

CREATE TABLE submissao (
    id_submissao NUMBER(10) NOT NULL,
    id_questionario NUMBER(10) NOT NULL,
    enviada_em DATE NOT NULL,
    CONSTRAINT pk_submissao PRIMARY KEY (id_submissao)
);

CREATE TABLE resposta (
    id_resposta NUMBER(10) NOT NULL,
    id_submissao NUMBER(10) NOT NULL,
    id_pergunta NUMBER(10) NOT NULL,
    id_alternativa NUMBER(10),
    nota_escala NUMBER(1),
    texto_aberto VARCHAR2(4000),
    CONSTRAINT pk_resposta PRIMARY KEY (id_resposta),
    CONSTRAINT uq_resposta_1 UNIQUE (id_submissao, id_pergunta),
    CONSTRAINT ck_resposta_escala CHECK (nota_escala BETWEEN 1 AND 5),
    CONSTRAINT ck_resposta_um_valor CHECK ((id_alternativa IS NOT NULL AND nota_escala IS NULL AND texto_aberto IS NULL)
        OR (id_alternativa IS NULL AND nota_escala IS NOT NULL AND texto_aberto IS NULL)
        OR (id_alternativa IS NULL AND nota_escala IS NULL AND texto_aberto IS NOT NULL))
);

CREATE TABLE auditoria (
    id_auditoria NUMBER(10) NOT NULL,
    id_usuario NUMBER(10) NOT NULL,
    acao VARCHAR2(80) NOT NULL,
    entidade VARCHAR2(80) NOT NULL,
    id_registro NUMBER(10),
    realizado_em DATE NOT NULL,
    CONSTRAINT pk_auditoria PRIMARY KEY (id_auditoria)
);

-- Relacionamentos: as tabelas referenciadas ja existem nesta etapa.
ALTER TABLE usuario ADD CONSTRAINT fk_usuario_perfil
    FOREIGN KEY (id_perfil) REFERENCES perfil (id_perfil);

ALTER TABLE pesquisa ADD CONSTRAINT fk_pesquisa_criador
    FOREIGN KEY (id_criador) REFERENCES usuario (id_usuario);

ALTER TABLE questionario ADD CONSTRAINT fk_questionario_pesquisa
    FOREIGN KEY (id_pesquisa) REFERENCES pesquisa (id_pesquisa);

ALTER TABLE questionario ADD CONSTRAINT fk_questionario_categoria
    FOREIGN KEY (id_categoria) REFERENCES categoria (id_categoria);

ALTER TABLE pergunta ADD CONSTRAINT fk_pergunta_questionario
    FOREIGN KEY (id_questionario) REFERENCES questionario (id_questionario);

ALTER TABLE alternativa ADD CONSTRAINT fk_alternativa_pergunta
    FOREIGN KEY (id_pergunta) REFERENCES pergunta (id_pergunta);

ALTER TABLE lote_senha ADD CONSTRAINT fk_lote_questionario
    FOREIGN KEY (id_questionario) REFERENCES questionario (id_questionario);

ALTER TABLE lote_senha ADD CONSTRAINT fk_lote_gerador
    FOREIGN KEY (id_gerador) REFERENCES usuario (id_usuario);

ALTER TABLE senha_acesso ADD CONSTRAINT fk_senha_lote
    FOREIGN KEY (id_lote) REFERENCES lote_senha (id_lote);

ALTER TABLE submissao ADD CONSTRAINT fk_submissao_questionario
    FOREIGN KEY (id_questionario) REFERENCES questionario (id_questionario);

ALTER TABLE resposta ADD CONSTRAINT fk_resposta_submissao
    FOREIGN KEY (id_submissao) REFERENCES submissao (id_submissao);

ALTER TABLE resposta ADD CONSTRAINT fk_resposta_pergunta
    FOREIGN KEY (id_pergunta) REFERENCES pergunta (id_pergunta);

ALTER TABLE resposta ADD CONSTRAINT fk_resposta_alternativa
    FOREIGN KEY (id_pergunta, id_alternativa) REFERENCES alternativa (id_pergunta, id_alternativa);

ALTER TABLE auditoria ADD CONSTRAINT fk_auditoria_usuario
    FOREIGN KEY (id_usuario) REFERENCES usuario (id_usuario);
