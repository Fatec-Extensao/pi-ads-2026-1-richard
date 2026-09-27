# Fluxos principais e alternativos dos casos de uso

> Transcrição da seção 9 de [p2-engs.md](../../../2026-1/engenharia-de-software/p2-engs.md). São fluxos textuais de casos de uso; não substituem os diagramas de classes e sequência pendentes da Issue #2.

[Requisitos](../requisitos.md) | [Diagramas existentes](casos-de-uso.md)


*Nesta seção são apresentados os fluxos principais e alternativos de cada requisito funcional do sistema. Cada fluxo alternativo inicia com o mesmo número do passo do fluxo principal em que ocorre, e suas etapas internas seguem a numeração complementar, como 4.1, 4.2 e 4.3.*

**RF01 — Cadastrar pesquisa**

**Ator principal: Administrador ou Coordenador/Pesquisador.**

**Fluxo principal**

1\. O ator acessa a área administrativa do sistema.

2\. O ator seleciona a opção de cadastrar nova pesquisa.

3\. O sistema exibe o formulário de cadastro.

4\. O ator informa título, descrição e período de validade da pesquisa.

5\. O ator confirma o cadastro.

6\. O sistema valida os dados informados.

7\. O sistema registra a pesquisa no banco de dados.

8\. O sistema exibe uma mensagem de sucesso.

**Fluxos alternativos**

**4 — Campos obrigatórios não preenchidos**

4.1. O ator deixa de preencher título, descrição ou período de validade.

4.2. O sistema identifica os campos obrigatórios vazios.

4.3. O sistema exibe uma mensagem de erro.

4.4. O ator corrige os dados.

4.5. O fluxo retorna ao passo 5 do fluxo principal.

**6 — Período de validade inválido**

6.1. O sistema identifica que a data final é anterior à data inicial.

6.2. O sistema exibe uma mensagem informando o erro.

6.3. O ator ajusta as datas.

6.4. O fluxo retorna ao passo 6 do fluxo principal.

**RF02 — Gerenciar categorias de participantes**

**Ator principal: Administrador ou Coordenador/Pesquisador.**

**Fluxo principal**

1\. O ator acessa a área de categorias.

2\. O sistema exibe as categorias cadastradas.

3\. O ator seleciona a opção de cadastrar nova categoria.

4\. O ator informa o nome da categoria.

5\. O sistema valida os dados informados.

6\. O sistema registra a categoria no banco de dados.

7\. O sistema exibe uma mensagem de sucesso.

**Fluxos alternativos**

**4 — Nome da categoria não informado**

4.1. O ator deixa o campo de nome da categoria vazio.

4.2. O sistema identifica a ausência da informação.

4.3. O sistema exibe uma mensagem de erro.

4.4. O ator informa o nome da categoria.

4.5. O fluxo retorna ao passo 5 do fluxo principal.

**5 — Categoria já cadastrada**

5.1. O sistema identifica que já existe uma categoria com o mesmo nome.

5.2. O sistema exibe uma mensagem de aviso.

5.3. O ator altera o nome da categoria ou cancela a operação.

5.4. Caso o ator altere o nome, o fluxo retorna ao passo 5 do fluxo principal.

**RF03 — Criar questionário**

**Ator principal: Administrador ou Coordenador/Pesquisador.**

**Fluxo principal**

1\. O ator acessa a área de questionários.

2\. O ator seleciona a opção de criar questionário.

3\. O sistema exibe o formulário de criação.

4\. O ator seleciona a pesquisa relacionada.

5\. O ator seleciona a categoria de participante.

6\. O ator informa o título ou identificação do questionário.

7\. O ator confirma a criação.

8\. O sistema valida os dados.

9\. O sistema registra o questionário no banco de dados.

10\. O sistema exibe uma mensagem de sucesso.

**Fluxos alternativos**

**4 — Pesquisa não selecionada**

4.1. O ator tenta criar o questionário sem selecionar uma pesquisa.

4.2. O sistema identifica a ausência da pesquisa.

4.3. O sistema exibe uma mensagem de erro.

4.4. O ator seleciona uma pesquisa válida.

4.5. O fluxo retorna ao passo 5 do fluxo principal.

