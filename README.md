# Sistema Web para Gestão de Pesquisas por Questionários

**Publicação: preparada, ainda sem URL pública validada.** [Instruções de publicação](2026-2/desenvolvimento-web/publicacao.md) · [Abrir o protótipo](2026-2/desenvolvimento-web/src/index.html) · [Apresentação](2026-2/evidencias/apresentacao.html)

Projeto Integrador ADS, Fatec Lins. Este repositório preserva 2026-1 e reúne as entregas de 2026-2. A aplicação atual é uma demonstração estática em HTML/CSS/JavaScript. Ela valida formulários e navega entre perguntas, sem gravar respostas ou integrar com Oracle.

## Entregas de 13/11/2026

| Issue | Entrega | Estado desta versão |
| --- | --- | --- |
| [#5 — Banco](https://github.com/Fatec-Extensao/pi-ads-2026-1-richard/issues/5) | [DDL](2026-2/banco-de-dados/schema.sql), [povoamento](2026-2/banco-de-dados/povoamento.sql), [cinco consultas](2026-2/banco-de-dados/queries.sql), [validação SQL](2026-2/banco-de-dados/validacao.sql) | Scripts preparados; lógica verificada em SQLite com adaptação explícita. Execução Oracle pendente. |
| [#8 — Interatividade](https://github.com/Fatec-Extensao/pi-ads-2026-1-richard/issues/8) | [JavaScript](2026-2/desenvolvimento-web/src/app.js) e [descrição dos controles](2026-2/desenvolvimento-web/interatividade.md) | Validação de formulários e navegação implementadas e testadas em Chrome. |
| [#11 — Privacidade](https://github.com/Fatec-Extensao/pi-ads-2026-1-richard/issues/11) | [Relatório LGPD e anonimato](2026-2/seguranca/lgpd-e-anonimato.md), [aviso ao respondente](2026-2/desenvolvimento-web/src/privacidade.html) | Documentos e controles de demonstração preparados. Requisitos de produção explicitados. |
| [#9 — Publicação](https://github.com/Fatec-Extensao/pi-ads-2026-1-richard/issues/9) | [Workflow Pages](.github/workflows/pages.yml), [procedimento](2026-2/desenvolvimento-web/publicacao.md) | Pendente envio remoto, ativação do Pages e validação da URL. |
| [#12 — Integração](https://github.com/Fatec-Extensao/pi-ads-2026-1-richard/issues/12) | [Validação final](2026-2/validacao-final.md), [slides HTML](2026-2/evidencias/apresentacao.html), [roteiro](2026-2/evidencias/roteiro-apresentacao.md) | Revisão local e mídia preparadas. Validação integral depende de Oracle, deploy e pendências acadêmicas anteriores. |

As issues remotas não foram encerradas nem alteradas nesta entrega. O status acima distingue artefatos locais e validação ainda necessária.

## Demonstração

Abra [index.html](2026-2/desenvolvimento-web/src/index.html) no navegador. A aplicação usa apenas arquivos estáticos e não precisa de instalação. Selecione Responder à pesquisa de demonstração e digite **DEMO2026**. São três perguntas com Avançar/Voltar, obrigatórios e confirmação de leitura do aviso. Ao concluir, os campos são descartados. O botão Reiniciar demonstração remove o bloqueio de exemplo nesta aba.

Use somente dados fictícios. O login e as demais funcionalidades administrativas são exemplos de interface. A garantia de uso único, a autenticação, a geração de códigos e a gravação das respostas dependem de backend.

## Documentação por disciplina

| Disciplina | Artefatos e pendências |
| --- | --- |
| [Engenharia de Software II](2026-2/engenharia-software/readme.md) | [Requisitos](2026-2/engenharia-software/requisitos.md), [casos de uso](2026-2/engenharia-software/modelagem-uml/casos-de-uso.md) e [especificação](2026-2/engenharia-software/modelagem-uml/especificacao.md). Há arquivos Astah na pasta. Conferir classes/sequência e suas exportações antes de concluir as issues anteriores. |
| [Banco de Dados I](2026-2/banco-de-dados/readme.md) | Modelo original em bd o.txt e DDL extraído. Povoamento e consultas desta entrega. Executar em Oracle e confirmar diagramas/normalização das Issues #3 e #4. |
| [Desenvolvimento Web](2026-2/desenvolvimento-web/readme.md) | HTML/CSS extraídos do ZIP, interatividade, aviso e apresentação. Conferir sitemap/wireframes anteriores e publicar. |
| [Segurança](2026-2/seguranca/readme.md) | Relatório LGPD, política proposta de retenção/exclusão e aviso. Revisão de riscos da Issue #10 e conversão do PDF legado continuam pendentes. |

## Trabalhos preservados de 2026-1

- [Gerador de senhas — relatório](2026-1/algoritmos-e-logica-de-programacao/gerador-de-senhas.md), [código VisualG](2026-1/algoritmos-e-logica-de-programacao/gerador-de-senhas.alg) e [fluxograma](assets/imagens/fluxograma-gerador-de-senhas.png).
- [Levantamento inicial de Engenharia de Software](2026-1/engenharia-de-software/levantamento-inicial.md).
- [Trabalho P2 de Engenharia de Software](2026-1/engenharia-de-software/p2-engs.md).
- [Front-end e back-end](2026-1/projeto-integrador/front-end-e-back-end.md).
- [Análise de sistemas de questionários](2026-1/projeto-integrador/analise-de-sistemas-de-questionarios.md).

Os autores e o conteúdo desses documentos permanecem preservados. A lista de integrantes da apresentação final deve ser confirmada pelo grupo, pois os materiais anteriores têm registros diferentes.

## Verificações reproduzíveis

Instruções em [tests/README.md](tests/README.md). As dependências são apenas para testes; não fazem parte do site. O relatório [validacao-final.md](2026-2/validacao-final.md) registra o que foi executado e os limites de cada teste.

## Organização

Relatórios em Markdown, SQL na pasta Banco de Dados, código na pasta src e mídia HTML em evidencias. Nenhum novo Word, PowerPoint ou PDF integra esta entrega. Os arquivos legados permanecem preservados, incluindo um PDF que precisa de revisão/conversão para atender integralmente ao guia. Não marcar pendências como concluídas sem evidência.

Auditoria anterior: 27/09/2026. Atualização desta entrega: 13/11/2026.
