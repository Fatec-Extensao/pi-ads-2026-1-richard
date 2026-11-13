-- Oracle: DDL extraído sem alteração estrutural de bd o.txt.
-- Execute em esquema de testes vazio; não remove tabelas existentes.

CREATE TABLE perfil (
    id_perfil NUMBER(10) NOT NULL,
    nome VARCHAR2(50) NOT NULL,

    CONSTRAINT pk_perfil PRIMARY KEY (id_perfil)
);

CREATE TABLE usuario (
    id_usuario NUMBER(10) NOT NULL,
    id_perfil NUMBER(10) NOT NULL,
    nome VARCHAR2(120) NOT NULL,
    email VARCHAR2(180) NOT NULL,
    senha_hash VARCHAR2(255) NOT NULL,
    ativo NUMBER(1) NOT NULL,

    CONSTRAINT pk_usuario PRIMARY KEY (id_usuario),

    CONSTRAINT fk_usuario_perfil FOREIGN KEY (id_perfil)
        REFERENCES perfil(id_perfil)
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

    CONSTRAINT fk_pesquisa_criador FOREIGN KEY (id_criador)
        REFERENCES usuario(id_usuario)
);

CREATE TABLE categoria (
    id_categoria NUMBER(10) NOT NULL,
    nome VARCHAR2(100) NOT NULL,
    codigo VARCHAR2(1) NOT NULL,
    descricao VARCHAR2(4000),

    CONSTRAINT pk_categoria PRIMARY KEY (id_categoria)
);

CREATE TABLE questionario (
    id_questionario NUMBER(10) NOT NULL,
    id_pesquisa NUMBER(10) NOT NULL,
    id_categoria NUMBER(10) NOT NULL,
    titulo VARCHAR2(200) NOT NULL,
    descricao VARCHAR2(4000),
    ativo NUMBER(1) NOT NULL,

    CONSTRAINT pk_questionario PRIMARY KEY (id_questionario),

    CONSTRAINT fk_questionario_pesquisa FOREIGN KEY (id_pesquisa)
        REFERENCES pesquisa(id_pesquisa),

    CONSTRAINT fk_questionario_categoria FOREIGN KEY (id_categoria)
        REFERENCES categoria(id_categoria)
);

CREATE TABLE pergunta (
    id_pergunta NUMBER(10) NOT NULL,
    id_questionario NUMBER(10) NOT NULL,
    enunciado VARCHAR2(4000) NOT NULL,
    tipo VARCHAR2(20) NOT NULL,
    ordem NUMBER(10) NOT NULL,
    obrigatoria NUMBER(1) NOT NULL,

    CONSTRAINT pk_pergunta PRIMARY KEY (id_pergunta),

    CONSTRAINT fk_pergunta_questionario FOREIGN KEY (id_questionario)
        REFERENCES questionario(id_questionario)
);

CREATE TABLE alternativa (
    id_alternativa NUMBER(10) NOT NULL,
    id_pergunta NUMBER(10) NOT NULL,
    texto VARCHAR2(500) NOT NULL,
    ordem NUMBER(10) NOT NULL,

    CONSTRAINT pk_alternativa PRIMARY KEY (id_alternativa),

    CONSTRAINT fk_alternativa_pergunta FOREIGN KEY (id_pergunta)
        REFERENCES pergunta(id_pergunta)
);

CREATE TABLE lote_senha (
    id_lote NUMBER(10) NOT NULL,
    id_questionario NUMBER(10) NOT NULL,
    id_gerador NUMBER(10) NOT NULL,
    gerado_em DATE NOT NULL,

    CONSTRAINT pk_lote_senha PRIMARY KEY (id_lote),

    CONSTRAINT fk_lote_questionario FOREIGN KEY (id_questionario)
        REFERENCES questionario(id_questionario),

    CONSTRAINT fk_lote_gerador FOREIGN KEY (id_gerador)
        REFERENCES usuario(id_usuario)
);

CREATE TABLE senha_acesso (
    id_senha NUMBER(10) NOT NULL,
    id_lote NUMBER(10) NOT NULL,
    codigo VARCHAR2(8) NOT NULL,
    status VARCHAR2(15) NOT NULL,
    utilizada_em DATE,

    CONSTRAINT pk_senha_acesso PRIMARY KEY (id_senha),

    CONSTRAINT fk_senha_lote FOREIGN KEY (id_lote)
        REFERENCES lote_senha(id_lote)
);

CREATE TABLE submissao (
    id_submissao NUMBER(10) NOT NULL,
    id_questionario NUMBER(10) NOT NULL,
    enviada_em DATE NOT NULL,

    CONSTRAINT pk_submissao PRIMARY KEY (id_submissao),

    CONSTRAINT fk_submissao_questionario FOREIGN KEY (id_questionario)
        REFERENCES questionario(id_questionario)
);

CREATE TABLE resposta (
    id_resposta NUMBER(10) NOT NULL,
    id_submissao NUMBER(10) NOT NULL,
    id_pergunta NUMBER(10) NOT NULL,
    id_alternativa NUMBER(10),
    nota_escala NUMBER(1),
    texto_aberto VARCHAR2(4000),

    CONSTRAINT pk_resposta PRIMARY KEY (id_resposta),

    CONSTRAINT fk_resposta_submissao FOREIGN KEY (id_submissao)
        REFERENCES submissao(id_submissao),

    CONSTRAINT fk_resposta_pergunta FOREIGN KEY (id_pergunta)
        REFERENCES pergunta(id_pergunta),

    CONSTRAINT fk_resposta_alternativa FOREIGN KEY (id_alternativa)
        REFERENCES alternativa(id_alternativa)
);

CREATE TABLE auditoria (
    id_auditoria NUMBER(10) NOT NULL,
    id_usuario NUMBER(10) NOT NULL,
    acao VARCHAR2(80) NOT NULL,
    entidade VARCHAR2(80) NOT NULL,
    id_registro NUMBER(10),
    realizado_em DATE NOT NULL,

    CONSTRAINT pk_auditoria PRIMARY KEY (id_auditoria),

    CONSTRAINT fk_auditoria_usuario FOREIGN KEY (id_usuario)
        REFERENCES usuario(id_usuario)
);