**5 — Categoria não selecionada**

5.1. O ator não seleciona uma categoria de participante.

5.2. O sistema identifica a ausência da categoria.

5.3. O sistema exibe uma mensagem de erro.

5.4. O ator seleciona uma categoria válida.

5.5. O fluxo retorna ao passo 6 do fluxo principal.

**RF04 — Cadastrar perguntas**

**Ator principal: Administrador ou Coordenador/Pesquisador.**

**Fluxo principal**

1\. O ator acessa um questionário já criado.

2\. O ator seleciona a opção de adicionar pergunta.

3\. O sistema exibe o formulário de cadastro de pergunta.

4\. O ator informa o enunciado da pergunta.

5\. O ator define se a pergunta será obrigatória ou opcional.

6\. O ator confirma o cadastro.

7\. O sistema valida os dados.

8\. O sistema registra a pergunta no questionário.

9\. O sistema exibe uma mensagem de sucesso.

**Fluxos alternativos**

**4 — Enunciado não informado**

4.1. O ator deixa o campo do enunciado vazio.

4.2. O sistema identifica que a pergunta não possui enunciado.

4.3. O sistema exibe uma mensagem de erro.

4.4. O ator informa o enunciado.

4.5. O fluxo retorna ao passo 5 do fluxo principal.

**7 — Erro ao salvar pergunta**

7.1. O sistema identifica uma falha ao registrar a pergunta.

7.2. O sistema exibe uma mensagem de erro.

7.3. O ator pode tentar salvar novamente.

7.4. O fluxo retorna ao passo 6 do fluxo principal.

**RF05 — Definir tipo de questão**

**Ator principal: Administrador ou Coordenador/Pesquisador.**

**Fluxo principal**

1\. O ator acessa a tela de cadastro ou edição de pergunta.

2\. O sistema exibe os tipos de questão disponíveis.

3\. O ator seleciona o tipo da questão.

4\. O sistema exibe os campos necessários conforme o tipo selecionado.

5\. O ator preenche as informações complementares, se necessário.

6\. O ator confirma a definição do tipo.

7\. O sistema valida as informações.

8\. O sistema salva o tipo da questão.

9\. O sistema exibe uma mensagem de sucesso.

**Fluxos alternativos**

**3 — Tipo de questão não selecionado**

3.1. O ator tenta salvar a pergunta sem selecionar o tipo.

3.2. O sistema identifica que o tipo da questão não foi definido.

3.3. O sistema exibe uma mensagem de erro.

3.4. O ator seleciona um tipo válido.

3.5. O fluxo retorna ao passo 4 do fluxo principal.

**5 — Alternativas não preenchidas**

5.1. O ator seleciona o tipo múltipla escolha.

5.2. O ator não informa as alternativas da pergunta.

5.3. O sistema identifica a ausência das alternativas.

5.4. O sistema exibe uma mensagem de erro.

5.5. O ator cadastra as alternativas.

5.6. O fluxo retorna ao passo 6 do fluxo principal.

**RF06 — Gerar senhas anônimas**

**Ator principal: Administrador ou Coordenador/Pesquisador.**

**Fluxo principal**

1\. O ator acessa a área de geração de senhas.

2\. O ator seleciona a pesquisa.

3\. O ator seleciona a categoria de participantes.

4\. O ator informa a quantidade de senhas a serem geradas.

5\. O ator confirma a geração.

6\. O sistema valida os dados informados.

7\. O sistema gera senhas aleatórias e únicas.

8\. O sistema registra o lote de senhas no banco de dados.

9\. O sistema exibe uma mensagem de sucesso.

**Fluxos alternativos**

**2 — Pesquisa não selecionada**

2.1. O ator não seleciona uma pesquisa.

2.2. O sistema identifica a ausência da pesquisa.

2.3. O sistema exibe uma mensagem de erro.

2.4. O ator seleciona uma pesquisa válida.

2.5. O fluxo retorna ao passo 3 do fluxo principal.

**4 — Quantidade inválida**

4.1. O ator informa uma quantidade menor ou igual a zero.

4.2. O sistema identifica que a quantidade é inválida.

4.3. O sistema exibe uma mensagem de erro.

4.4. O ator informa uma quantidade válida.

