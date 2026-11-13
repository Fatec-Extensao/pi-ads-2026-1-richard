# Roteiro de apresentação — Issue #12

Duração sugerida: 6 a 8 minutos. [Abrir slides HTML](../desenvolvimento-web/src/apresentacao.html). Os slides funcionam offline e usam teclas de direção ou botões. A fonte permanece em HTML/Markdown, conforme o guia de entregas.

| Parte | Tempo | Fala sugerida e demonstração |
| --- | --- | --- |
| Problema e proposta | 1 min | Explicar a necessidade de organizar questionários institucionais, controlar participação e reduzir a identificação do respondente. |
| Fluxo da solução | 1 min | Mostrar pesquisa por categoria, código de acesso, preenchimento e análise. Distinguir o modelo de produção do protótipo estático. |
| Front-end | 2 min | Abrir o site, usar DEMO2026, tentar avançar vazio, preencher e voltar. Mostrar que as escolhas permanecem, ler o aviso e concluir. Explicar que a resposta não foi salva. |
| Banco e relatórios | 1 a 2 min | Mostrar as 12 tabelas, os INSERTs fictícios e três consultas: participação, alternativas e média. Usar resultados de referência sem alegar execução Oracle não realizada. |
| Privacidade | 1 min | Mostrar a ausência de vínculo direto entre senha e submissão. Explicar risco de texto livre, horários e grupos pequenos. Apresentar retenção proposta. |
| Estado e próximos passos | 1 min | Mostrar as verificações locais e pendências reais: backend, Oracle, publicação remota e revisão das outras issues. |

## Preparação antes de apresentar

- Confirmar a lista de integrantes com o grupo, usando o registro acadêmico atual.
- Executar os scripts em Oracle e registrar resultado em validação final.
- Publicar, testar a URL pública e colocá-la no topo do README.
- Abrir previamente apresentação e demonstração em abas separadas.
- Se forem gravar um vídeo, usar dados fictícios e adicionar o arquivo ou link verificável nesta pasta.

## Perguntas prováveis

**Por que o código não aparece na submissão?** Para evitar associação direta entre acesso e conteúdo. Isso não resolve correlação por outros metadados.

**Por que o front-end não garante uma resposta por senha?** O navegador está sob controle do participante. A garantia depende de transação, unicidade e validação no servidor.

**Por que cinco consultas?** Elas mostram participação, distribuição, médias, respostas por tipo e uma supressão estatística didática.

**O sistema já atende completamente à LGPD?** Há aviso e medidas na demonstração. O relatório identifica exigências ainda pendentes para coleta real.

**A aplicação usa Oracle ao responder?** Não. O modelo e os scripts são uma entrega separada do protótipo web estático.

[Voltar à validação](../validacao-final.md).
