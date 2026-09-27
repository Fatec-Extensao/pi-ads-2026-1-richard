# Requisitos do Sistema Web para Gestão de Pesquisas por Questionários

> Origem: seções 1 a 7 de [p2-engs.md](../../2026-1/engenharia-de-software/p2-engs.md), convertido do documento existente em 2026-1. A organização para 2026-2 não representa uma nova elaboração ou aprovação acadêmica.

## 1. Identificação do Grupo e Tema

Alunos: Richard, Matheus Soares, Gustavo William, Marcelo Cardoso Vendrame e Gustavo Nogueira Souza.

Tema: Sistema Web para Gestão de Pesquisas por Questionários.

## 2. Estudo de Caso

O projeto consiste no desenvolvimento de uma plataforma web voltada para a criação, aplicação e análise de pesquisas institucionais. O foco principal é garantir que as instituições possam coletar dados de diferentes grupos, como alunos, professores e colaboradores, de forma organizada, segura e anônima.

O diferencial do sistema é a garantia do anonimato: o acesso à pesquisa ocorre por meio de senhas aleatórias geradas em lotes, que não identificam diretamente o respondente e podem ser utilizadas apenas uma vez. Além da coleta de respostas, o sistema deve fornecer ferramentas administrativas para acompanhar a participação e gerar relatórios estatísticos com gráficos para análise dos resultados.

## 3. Atores do Sistema

| **Ator**                                 | **Descrição**                                                                                                                                                                 |
|------------------------------------------|-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| Administrador                            | Usuário responsável pelo controle geral da plataforma. Pode gerenciar usuários, pesquisas, categorias, questionários, senhas, relatórios e permissões.                        |
| Coordenador/Pesquisador                  | Usuário responsável por criar e acompanhar pesquisas específicas. Pode cadastrar pesquisas, montar questionários, gerar senhas, acompanhar respostas e visualizar relatórios. |
| Respondente                              | Usuário que acessa a pesquisa de forma anônima por meio de uma senha válida e responde ao questionário.                                                                       |
| Responsável pela Distribuição das Senhas | Usuário ou funcionário responsável por exportar, imprimir ou distribuir as senhas anônimas geradas pelo sistema.                                                              |

## 4. Requisitos Funcionais

| **Código** | **Requisito Funcional**               | **Descrição**                                                                                                             | **Atores**                                                                       |
|------------|---------------------------------------|---------------------------------------------------------------------------------------------------------------------------|----------------------------------------------------------------------------------|
| RF01       | Cadastrar pesquisa                    | Permitir cadastrar uma pesquisa com título, descrição e período de validade.                                              | Administrador; Coordenador/Pesquisador                                           |
| RF02       | Gerenciar categorias de participantes | Permitir cadastrar, listar, editar e excluir categorias, como alunos, docentes, funcionários ou colaboradores.            | Administrador; Coordenador/Pesquisador                                           |
| RF03       | Criar questionário                    | Permitir criar questionários associados a uma pesquisa e a uma categoria de participante.                                 | Administrador; Coordenador/Pesquisador                                           |
| RF04       | Cadastrar perguntas                   | Permitir cadastrar perguntas que farão parte dos questionários.                                                           | Administrador; Coordenador/Pesquisador                                           |
| RF05       | Definir tipo de questão               | Permitir definir o tipo da questão, como múltipla escolha, escala de avaliação ou resposta aberta.                        | Administrador; Coordenador/Pesquisador                                           |
| RF06       | Gerar senhas anônimas                 | Permitir gerar lotes de senhas aleatórias, únicas e anônimas para acesso às pesquisas.                                    | Administrador; Coordenador/Pesquisador                                           |
| RF07       | Exportar senhas                       | Permitir exportar as senhas geradas em PDF ou CSV para distribuição.                                                      | Administrador; Coordenador/Pesquisador; Responsável pela Distribuição das Senhas |
| RF08       | Acessar pesquisa com senha            | Permitir que o respondente acesse a pesquisa utilizando uma senha válida.                                                 | Respondente                                                                      |
| RF09       | Validar senha de acesso               | Verificar se a senha informada existe, está válida, pertence à pesquisa e ainda não foi utilizada.                        | Respondente                                                                      |
| RF10       | Responder questionário                | Permitir que o respondente visualize e responda às perguntas do questionário.                                             | Respondente                                                                      |
| RF11       | Registrar respostas                   | Armazenar as respostas enviadas sem associá-las diretamente à identidade do respondente.                                  | Respondente                                                                      |
| RF12       | Impedir reutilização de senha         | Marcar a senha como utilizada após o envio das respostas, impedindo novo acesso com o mesmo código.                       | Respondente                                                                      |
| RF13       | Monitorar participação                | Exibir dados de acompanhamento, como senhas geradas, senhas utilizadas, respostas recebidas e percentual de participação. | Administrador; Coordenador/Pesquisador                                           |
| RF14       | Gerar relatórios estatísticos         | Gerar relatórios com gráficos e informações estatísticas sobre os resultados das pesquisas.                               | Administrador; Coordenador/Pesquisador                                           |
| RF15       | Exportar resultados                   | Permitir exportar os resultados das pesquisas em PDF ou CSV.                                                              | Administrador; Coordenador/Pesquisador                                           |

