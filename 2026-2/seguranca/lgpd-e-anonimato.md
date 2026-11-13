# Relatório de adequação à LGPD e mecanismos de anonimato

Issue #11 · Prof. Alciano Gustavo Genovez de Oliveira · 13/11/2026.

## 1. Escopo e conclusão da avaliação

Sistema Web para Gestão de Pesquisas por Questionários, Projeto Integrador ADS, Fatec Lins. Foram analisados o [modelo Oracle](../banco-de-dados/schema.sql), os [requisitos](../engenharia-software/requisitos.md) e o [front-end](../desenvolvimento-web/src/README.md).

Esta entrega fornece controles na demonstração estática e uma política proposta para a aplicação futura. Não certifica conformidade integral. Não há backend, login real, armazenamento de respostas ou gestão operacional de direitos. A publicação deve servir apenas à demonstração com dados fictícios. A coleta com pessoas reais permanece bloqueada até as providências da seção 8.

## 2. Inventário e minimização

| Contexto | Dados | Situação e finalidade |
| --- | --- | --- |
| Respondente na demonstração | Opção, nota, comentário opcional, ciência do aviso | Somente campos em memória da página. Não há requisição de envio ou persistência das respostas. |
| Navegador | Marcador de demonstração concluída em sessionStorage | Simula bloqueio nesta aba. Não contém código, respostas ou identidade. Reiniciar remove o marcador. |
| Formulário demonstrativo de login | E-mail e senha fictícios | JS valida o formato e descarta os campos. Não autentica, não transmite nem persiste credenciais. Aviso proíbe senha real. |
| Modelo de administradores | Nome, e-mail, perfil, hash, auditoria de ações | São dados pessoais no sistema futuro. Usar somente o mínimo necessário e definir base legal própria. O povoamento contém pessoas e hashes fictícios. |
| Modelo de respostas | Questionário, pergunta, alternativa, nota ou texto, datas | Não há FK de submissao para usuario ou senha_acesso. Texto e metadados ainda podem permitir identificação indireta. |
| Hospedagem | Possíveis IPs e registros técnicos | O provedor e sua política precisam ser identificados após o deploy. A equipe não controla necessariamente esses registros. |

Não coletar CPF, matrícula, nome, e-mail, telefone ou geolocalização no questionário. Categorias são amplas (alunos/professores/funcionários), sem recortes adicionais de turma, cargo único ou horários. Comentários devem ser opcionais e receber revisão antes de divulgação. Na demonstração, nenhum conteúdo digitado sai do formulário.

## 3. Base legal, transparência e participação

A LGPD distingue dados pessoais e dados efetivamente anonimizados. Consentimento é uma das bases possíveis, não uma exigência universal para todo tratamento. O controlador deverá justificar a base aplicável por finalidade (arts. 7º e 11) antes de qualquer coleta real. O caráter acadêmico não autoriza presumir uma dispensa geral.

Para o exemplo de pesquisa voluntária, a interface apresenta aviso antes do preenchimento e confirmação desmarcada por padrão. A confirmação registra apenas a interação visual durante a demonstração, não cria prova persistente de consentimento nem substitui uma base legal definida. Não se misturam consentimento para pesquisa, publicidade e uso de credenciais.

O documento entregue é um **aviso de privacidade**, alternativa prevista na issue. Não é um TCLE aprovado por comitê de ética. Caso a pesquisa concreta exija TCLE ou avaliação ética, a instituição deverá providenciá-los.

## 4. Mecanismos e limites do anonimato

1. O modelo separa tabelas de acesso das submissões, sem relação direta entre código e resposta. Não há planilha nome–senha prevista na distribuição. Em produção, distribuir códigos aleatoriamente, sem registrar destinatários.
2. O front-end não grava respostas em localStorage/sessionStorage, cookies, URL ou console. O marcador de demonstração não prova uso único global e pode ser apagado pelo usuário.
3. O código DEMO2026 é público e exclusivo de demonstração. Senhas reais precisam de geração criptograficamente segura, restrição de unicidade, limites de tentativas e validação no servidor.
4. O backend deverá validar dados e consumir a senha na mesma transação da gravação da resposta. Uma falha deve desfazer ambas as operações. Nunca retornar o código nas respostas, auditoria ou exportação. Testar concorrência para impedir submissões duplicadas.
5. O esquema legado armazena códigos em claro e timestamps em senha_acesso.utilizada_em e submissao.enviada_em. A proximidade temporal pode correlacionar pessoas e respostas por meio de logs. Antes de produção, substituir códigos por verificação protegida (ex.: HMAC com segredo fora do banco), reduzir precisão temporal das respostas e impedir logs correlacionáveis. Hash isolado não garante anonimato de códigos de baixa entropia.
6. Usar relatórios agregados. A [consulta Q5](../banco-de-dados/queries.sql) demonstra limiar mínimo de cinco avaliações. Esse número é uma escolha didática, não um padrão legal ou garantia de anonimato. Revisar cruzamentos, valores raros e inferências por diferença e aplicar supressão complementar quando necessário.
7. Não divulgar texto livre bruto. O aviso orienta o participante, mas não impede a inclusão de dados pessoais. Em produção, restringir acesso e revisar/remover identificadores antes de qualquer exportação.

A ausência de nome é insuficiente para garantir anonimato. Até a avaliação do risco residual de identificação direta e indireta, tratar respostas potencialmente identificáveis como dados pessoais. Pseudonimização e criptografia também não equivalem automaticamente à anonimização.

## 5. Retenção e exclusão

