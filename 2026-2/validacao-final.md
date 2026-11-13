# Validação do projeto e documentação final

Issue #12 · Integração das disciplinas · 13/11/2026.

## Escopo verificado

Repositório de origem: [Fatec-Extensao/pi-ads-2026-1-richard](https://github.com/Fatec-Extensao/pi-ads-2026-1-richard). Base consultada: commit 357f01ace7cff6071ef3e86e9d1e369673573223. Esta entrega acrescenta os artefatos das Issues #5, #8, #9, #11 e #12, mantendo os documentos de origem.

## Testes executados

| Verificação | Resultado | Evidência e limites |
| --- | --- | --- |
| Sintaxe JavaScript | Aprovada | node --check em app.js. |
| Dados e consultas | Aprovados no adaptador SQLite/WASM | [Teste do banco](../tests/check-db.cjs): 12 tabelas, contagens esperadas, seis regras de consistência e resultados exatos das cinco consultas. Não executado em Oracle. |
| Acesso com código de exemplo | Aprovado em Chrome | Vazio e código inválido rejeitados; DEMO2026 abre questionário. |
| Obrigatórios e etapas | Aprovados em Chrome | Avançar bloqueia campo vazio, Voltar preserva escolhas, confirmação de leitura obrigatória. |
| Descarte e bloqueio demonstrativo | Aprovados em Chrome | Conclusão limpa campos; só marcador de uso na sessão; recarregar mantém bloqueio; Reiniciar limpa o marcador. |
| Datas e formatos | Aprovados em Chrome | Espaços em branco, data invertida, e-mail inválido, senha curta e quantidades 0/1,5/1001 rejeitados. |
| Privacidade no fluxo | Aprovada no protótipo | Aviso acessível e sem chamadas externas ou requisições de envio nos cenários testados. |
| JavaScript desativado | Aprovado | Envio continua desabilitado no login e questionário. |
| Layout móvel | Aprovado em Chrome a 390 × 844 | Início, questionário, aviso e apresentação sem rolagem horizontal. Não substitui teste em todos os aparelhos. |
| Apresentação | Navegação aprovada em Chrome | Sete slides, botões e contador. Revisão visual local registrada na entrega. |
| Links internos | Conferidos pelo script | [Verificador](../tests/check-links.cjs), destinos HTML/Markdown. URLs externas não entram nessa contagem. |
| Publicação externa | Pendente | Workflow preparado; falta acesso de escrita/configuração e confirmação da URL pública. |

## Resultados de referência do banco

Todos os dados são fictícios. Q1: geradas 6/4/2/0 e recebidas 5/3/1/0 por questionário 1/2/3/4, com 83,33%/75%/50%/0%. Q2 inclui alternativas com zero respostas. Q3 apresenta médias 4, 4, 2 e NULL para o questionário vazio. Q5 mantém apenas questionário 1 com cinco avaliações e média 4.

Os scripts Oracle preservam o modelo anterior com NUMBER/VARCHAR2/DATE. Para comprovar a entrega no SGBD da disciplina, executar [schema.sql](banco-de-dados/schema.sql), [povoamento.sql](banco-de-dados/povoamento.sql), [validacao.sql](banco-de-dados/validacao.sql) e [queries.sql](banco-de-dados/queries.sql) e registrar aqui a data/versão do Oracle e os resultados.

## Revisão das quatro pastas

| Pasta | Evidência atual | Revisão ainda necessária |
| --- | --- | --- |
| engenharia-software | Requisitos, casos de uso, especificação e arquivos Astah existentes | Confirmar cobertura dos requisitos e exportações de classes/sequência. Os novos artefatos não encerram automaticamente Issues #1/#2. |
| banco-de-dados | Modelo textual anterior, DDL extraído, INSERTs, cinco SELECTs e validações | Executar em Oracle; revisar modelos/normalização nas Issues #3/#4. |
| desenvolvimento-web | Fonte extraída, JS, CSS, aviso, apresentação e workflow | Publicar e testar URL. Revisar materiais das Issues #6/#7 antes de aceite integral. |
| seguranca | Relatório LGPD, retenção proposta e aviso no front-end | Confirmar política institucional para produção, revisar Issue #10 e converter o PDF legado após leitura. |

## Mídia de apresentação

- [Slides HTML na pasta de evidências](evidencias/apresentacao.html): sete slides editáveis em formato aberto.
- [Versão dos slides junto ao site](desenvolvimento-web/src/apresentacao.html).
- [Roteiro de fala e demonstração](evidencias/roteiro-apresentacao.md): 6 a 8 minutos.

Não há vídeo gravado, declaração de aprovação dos professores ou validação com usuários reais. A mídia entregue é a apresentação HTML.

## Critérios de encerramento

- Issue #5: scripts disponíveis; falta evidência Oracle para declarar execução nesse banco.
- Issue #8: implementação e teste local prontos; enviar os arquivos e os links ao repositório para revisão acadêmica.
- Issue #11: relatório e aviso prontos para o protótipo, com políticas propostas e limites explícitos. Produção exige completar as medidas descritas.
- Issue #9: manter aberta até publicação, URL pública validada e link no topo do README.
- Issue #12: materiais e revisão local prontos, mas manter aberta até sanar pendências das quatro disciplinas e validar a aplicação publicada.

## Pendências para o responsável

1. Enviar a entrega ao GitHub com acesso de escrita, preservando as pastas.
2. Executar Oracle e anexar evidência textual de resultados neste documento.
3. Seguir [publicacao.md](desenvolvimento-web/publicacao.md), registrar a URL pública e testar os links no ambiente real.
4. Confirmar a lista de integrantes e o aceite acadêmico dos artefatos anteriores.
5. Atualizar as issues com links diretos e os resultados efetivamente verificados.

[Voltar ao README](../README.md).