## 5. Requisitos Não Funcionais

| **Requisito Não Funcional** | **Descrição**                                                                                                             |
|-----------------------------|---------------------------------------------------------------------------------------------------------------------------|
| Usabilidade                 | O sistema deve possuir interface amigável, intuitiva e responsiva, permitindo o uso em computadores, tablets e celulares. |
| Performance                 | O sistema deve suportar múltiplos acessos simultâneos durante o período de aplicação das pesquisas.                       |
| Portabilidade               | O sistema deve ser compatível com navegadores modernos, como Google Chrome, Mozilla Firefox e Microsoft Edge.             |
| Disponibilidade             | O sistema deve permanecer disponível durante o período de validade das pesquisas cadastradas.                             |

## 6. User Stories

Como Administrador, quero controlar usuários e permissões para garantir que cada perfil acesse apenas as funções permitidas.

Como Coordenador/Pesquisador, quero criar pesquisas e questionários para coletar dados institucionais de forma organizada.

Como Coordenador/Pesquisador, quero gerar senhas anônimas para permitir que os participantes respondam sem identificação direta.

Como Responsável pela Distribuição das Senhas, quero exportar os lotes de senhas para realizar a distribuição aos participantes.

Como Respondente, quero acessar a pesquisa com uma senha anônima para responder sem revelar minha identidade.

Como Respondente, quero responder ao questionário pelo celular para facilitar minha participação.

Como Administrador ou Coordenador/Pesquisador, quero visualizar gráficos e relatórios para analisar os resultados das pesquisas.

Como Administrador ou Coordenador/Pesquisador, quero exportar os resultados em PDF ou CSV para documentação e análises externas.

## 7. Requisitos de Segurança

| **Código** | **Requisito de Segurança**                     | **Descrição**                                                                                                                                                   |
|------------|------------------------------------------------|-----------------------------------------------------------------------------------------------------------------------------------------------------------------|
| RS01       | Autenticação administrativa                    | O sistema deve exigir login e senha para usuários administrativos antes de permitir acesso às funcionalidades de gerenciamento.                                 |
| RS02       | Controle de acesso por perfil                  | O sistema deve limitar as funcionalidades conforme o perfil do usuário, como Administrador, Coordenador/Pesquisador e Responsável pela Distribuição das Senhas. |
| RS03       | Armazenamento seguro de senhas administrativas | As senhas dos usuários administrativos devem ser armazenadas utilizando hash seguro, impedindo visualização direta no banco de dados.                           |
| RS04       | Geração segura de senhas anônimas              | As senhas de acesso às pesquisas devem ser aleatórias, únicas e difíceis de adivinhar.                                                                          |
| RS05       | Uso único das senhas anônimas                  | Cada senha anônima deve permitir apenas uma resposta ao questionário e deve ser bloqueada após o uso.                                                           |
| RS06       | Preservação do anonimato                       | O sistema não deve associar as respostas diretamente à identidade do respondente.                                                                               |
| RS07       | Validação da senha de acesso                   | O sistema deve verificar se a senha existe, pertence à pesquisa correta, está dentro do prazo de validade e ainda não foi utilizada.                            |
| RS08       | Proteção contra acesso não autorizado          | O sistema deve impedir acesso direto às páginas administrativas sem autenticação.                                                                               |
| RS09       | Proteção contra alteração indevida de dados    | Somente usuários autorizados devem poder editar, excluir ou visualizar pesquisas, questionários, senhas e relatórios.                                           |
| RS10       | Proteção contra SQL Injection                  | O sistema deve utilizar consultas preparadas para impedir comandos maliciosos no banco de dados.                                                                |
| RS11       | Proteção contra XSS                            | O sistema deve tratar dados exibidos nas páginas para impedir execução de scripts maliciosos.                                                                   |
| RS12       | Validação de dados de entrada                  | O sistema deve validar campos obrigatórios, formatos e regras antes de salvar informações.                                                                      |
| RS13       | Registro de ações administrativas              | O sistema deve registrar ações importantes, como criação de pesquisas, geração de senhas e exportação de relatórios.                                            |
| RS14       | Proteção dos relatórios exportados             | Somente usuários autorizados devem poder gerar ou baixar relatórios e arquivos exportados.                                                                      |
| RS15       | Encerramento automático de sessão              | O sistema deve encerrar sessões administrativas após um período de inatividade.                                                                                 |


## Documentos relacionados

- [Diagramas de casos de uso RF01 a RF09](modelagem-uml/casos-de-uso.md).
- [Fluxos principais e alternativos RF01 a RF15](modelagem-uml/especificacao.md).
