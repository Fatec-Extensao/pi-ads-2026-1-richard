# pi-ads-2026-2-richard

Sistema Web para Gestão de Pesquisas por Questionários — Projeto Integrador, ADS, Fatec Lins.

**Aplicação publicada: pendente.** Não foi encontrado código da aplicação web nem endereço de publicação no repositório. A publicação e a inclusão do link funcional são acompanhadas na [Issue #9](../../issues/9).

O repositório `pi-ads-2026-1-richard` preserva os trabalhos de 2026-1 e organiza os artefatos disponíveis para 2026-2 conforme o Guia de Padronização de Entregas no GitHub (PI II — ADS). A reorganização não representa aprovação acadêmica ou implementação das funcionalidades descritas.

## Documentação de 2026-2

| Disciplina | Material disponível | Entregas pendentes |
| --- | --- | --- |
| [Engenharia de Software II](2026-2/engenharia-software/readme.md) | [Requisitos](2026-2/engenharia-software/requisitos.md), [nove diagramas de casos de uso](2026-2/engenharia-software/modelagem-uml/casos-de-uso.md) e [fluxos RF01–RF15](2026-2/engenharia-software/modelagem-uml/especificacao.md), extraídos de trabalho existente em 2026-1 | Revisão da cobertura dos casos de uso; diagramas de classes e sequência e respectiva especificação |
| [Banco de Dados I](2026-2/banco-de-dados/readme.md) | Orientação da disciplina | Modelo conceitual, modelo lógico normalizado, `schema.sql`, `queries.sql` e testes |
| [Desenvolvimento Web](2026-2/desenvolvimento-web/readme.md) | Pastas [wireframes](2026-2/desenvolvimento-web/wireframes/) e [src](2026-2/desenvolvimento-web/src/) preparadas | Sitemap, telas, HTML/CSS, JavaScript, acessibilidade e publicação |
| [Compliance e Segurança da Informação](2026-2/seguranca/readme.md) | Orientação da disciplina; requisitos de segurança no documento de Engenharia | `analise-de-riscos.md`, `lgpd-e-anonimato.md`, política de retenção e aviso/termo de privacidade |

Os arquivos README das pastas vazias indicam pendências; não constituem entregas acadêmicas.

## Trabalhos de 2026-1

- [Gerador de senhas — relatório](2026-1/algoritmos-e-logica-de-programacao/gerador-de-senhas.md), [código VisualG](2026-1/algoritmos-e-logica-de-programacao/gerador-de-senhas.alg) e [fluxograma](assets/imagens/fluxograma-gerador-de-senhas.png).
- [Levantamento inicial de Engenharia de Software](2026-1/engenharia-de-software/levantamento-inicial.md).
- [Trabalho P2 de Engenharia de Software completo](2026-1/engenharia-de-software/p2-engs.md).
- [Front-end e back-end](2026-1/projeto-integrador/front-end-e-back-end.md).
- [Análise de sistemas de questionários](2026-1/projeto-integrador/analise-de-sistemas-de-questionarios.md).

Os nomes de autores e o conteúdo de cada trabalho foram preservados conforme seus documentos de origem. Os textos descrevem propostas e trabalhos acadêmicos, não comprovam que a aplicação esteja implementada.

## Acompanhamento das entregas

| Issue | Disciplina | Situação verificada |
| --- | --- | --- |
| [#1](../../issues/1) | Engenharia de Software | Material existente organizado; revisão da cobertura dos diagramas pendente |
| [#2](../../issues/2) | Engenharia de Software | Classes e sequência pendentes; fluxos textuais de casos de uso não substituem esses diagramas |
| [#3](../../issues/3) | Banco de Dados | DER pendente |
| [#4](../../issues/4) | Banco de Dados | Modelo lógico, normalização, DDL e teste pendentes |
| [#5](../../issues/5) | Banco de Dados | Povoamento e consultas pendentes |
| [#6](../../issues/6) | Desenvolvimento Web | Sitemap e wireframes pendentes |
| [#7](../../issues/7) | Desenvolvimento Web | HTML/CSS responsivo e acessibilidade pendentes |
| [#8](../../issues/8) | Desenvolvimento Web | Interatividade e validação pendentes |
| [#9](../../issues/9) | Desenvolvimento Web | Publicação e link funcional pendentes |
| [#10](../../issues/10) | Segurança | Matriz de risco e medidas de mitigação pendentes |
| [#11](../../issues/11) | Segurança | Relatório LGPD, retenção e aviso/termo pendentes |
| [#12](../../issues/12) | PI II — integração das quatro disciplinas | Validação final e mídia de apresentação pendentes |

## Regras de organização

- Relatórios, requisitos, atas e análises em Markdown (`.md`). Tabelas pequenas e médias em sintaxe Markdown.
- Código e scripts SQL nas pastas correspondentes; imagens UML em `2026-2/engenharia-software/modelagem-uml/` e imagens compartilhadas em `assets/imagens/`.
- Referências a arquivos por links relativos, sem anexos dispersos nas Issues. Nas Issues, usar `../blob/main/` antes do caminho do arquivo para o link resolver corretamente no GitHub.
- Não adicionar `.docx`, `.xlsx`, `.pptx` ou relatórios `.pdf`. A exceção do guia para exports de gráficos/planilhas complexos não se aplica aos cinco trabalhos Word encontrados.
- Não marcar atividades como concluídas sem o artefato e a verificação correspondente.

## Checklist da padronização

- [x] Versões Markdown dos cinco trabalhos existentes preparadas, com tabelas e imagens preservadas.
- [x] Cinco `.docx` retirados da árvore atual com autorização do responsável em 27/09/2026. Conteúdo preservado em Markdown, código e imagens; originais recuperáveis no histórico Git, sem reescrita do histórico.
- [x] Imagens extraídas nas pastas apropriadas e referenciadas por links relativos.
- [x] Labels de disciplina e tipo padronizadas conforme o guia.
- [ ] Entregas acadêmicas pendentes produzidas e validadas.
- [ ] Link funcional da aplicação publicada incluído no início deste README.

Auditoria de organização: 27/09/2026. Arquivos de entrega inexistentes não foram criados como se estivessem concluídos.