4.5. O fluxo retorna ao passo 5 do fluxo principal.

**7 — Falha ao gerar senhas únicas**

7.1. O sistema identifica uma falha na geração das senhas.

7.2. O sistema interrompe o processo.

7.3. O sistema exibe uma mensagem de erro.

7.4. O ator pode tentar novamente.

7.5. O fluxo retorna ao passo 5 do fluxo principal.

**RF07 — Exportar senhas**

**Ator principal: Administrador, Coordenador/Pesquisador ou Responsável pela Distribuição das Senhas.**

**Fluxo principal**

1\. O ator acessa a área de senhas geradas.

2\. O ator seleciona uma pesquisa ou lote de senhas.

3\. O sistema exibe as senhas disponíveis para exportação.

4\. O ator escolhe o formato de exportação.

5\. O ator confirma a exportação.

6\. O sistema gera o arquivo.

7\. O sistema disponibiliza o arquivo para download.

8\. O ator realiza o download do arquivo.

**Fluxos alternativos**

**2 — Nenhum lote selecionado**

2.1. O ator tenta exportar sem selecionar uma pesquisa ou lote.

2.2. O sistema identifica a ausência da seleção.

2.3. O sistema exibe uma mensagem de erro.

2.4. O ator seleciona um lote válido.

2.5. O fluxo retorna ao passo 3 do fluxo principal.

**3 — Nenhuma senha encontrada**

3.1. O sistema identifica que não existem senhas geradas para a pesquisa selecionada.

3.2. O sistema exibe uma mensagem informando que não há senhas disponíveis.

3.3. O ator pode selecionar outra pesquisa ou gerar novas senhas.

3.4. O fluxo retorna ao passo 2 do fluxo principal.

**6 — Erro ao gerar arquivo**

6.1. O sistema identifica uma falha na geração do arquivo.

6.2. O sistema exibe uma mensagem de erro.

6.3. O ator pode tentar novamente.

6.4. O fluxo retorna ao passo 5 do fluxo principal.

**RF08 — Acessar pesquisa com senha**

**Ator principal: Respondente.**

**Fluxo principal**

1\. O respondente acessa a página inicial da pesquisa.

2\. O sistema exibe o campo para inserir a senha.

3\. O respondente informa a senha recebida.

4\. O respondente confirma o acesso.

5\. O sistema recebe a senha informada.

6\. O sistema encaminha a senha para validação.

7\. O sistema libera o acesso ao questionário.

8\. O respondente visualiza a pesquisa.

**Fluxos alternativos**

**3 — Senha não informada**

3.1. O respondente deixa o campo de senha vazio.

3.2. O sistema identifica a ausência da senha.

3.3. O sistema exibe uma mensagem solicitando o preenchimento.

3.4. O respondente informa a senha.

3.5. O fluxo retorna ao passo 4 do fluxo principal.

**6 — Senha rejeitada na validação**

6.1. O sistema identifica que a senha não é válida.

6.2. O sistema bloqueia o acesso ao questionário.

6.3. O sistema exibe uma mensagem de erro.

6.4. O respondente pode tentar informar outra senha.

6.5. O fluxo retorna ao passo 3 do fluxo principal.

**RF09 — Validar senha de acesso**

**Ator principal: Respondente.**

**Fluxo principal**

1\. O respondente informa a senha de acesso.

2\. O sistema recebe a senha.

3\. O sistema verifica se a senha existe.

4\. O sistema verifica se a senha pertence a uma pesquisa cadastrada.

5\. O sistema verifica se a pesquisa está dentro do período de validade.

6\. O sistema verifica se a senha ainda não foi utilizada.

7\. O sistema considera a senha válida.

8\. O sistema autoriza o acesso ao questionário.

**Fluxos alternativos**

**3 — Senha inexistente**

3.1. O sistema não encontra a senha informada.

3.2. O sistema exibe uma mensagem de senha inválida.

3.3. O acesso ao questionário é bloqueado.

3.4. O fluxo retorna ao RF08 — Acessar pesquisa com senha.

**5 — Pesquisa fora do período de validade**

5.1. O sistema identifica que a pesquisa ainda não começou ou já foi encerrada.

5.2. O sistema bloqueia o acesso.

