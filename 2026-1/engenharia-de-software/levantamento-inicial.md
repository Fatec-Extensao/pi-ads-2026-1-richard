**SISTEMA WEB PARA GESTÃO DE PESQUISAS POR QUESTIONÁRIOS**

**1. Identificação do Grupo e Tema**

Alunos: Richard, Matheus Soares e Gustavo William.

Tema: Sistema Web para Gestão de Pesquisas por Questionários.

**2. Estudo de Caso**

O projeto consiste no desenvolvimento de uma plataforma web voltada para a criação, aplicação e análise de pesquisas institucionais. O foco principal é garantir que as instituições possam coletar dados de diferentes grupos (como alunos, professores e colaboradores) de forma organizada e segura. O grande diferencial do sistema é a garantia do anonimato: o acesso à pesquisa é feito por meio de senhas aleatórias geradas em lotes, que não identificam o respondente e são descartadas após o uso único. Além da coleta, o sistema deve fornecer ferramentas administrativas para monitorar a participação em tempo real e gerar relatórios estatísticos com gráficos para análise de resultados.

**3. Requisitos Funcionais**

1\. Cadastrar pesquisas: Permitir a criação de pesquisas com título, descrição e período de validade.

2\. Gerenciar categorias: Cadastrar diferentes perfis de participantes (Ex: Alunos, Docentes).

3\. Criar questionários: Elaborar perguntas específicas para cada categoria de participante.

4\. Definir tipos de questões: Suportar múltipla escolha, escalas (1 a 5) e respostas abertas.

5\. Gerar senhas anônimas: Criar lotes de senhas aleatórias por categoria para distribuição.

6\. Aplicar questionário via senha: Validar o acesso do usuário apenas mediante senha válida.

7\. Registrar respostas: Gravar os dados coletados de forma segura no banco de dados.

8\. Impedir reutilização: Marcar a senha como utilizada e bloquear novos acessos com o mesmo código.

9\. Monitorar participação: Exibir dashboard com total de senhas geradas e respostas recebidas.

10\. Gerar relatórios: Criar visões analíticas com gráficos e exportação para PDF/CSV.

11\. Exportação de Senhas: Permitir exportar as senhas geradas em PDF ou CSV.

**4. Requisitos Não Funcionais**

Usabilidade: Interface amigável, intuitiva e responsiva.

Segurança: Criptografia de senhas e dados sensíveis.

Performance: Suporte a múltiplos acessos simultâneos.

Portabilidade: Compatível com navegadores modernos (Chrome, Firefox, Edge).

**5. Atores do Sistema**

Administrador: Responsável por gerenciar pesquisas, perguntas, senhas e relatórios.

Respondente: Usuário que acessa e responde a pesquisa de forma anônima.

Sistema: Responsável por validações, controle e processamento de dados.

**6. User Stories**

Como Administrador, quero gerar senhas aleatórias para distribuição anônima.

Como Administrador, quero visualizar gráficos em tempo real para monitorar respostas.

Como Respondente, quero acessar o sistema apenas com senha para manter anonimato.

Como Respondente, quero uma interface responsiva para responder via celular.

Como Administrador, quero exportar resultados em CSV para análises externas.