Os prazos abaixo são uma **proposta do projeto**, sujeitos à finalidade e à decisão documentada do controlador. Não são prazos obrigatórios fixados pela LGPD. Exceções legais justificadas devem constar do registro de retenção.

| Conjunto | Prazo proposto | Exclusão e responsável |
| --- | --- | --- |
| Respostas da demonstração | Até concluir ou sair da página | JS limpa os campos na conclusão; não há base persistente. O navegador pode manter formulário em histórico/restauração de aba. Fechar/reiniciar descarta o preenchimento corrente. |
| Marcador de demonstração | Sessão da aba | Botão Reiniciar demonstração ou término da sessão de navegação. Restauração de sessão depende do navegador. |
| Respostas brutas da produção futura | Até 90 dias após encerramento da pesquisa | Administrador elimina respostas e submissões, após consolidar resultados e verificar exceções justificadas. |
| Códigos e lotes reais | Até 30 dias após encerramento | Administrador elimina códigos, preservando somente totais de participação sem identificadores. |
| Contas administrativas | Enquanto houver necessidade de acesso | Revogar imediatamente ao desligamento; excluir/anonimizar os dados em até 30 dias, ressalvadas obrigações justificadas. |
| Auditoria administrativa mínima | Até 180 dias | Rotina restrita elimina registros vencidos. Não armazenar respostas, senhas, tokens ou payloads. |
| Backups futuros | Rotação máxima de 30 dias | Operador controla expiração e reaplica exclusões antes de liberar uma restauração. Não manter backup indefinido de dados excluídos. |
| Estatísticas efetivamente anônimas | Até 12 meses, com revisão anual | Coordenador reavalia finalidade e risco antes de conservar por novo período. |
| Logs do provedor | A confirmar antes da coleta real | Controlador registra provedor, prazos e canal. Não prometer prazos de terceiros sem evidência contratual. |

Essas rotinas de produção ainda não estão implementadas. A exclusão deve produzir registro administrativo com conjunto e quantidade removida, data e responsável, sem reproduzir o conteúdo excluído. O banco não tem exclusão em cascata: planejar a ordem por FKs e executar transação controlada. Não executar scripts destrutivos sobre a base acadêmica por rotina automática.

## 6. Direitos, responsáveis e fornecedores

O [aviso exibido](../desenvolvimento-web/src/privacidade.html) explica a natureza da demonstração. Antes da coleta real, a instituição deve designar o controlador, informar um canal de privacidade verificável e identificar operadores/fornecedores. Não se atribui essa função à Fatec, ao professor ou a um integrante sem decisão institucional.

O procedimento futuro deverá receber e registrar solicitações, verificar a identidade de modo proporcional, avaliar acesso/correção/exclusão conforme a base legal e responder nos prazos aplicáveis. Depois de anonimização efetiva, pode não haver como localizar a resposta individual. Isso deve ser informado previamente, sem negar direitos sobre contas, logs ou outros dados pessoais que permaneçam identificáveis.

Não há analytics ou fontes externas na aplicação. Em caso de GitHub Pages, revisar a política do GitHub e as condições de hospedagem, inclusive eventuais transferências internacionais, sem alegar ausência de tratamento de IP pelo provedor.

## 7. Evidências implementadas

| Controle | Evidência | Limite |
| --- | --- | --- |
| Transparência | [privacidade.html](../desenvolvimento-web/src/privacidade.html) | Aviso para demonstração, não aviso institucional de produção. |
| Ciência voluntária | [Questionário](../desenvolvimento-web/src/funcionalidades/rf10-responder-questionario.html) | Não persiste prova de consentimento. |
| Validação e descarte | [app.js](../desenvolvimento-web/src/app.js) | Validação apenas no navegador. |
| Separação estrutural | [schema.sql](../banco-de-dados/schema.sql) | Não elimina identificação indireta ou acesso administrativo ao banco. |
| Supressão didática | [queries.sql](../banco-de-dados/queries.sql) | Não configura política completa de divulgação segura. |
| Dados sintéticos | [povoamento.sql](../banco-de-dados/povoamento.sql) | Não usar as credenciais/códigos fictícios na produção. |

## 8. Condições para uma pesquisa real

- Identificar controlador, canal, operadores, base legal por finalidade e aviso institucional.
- Implementar backend com autenticação e autorização por perfil, HTTPS e consultas parametrizadas.
- Corrigir as regras de integridade do modelo e testar consumo atômico de códigos sob concorrência.
- Validar geração e proteção dos códigos, fluxo de distribuição e política de logs/metadados.
- Implementar retenção, exclusão, direitos, revisão de textos e divulgação estatística segura.
- Avaliar riscos, necessidade de tratamento de dados sensíveis ou de menores, aprovação institucional e eventual exigência ética antes da coleta.

## Referências

- [LGPD, texto atualizado da Câmara dos Deputados](https://www2.camara.leg.br/legin/fed/lei/2018/lei-13709-14-agosto-2018-787077-normaatualizada-pl.html): arts. 5º, 6º, 7º, 11, 12, 15–18 e 46.
- [ANPD — estudos técnicos e orientativos sobre anonimização](https://www.gov.br/anpd/pt-br/centrais-de-conteudo/documentos-tecnicos-orientativos): abordagem de risco e limites de técnicas de anonimização.
- [GitHub — declaração geral de privacidade](https://docs.github.com/pt/site-policy/privacy-policies/github-general-privacy-statement).

Consulta das fontes legais e técnicas: 13/11/2026. As medidas e os prazos propostos neste documento são decisões de projeto a validar institucionalmente.

[Voltar ao projeto](../../README.md).