5.3. O sistema exibe uma mensagem informando que a pesquisa não está disponível.

5.4. O caso de uso é encerrado.

**6 — Senha já utilizada**

6.1. O sistema identifica que a senha já foi utilizada.

6.2. O sistema bloqueia o acesso ao questionário.

6.3. O sistema exibe uma mensagem informando que a senha não pode ser reutilizada.

6.4. O caso de uso é encerrado.

**RF10 — Responder questionário**

**Ator principal: Respondente.**

**Fluxo principal**

1\. O respondente acessa o questionário após a validação da senha.

2\. O sistema exibe as perguntas da pesquisa.

3\. O respondente lê as perguntas.

4\. O respondente preenche as respostas.

5\. O respondente confirma o envio do questionário.

6\. O sistema valida as respostas.

7\. O sistema encaminha as respostas para registro.

8\. O sistema exibe uma mensagem de conclusão.

**Fluxos alternativos**

**4 — Resposta obrigatória não preenchida**

4.1. O respondente deixa uma pergunta obrigatória sem resposta.

4.2. O sistema identifica a ausência da resposta obrigatória.

4.3. O sistema informa quais perguntas precisam ser respondidas.

4.4. O respondente preenche as respostas pendentes.

4.5. O fluxo retorna ao passo 5 do fluxo principal.

**6 — Resposta em formato inválido**

6.1. O sistema identifica uma resposta incompatível com o tipo da questão.

6.2. O sistema exibe uma mensagem de erro.

6.3. O respondente corrige a resposta.

6.4. O fluxo retorna ao passo 5 do fluxo principal.

**RF11 — Registrar respostas**

**Ator principal: Respondente.**

**Fluxo principal**

1\. O respondente envia o questionário respondido.

2\. O sistema recebe as respostas.

3\. O sistema valida os dados recebidos.

4\. O sistema associa as respostas à pesquisa correspondente.

5\. O sistema registra as respostas no banco de dados.

6\. O sistema preserva o anonimato do respondente.

7\. O sistema confirma o registro das respostas.

8\. O sistema encaminha o processo para inutilização da senha.

**Fluxos alternativos**

**3 — Dados incompletos ou inconsistentes**

3.1. O sistema identifica que existem dados incompletos ou inconsistentes.

3.2. O sistema bloqueia o registro das respostas.

3.3. O sistema exibe uma mensagem de erro.

3.4. O fluxo retorna ao RF10 — Responder questionário.

**5 — Erro ao salvar no banco de dados**

5.1. O sistema identifica uma falha ao salvar as respostas.

5.2. O sistema não conclui o registro.

5.3. O sistema exibe uma mensagem de erro.

5.4. O respondente pode tentar enviar novamente.

5.5. O fluxo retorna ao RF10 — Responder questionário.

**RF12 — Impedir reutilização de senha**

**Ator principal: Respondente.**

**Fluxo principal**

1\. O respondente envia o questionário.

2\. O sistema registra as respostas com sucesso.

3\. O sistema identifica a senha utilizada no acesso.

4\. O sistema altera o status da senha para utilizada.

5\. O sistema salva a alteração no banco de dados.

6\. O sistema bloqueia novos acessos com a mesma senha.

7\. O sistema conclui o processo de resposta.

8\. O sistema exibe uma mensagem de finalização.

**Fluxos alternativos**

**2 — Respostas não registradas**

2.1. O sistema identifica que as respostas não foram salvas corretamente.

2.2. O sistema não marca a senha como utilizada.

2.3. O sistema exibe uma mensagem de erro.

2.4. O fluxo retorna ao RF10 — Responder questionário.

**5 — Falha ao atualizar status da senha**

5.1. O sistema identifica uma falha ao alterar o status da senha.

5.2. O sistema interrompe a finalização do processo.

5.3. O sistema exibe uma mensagem de erro.

5.4. O respondente pode tentar enviar novamente.

5.5. O fluxo retorna ao RF10 — Responder questionário.

**RF13 — Monitorar participação**

**Ator principal: Administrador ou Coordenador/Pesquisador.**

**Fluxo principal**

1\. O ator acessa o painel de monitoramento.

2\. O sistema exibe as pesquisas disponíveis.

