algoritmo "gerador_de_senhas_por_categoria"
 
var
   senhas: vetor[1..10] de caractere
   caracteresPermitidos, categoria, senhaAtual: caractere
   i, j, posicao: inteiro
 
inicio
   caracteresPermitidos <- "ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789@!#"
 
   para i de 1 ate 10 faca
      repita
         escreval("")
         escreval("Geracao da senha ", i, " de 10")
         escreval("Informe a categoria do usuario:")
         escreva("P - Professor, A - Aluno ou F - Funcionario: ")
         leia(categoria)
         categoria <- maiusc(categoria)
 
         se (categoria <> "P") e (categoria <> "A") e (categoria <> "F") entao
            escreval("Categoria invalida. Digite somente P, A ou F.")
         fimse
      ate (categoria = "P") ou (categoria = "A") ou (categoria = "F")
 
      senhaAtual <- categoria
 
      para j de 1 ate 7 faca
         posicao <- randi(39) + 1
         senhaAtual <- senhaAtual + copia(caracteresPermitidos, posicao, 1)
      fimpara
 
      senhas[i] <- senhaAtual
      escreval("Senha gerada: ", senhas[i])
   fimpara
 
   escreval("")
   escreval("LISTA FINAL DAS 10 SENHAS GERADAS")
 
   para i de 1 ate 10 faca
      escreval(i, " - ", senhas[i])
   fimpara
 
fimalgoritmo
