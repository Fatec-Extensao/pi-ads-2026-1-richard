# Interatividade e validação de formulários — Issue #8

Professor: Prof. Anderson Pazin.

O [código-fonte](src/README.md) usa HTML, CSS e JavaScript puros, sem dependências externas. Parte das páginas já existentes no ZIP do repositório. Todos os formulários recebem validação compartilhada em [app.js](src/app.js).

## Fluxo demonstrável

1. Abra [Início](src/index.html) e selecione Responder à pesquisa de demonstração.
2. No [acesso](src/funcionalidades/rf08-acessar-pesquisa.html), use DEMO2026.
3. No [questionário](src/funcionalidades/rf10-responder-questionario.html), tente avançar sem opção: aparece erro e o foco retorna ao campo.
4. Selecione uma opção e uma nota. Volte para comprovar que as escolhas permanecem.
5. O comentário é opcional. Leia o aviso, marque a ciência e conclua.
6. A conclusão limpa os campos, não envia respostas e simula bloqueio do código nesta aba. Reiniciar demonstração permite outro teste.

## Regras implementadas

| Regra | Comportamento |
| --- | --- |
| Obrigatórios | Rejeita campos vazios, espaços em branco, radio/select sem opção e ciência desmarcada. |
| Tamanho e formato | Confere mínimo/máximo de caracteres e e-mail. Não publica credenciais. |
| Código de acesso | Exige oito letras/números e aceita somente DEMO2026 no exemplo. |
| Quantidade | Verifica intervalo de 1 a 1000 e número inteiro. |
| Período | Data final não pode ser anterior à inicial. |
| Navegação | Avançar valida etapa atual; Voltar preserva respostas. Concluir revalida as três etapas. |
| Acessibilidade | Mensagens junto aos campos, aria-invalid/aria-describedby, retorno de foco, progresso, labels e link de pular conteúdo. |
| Sem JavaScript | Botões de envio ficam desabilitados e há aviso. Evita envio acidental de campos à hospedagem. |
| Privacidade | Sem requisições de formulário e sem persistência de respostas. Somente marcador de demonstração em sessionStorage. |

A validação no cliente pode ser contornada. A aplicação real precisará validar tudo no servidor. Telas de cadastro, relatórios, login e exportação continuam exemplos visuais; a validação não torna essas operações persistentes ou autenticadas.

Evidências e resultados: [validação final](../validacao-final.md).

[Voltar ao projeto](../../README.md).