3\. O ator seleciona uma pesquisa.

4\. O sistema busca os dados de participação.

5\. O sistema exibe a quantidade de senhas geradas.

6\. O sistema exibe a quantidade de senhas utilizadas.

7\. O sistema exibe a quantidade de respostas recebidas.

8\. O sistema apresenta o percentual de participação.

**Fluxos alternativos**

**3 — Pesquisa não selecionada**

3.1. O ator não seleciona uma pesquisa.

3.2. O sistema exibe uma mensagem solicitando a seleção.

3.3. O ator seleciona uma pesquisa.

3.4. O fluxo retorna ao passo 4 do fluxo principal.

**4 — Nenhum dado encontrado**

4.1. O sistema não encontra dados de participação para a pesquisa.

4.2. O sistema exibe os indicadores zerados.

4.3. O sistema informa que ainda não há participação registrada.

4.4. O fluxo segue para o passo 8 do fluxo principal.

**RF14 — Gerar relatórios estatísticos**

**Ator principal: Administrador ou Coordenador/Pesquisador.**

**Fluxo principal**

1\. O ator acessa a área de relatórios.

2\. O sistema exibe as pesquisas disponíveis.

3\. O ator seleciona uma pesquisa.

4\. O sistema busca as respostas registradas.

5\. O sistema processa os dados coletados.

6\. O sistema gera gráficos e indicadores estatísticos.

7\. O sistema exibe o relatório na tela.

8\. O ator visualiza os resultados.

**Fluxos alternativos**

**3 — Pesquisa não selecionada**

3.1. O ator tenta gerar relatório sem selecionar uma pesquisa.

3.2. O sistema exibe uma mensagem solicitando a seleção.

3.3. O ator seleciona uma pesquisa válida.

3.4. O fluxo retorna ao passo 4 do fluxo principal.

**4 — Pesquisa sem respostas**

4.1. O sistema identifica que não existem respostas registradas.

4.2. O sistema não gera os gráficos.

4.3. O sistema exibe uma mensagem informando que não há dados suficientes.

4.4. O caso de uso é encerrado.

**6 — Falha no processamento dos dados**

6.1. O sistema identifica uma falha ao processar as respostas.

6.2. O sistema não exibe o relatório.

6.3. O sistema apresenta uma mensagem de erro.

6.4. O ator pode tentar gerar o relatório novamente.

6.5. O fluxo retorna ao passo 3 do fluxo principal.

**RF15 — Exportar resultados**

**Ator principal: Administrador ou Coordenador/Pesquisador.**

**Fluxo principal**

1\. O ator acessa a área de relatórios.

2\. O ator seleciona a pesquisa desejada.

3\. O sistema exibe o relatório estatístico.

4\. O ator seleciona a opção de exportar resultados.

5\. O ator escolhe o formato de exportação, PDF ou CSV.

6\. O sistema gera o arquivo solicitado.

7\. O sistema disponibiliza o arquivo para download.

8\. O ator realiza o download do arquivo.

**Fluxos alternativos**

**2 — Pesquisa não selecionada**

2.1. O ator tenta exportar sem selecionar uma pesquisa.

2.2. O sistema exibe uma mensagem solicitando a seleção.

2.3. O ator seleciona uma pesquisa válida.

2.4. O fluxo retorna ao passo 3 do fluxo principal.

**3 — Relatório sem dados**

3.1. O sistema identifica que a pesquisa não possui respostas registradas.

3.2. O sistema bloqueia a exportação.

3.3. O sistema exibe uma mensagem informando que não há dados disponíveis.

3.4. O caso de uso é encerrado.

**5 — Formato não selecionado**

5.1. O ator tenta exportar sem escolher o formato do arquivo.

5.2. O sistema exibe uma mensagem solicitando a escolha entre PDF ou CSV.

5.3. O ator seleciona o formato desejado.

5.4. O fluxo retorna ao passo 6 do fluxo principal.

**6 — Erro ao gerar arquivo**

6.1. O sistema identifica uma falha ao gerar o arquivo.

6.2. O sistema exibe uma mensagem de erro.

6.3. O ator pode tentar novamente.

6.4. O fluxo retorna ao passo 5 do fluxo principal.
