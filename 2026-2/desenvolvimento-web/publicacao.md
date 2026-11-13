# Publicação — Issue #9

## Situação

Front-end estático preparado para GitHub Pages. A publicação remota ainda não foi realizada: a conexão consultada possui leitura, sem escrita/administração no repositório. Não existe URL validada desta entrega. Não marcar a Issue #9 como concluída até testar o site público.

O [workflow](../../.github/workflows/pages.yml) publica somente a pasta src, sem SQL, relatórios de segurança ou arquivos do repositório inteiro. A configuração segue a [documentação oficial](https://docs.github.com/en/pages/getting-started-with-github-pages/using-custom-workflows-with-github-pages), consultada em 13/11/2026.

## Passos finais no repositório

1. Enviar os arquivos preparados mantendo a estrutura de pastas, incluindo .github/workflows/pages.yml.
2. Em Settings → Pages → Build and deployment, escolher GitHub Actions. É necessário ter permissão de administração para essa configuração inicial.
3. Fazer merge da entrega em main. O workflow também permite execução manual em Actions → Publicar protótipo → Run workflow.
4. Aguardar a execução ficar verde e copiar a URL retornada pelo ambiente github-pages. A URL esperada para o repositório atual é https://fatec-extensao.github.io/pi-ads-2026-1-richard/ , mas ela não foi confirmada como publicação desta versão.
5. Abrir essa URL em janela privada e no celular. Testar Início, acesso DEMO2026, navegação das perguntas, aviso de privacidade e apresentação.
6. Substituir o aviso no topo do README pelo link real validado e registrar data/URL na validação final.
7. Atualizar a Issue #9 com o link do site e da evidência. Somente então marcar os itens de publicação e README como concluídos.

## Alternativa Vercel

Importar o repositório com autorização de acesso, escolher Other, Root Directory = 2026-2/desenvolvimento-web/src, sem comando de build e sem instalar dependências. Testar a URL retornada e atualizar o README. Não é necessário publicar em dois provedores.

## Limites de hospedagem

GitHub Pages serve o protótipo HTML/CSS/JS. Não executa Oracle nem um backend de coleta. O site informa seu caráter demonstrativo e não deve receber respostas reais. Antes de ativar coleta institucional, aplicar os requisitos de [privacidade](../seguranca/lgpd-e-anonimato.md).

[Voltar ao projeto](../../README.md).
