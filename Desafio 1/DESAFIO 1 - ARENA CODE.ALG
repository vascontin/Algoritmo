algoritmo "ArenaCode_Championship"
// Disciplina   :Algoritmos e Programação
// Professor   : Andre Olimpio
// Descrição   : Desafio 1 - Arena Code
// Autor(a)    : Davi Vascontin
// Data atual  : 03/10/2026
const
   MAX_EQUIPES = 10
   PONTOS_VITORIA = 3
   PONTOS_EMPATE = 1
   PONTOS_DERROTA = 0

tipo
   tEquipe = registro
      codigo: inteiro
      nome: caractere
      capitao: caractere
      vitorias: inteiro
      empates: inteiro
      derrotas: inteiro
      pontosMarcados: inteiro
      pontosSofridos: inteiro
      saldo: inteiro
      pontos: inteiro
   fimregistro

var
   equipes: vetor[1..MAX_EQUIPES] de tEquipe
   confrontos: vetor[1..MAX_EQUIPES, 1..MAX_EQUIPES] de inteiro
   qtdEquipes, totalPartidas: inteiro
   opcao, i, j: inteiro

// Localiza uma equipe pelo codigo. Retorna 0 se nao encontrar.
funcao localizarEquipe(cod: inteiro): inteiro
var
   i: inteiro
inicio
   retorne 0
   para i de 1 ate qtdEquipes faca
      se equipes[i].codigo = cod entao
         retorne i
      fimse
   fimpara
fimfuncao

// Calcula o saldo de pontos marcados menos pontos sofridos.
procedimento calcularSaldo(indiceEquipe: inteiro)
inicio
   equipes[indiceEquipe].saldo <- equipes[indiceEquipe].pontosMarcados - equipes[indiceEquipe].pontosSofridos
fimprocedimento

// Mostra os dados completos de uma equipe.
procedimento exibirEquipe(indiceEquipe: inteiro)
inicio
   escreval("")
   escreval("Codigo: ", equipes[indiceEquipe].codigo)
   escreval("Equipe: ", equipes[indiceEquipe].nome)
   escreval("Capitao: ", equipes[indiceEquipe].capitao)
   escreval("Vitorias: ", equipes[indiceEquipe].vitorias)
   escreval("Empates: ", equipes[indiceEquipe].empates)
   escreval("Derrotas: ", equipes[indiceEquipe].derrotas)
   escreval("Pontos marcados: ", equipes[indiceEquipe].pontosMarcados)
   escreval("Pontos sofridos: ", equipes[indiceEquipe].pontosSofridos)
   escreval("Saldo: ", equipes[indiceEquipe].saldo)
   escreval("Pontos no campeonato: ", equipes[indiceEquipe].pontos)
fimprocedimento

// Cadastra uma equipe e inicializa todas as estatisticas.
procedimento cadastrarEquipe()
var
   cod, indiceEquipe: inteiro
   nomeEquipe, nomeCapitao: caractere
inicio
   se qtdEquipes >= MAX_EQUIPES entao
      escreval("Limite maximo de equipes atingido!")
   senao
      escreva("Informe o codigo numerico da equipe: ")
      leia(cod)
      enquanto cod <= 0 faca
         escreva("Codigo deve ser maior que zero. Digite novamente: ")
         leia(cod)
      fimenquanto

      enquanto localizarEquipe(cod) <> 0 faca
         escreva("Codigo ja cadastrado. Informe outro codigo: ")
         leia(cod)
         enquanto cod <= 0 faca
            escreva("Codigo deve ser maior que zero. Digite novamente: ")
            leia(cod)
         fimenquanto
      fimenquanto

      escreva("Nome da equipe: ")
      leia(nomeEquipe)
      enquanto nomeEquipe = "" faca
         escreva("O nome nao pode ficar vazio. Digite novamente: ")
         leia(nomeEquipe)
      fimenquanto

      escreva("Nome do capitao: ")
      leia(nomeCapitao)
      enquanto nomeCapitao = "" faca
         escreva("O nome do capitao nao pode ficar vazio. Digite novamente: ")
         leia(nomeCapitao)
      fimenquanto

      qtdEquipes <- qtdEquipes + 1
      equipes[qtdEquipes].codigo <- cod
      equipes[qtdEquipes].nome <- nomeEquipe
      equipes[qtdEquipes].capitao <- nomeCapitao
      equipes[qtdEquipes].vitorias <- 0
      equipes[qtdEquipes].empates <- 0
      equipes[qtdEquipes].derrotas <- 0
      equipes[qtdEquipes].pontosMarcados <- 0
      equipes[qtdEquipes].pontosSofridos <- 0
      equipes[qtdEquipes].saldo <- 0
      equipes[qtdEquipes].pontos <- 0

      // Posicao da equipe no vetor e usada como linha/coluna da matriz.
      para indiceEquipe de 1 ate MAX_EQUIPES faca
         confrontos[qtdEquipes, indiceEquipe] <- 0
         confrontos[indiceEquipe, qtdEquipes] <- 0
      fimpara

      escreval("Equipe cadastrada com sucesso!")
   fimse
fimprocedimento

// Lista todas as equipes cadastradas.
procedimento listarEquipes()
var
   i: inteiro
inicio
   se qtdEquipes = 0 entao
      escreval("Nenhuma equipe cadastrada.")
   senao
      para i de 1 ate qtdEquipes faca
         escreval(i, " - Codigo: ", equipes[i].codigo, " | Equipe: ", equipes[i].nome, " | Capitao: ", equipes[i].capitao)
      fimpara
   fimse
fimprocedimento

// Registra uma partida, atualizando os dados das duas equipes.
procedimento registrarPartida()
var
   cod1, cod2, pos1, pos2, placar1, placar2: inteiro
inicio
   se qtdEquipes < 2 entao
      escreval("Cadastre pelo menos duas equipes antes de registrar uma partida.")
   senao
      escreva("Codigo da primeira equipe: ")
      leia(cod1)
      pos1 <- localizarEquipe(cod1)

      enquanto pos1 = 0 faca
         escreva("Equipe nao encontrada. Digite outro codigo: ")
         leia(cod1)
         pos1 <- localizarEquipe(cod1)
      fimenquanto

      escreva("Codigo da segunda equipe: ")
      leia(cod2)
      pos2 <- localizarEquipe(cod2)

      enquanto (pos2 = 0) ou (pos2 = pos1) faca
         se pos2 = pos1 entao
            escreva("Uma equipe nao pode jogar contra ela mesma. Digite outro codigo: ")
         senao
            escreva("Equipe nao encontrada. Digite outro codigo: ")
         fimse
         leia(cod2)
         pos2 <- localizarEquipe(cod2)
      fimenquanto

      escreva("Pontos marcados pela primeira equipe: ")
      leia(placar1)
      enquanto placar1 < 0 faca
         escreva("O placar nao pode ser negativo. Digite novamente: ")
         leia(placar1)
      fimenquanto

      escreva("Pontos marcados pela segunda equipe: ")
      leia(placar2)
      enquanto placar2 < 0 faca
         escreva("O placar nao pode ser negativo. Digite novamente: ")
         leia(placar2)
      fimenquanto

      equipes[pos1].pontosMarcados <- equipes[pos1].pontosMarcados + placar1
      equipes[pos1].pontosSofridos <- equipes[pos1].pontosSofridos + placar2
      equipes[pos2].pontosMarcados <- equipes[pos2].pontosMarcados + placar2
      equipes[pos2].pontosSofridos <- equipes[pos2].pontosSofridos + placar1

      se placar1 > placar2 entao
         equipes[pos1].vitorias <- equipes[pos1].vitorias + 1
         equipes[pos2].derrotas <- equipes[pos2].derrotas + 1
         equipes[pos1].pontos <- equipes[pos1].pontos + PONTOS_VITORIA
         equipes[pos2].pontos <- equipes[pos2].pontos + PONTOS_DERROTA
      senao
         se placar2 > placar1 entao
            equipes[pos2].vitorias <- equipes[pos2].vitorias + 1
            equipes[pos1].derrotas <- equipes[pos1].derrotas + 1
            equipes[pos2].pontos <- equipes[pos2].pontos + PONTOS_VITORIA
            equipes[pos1].pontos <- equipes[pos1].pontos + PONTOS_DERROTA
         senao
            equipes[pos1].empates <- equipes[pos1].empates + 1
            equipes[pos2].empates <- equipes[pos2].empates + 1
            equipes[pos1].pontos <- equipes[pos1].pontos + PONTOS_EMPATE
            equipes[pos2].pontos <- equipes[pos2].pontos + PONTOS_EMPATE
         fimse
      fimse

      calcularSaldo(pos1)
      calcularSaldo(pos2)

      // A matriz guarda quantas partidas cada dupla ja disputou.
      confrontos[pos1, pos2] <- confrontos[pos1, pos2] + 1
      confrontos[pos2, pos1] <- confrontos[pos2, pos1] + 1
      totalPartidas <- totalPartidas + 1
      escreval("Resultado registrado e estatisticas atualizadas!")
   fimse
fimprocedimento

// Consulta uma equipe usando a funcao de busca.
procedimento consultarEquipe()
var
   cod, indiceEquipe: inteiro
inicio
   escreva("Informe o codigo da equipe: ")
   leia(cod)
   indiceEquipe <- localizarEquipe(cod)
   se indiceEquipe = 0 entao
      escreval("Equipe nao localizada.")
   senao
      exibirEquipe(indiceEquipe)
   fimse
fimprocedimento

// Ordena o vetor por pontos, vitorias, saldo e pontos marcados.
procedimento ordenarClassificacao()
var
   i, j: inteiro
   aux: tEquipe
   auxConfronto, k: inteiro
   trocar: logico
inicio
   para i de 1 ate qtdEquipes - 1 faca
      para j de 1 ate qtdEquipes - i faca
         trocar <- falso
         se equipes[j].pontos < equipes[j+1].pontos entao
            trocar <- verdadeiro
         senao
            se equipes[j].pontos = equipes[j+1].pontos entao
               se equipes[j].vitorias < equipes[j+1].vitorias entao
                  trocar <- verdadeiro
               senao
                  se equipes[j].vitorias = equipes[j+1].vitorias entao
                     se equipes[j].saldo < equipes[j+1].saldo entao
                        trocar <- verdadeiro
                     senao
                        se equipes[j].saldo = equipes[j+1].saldo entao
                           se equipes[j].pontosMarcados < equipes[j+1].pontosMarcados entao
                              trocar <- verdadeiro
                           fimse
                        fimse
                     fimse
                  fimse
               fimse
            fimse
         fimse

         se trocar entao
            // Troca os dados das equipes campo por campo.
            aux.codigo <- equipes[j].codigo
            aux.nome <- equipes[j].nome
            aux.capitao <- equipes[j].capitao
            aux.vitorias <- equipes[j].vitorias
            aux.empates <- equipes[j].empates
            aux.derrotas <- equipes[j].derrotas
            aux.pontosMarcados <- equipes[j].pontosMarcados
            aux.pontosSofridos <- equipes[j].pontosSofridos
            aux.saldo <- equipes[j].saldo
            aux.pontos <- equipes[j].pontos

            equipes[j].codigo <- equipes[j+1].codigo
            equipes[j].nome <- equipes[j+1].nome
            equipes[j].capitao <- equipes[j+1].capitao
            equipes[j].vitorias <- equipes[j+1].vitorias
            equipes[j].empates <- equipes[j+1].empates
            equipes[j].derrotas <- equipes[j+1].derrotas
            equipes[j].pontosMarcados <- equipes[j+1].pontosMarcados
            equipes[j].pontosSofridos <- equipes[j+1].pontosSofridos
            equipes[j].saldo <- equipes[j+1].saldo
            equipes[j].pontos <- equipes[j+1].pontos

            equipes[j+1].codigo <- aux.codigo
            equipes[j+1].nome <- aux.nome
            equipes[j+1].capitao <- aux.capitao
            equipes[j+1].vitorias <- aux.vitorias
            equipes[j+1].empates <- aux.empates
            equipes[j+1].derrotas <- aux.derrotas
            equipes[j+1].pontosMarcados <- aux.pontosMarcados
            equipes[j+1].pontosSofridos <- aux.pontosSofridos
            equipes[j+1].saldo <- aux.saldo
            equipes[j+1].pontos <- aux.pontos

            // Mantem as linhas e colunas da matriz ligadas as equipes corretas.
            para k de 1 ate MAX_EQUIPES faca
               auxConfronto <- confrontos[j, k]
               confrontos[j, k] <- confrontos[j+1, k]
               confrontos[j+1, k] <- auxConfronto
            fimpara
            para k de 1 ate MAX_EQUIPES faca
               auxConfronto <- confrontos[k, j]
               confrontos[k, j] <- confrontos[k, j+1]
               confrontos[k, j+1] <- auxConfronto
            fimpara
         fimse
      fimpara
   fimpara
fimprocedimento

// Exibe a classificacao depois de ordenar as equipes.
// Exibe a classificacao geral em formato de tabela.
procedimento exibirClassificacao()
var
   i: inteiro
   nomeFormatado: caractere
inicio
   se qtdEquipes = 0 entao
      escreval("Nao ha equipes para classificar.")
   senao
// Organiza as equipes conforme os criterios de desempate.
ordenarClassificacao()

      escreval("")
      escreval("============================================================")
      escreval("                 ARENACODE CHAMPIONSHIP")
      escreval("                    CLASSIFICACAO GERAL")
      escreval("============================================================")
      escreval("POS  EQUIPE           PTS   V   E   D   PM   PS   SG")
      escreval("------------------------------------------------------------")

      para i de 1 ate qtdEquipes faca

         // Completa o nome com espacos para alinhar a tabela.
         nomeFormatado <- equipes[i].nome

         enquanto compr(nomeFormatado) < 16 faca
            nomeFormatado <- nomeFormatado + " "
         fimenquanto

escreva(i:3, "  ", nomeFormatado, " ")
escreva(equipes[i].pontos:3, " ")
escreva(equipes[i].vitorias:3, " ")
escreva(equipes[i].empates:3, " ")
escreva(equipes[i].derrotas:3, " ")
escreva(equipes[i].pontosMarcados:4, " ")
escreva(equipes[i].pontosSofridos:4, " ")
escreval(equipes[i].saldo:4)
fimpara

      escreval("============================================================")
      escreval("PTS=Pontos  V=Vitorias  E=Empates  D=Derrotas")
      escreval("PM=Pontos Marcados  PS=Pontos Sofridos  SG=Saldo")
   fimse
fimprocedimento

// Apresenta estatisticas gerais do campeonato.
procedimento exibirEstatisticas()
var
   i, totalPontosMarcados, totalVitorias, totalEmpates: inteiro
   maiorVitorias, maiorPontos, maiorSaldo, maiorMarcados: inteiro
   posVitorias, posPontos, posSaldo, posMarcados: inteiro
   media: real
inicio
   escreval("")
   escreval("ESTATISTICAS DO CAMPEONATO")
   escreval("Equipes cadastradas: ", qtdEquipes)
   escreval("Partidas realizadas: ", totalPartidas)

   totalPontosMarcados <- 0
   totalVitorias <- 0
   totalEmpates <- 0
   para i de 1 ate qtdEquipes faca
      totalPontosMarcados <- totalPontosMarcados + equipes[i].pontosMarcados
      totalVitorias <- totalVitorias + equipes[i].vitorias
      totalEmpates <- totalEmpates + equipes[i].empates
   fimpara

   escreval("Vitorias registradas: ", totalVitorias)
   escreval("Empates registrados: ", totalEmpates)
   se totalPartidas > 0 entao
      media <- totalPontosMarcados / totalPartidas
      escreval("Media de pontos marcados por partida: ", media:0:2)
   senao
      escreval("Media de pontos marcados por partida: ainda nao ha partidas.")
   fimse

   se qtdEquipes > 0 entao
      posVitorias <- 1
      posPontos <- 1
      posSaldo <- 1
      posMarcados <- 1
      maiorVitorias <- equipes[1].vitorias
      maiorPontos <- equipes[1].pontos
      maiorSaldo <- equipes[1].saldo
      maiorMarcados <- equipes[1].pontosMarcados

      para i de 2 ate qtdEquipes faca
         se equipes[i].vitorias > maiorVitorias entao
            maiorVitorias <- equipes[i].vitorias
            posVitorias <- i
         fimse
         se equipes[i].pontos > maiorPontos entao
            maiorPontos <- equipes[i].pontos
            posPontos <- i
         fimse
         se equipes[i].saldo > maiorSaldo entao
            maiorSaldo <- equipes[i].saldo
            posSaldo <- i
         fimse
         se equipes[i].pontosMarcados > maiorMarcados entao
            maiorMarcados <- equipes[i].pontosMarcados
            posMarcados <- i
         fimse
      fimpara

      escreval("Mais vitorias: ", equipes[posVitorias].nome, " (", maiorVitorias, ")")
      escreval("Maior pontuacao: ", equipes[posPontos].nome, " (", maiorPontos, " pontos)")
      escreval("Maior saldo: ", equipes[posSaldo].nome, " (", maiorSaldo, ")")
      escreval("Mais pontos marcados: ", equipes[posMarcados].nome, " (", maiorMarcados, ")")
   senao
      escreval("Cadastre equipes para ver os destaques individuais.")
   fimse
fimprocedimento

// Consulta quantas partidas duas equipes disputaram entre si.
procedimento consultarConfrontos()
var
   cod1, cod2, pos1, pos2: inteiro
inicio
   se qtdEquipes < 2 entao
      escreval("Cadastre pelo menos duas equipes.")
   senao
      escreva("Codigo da primeira equipe: ")
      leia(cod1)
      pos1 <- localizarEquipe(cod1)
      escreva("Codigo da segunda equipe: ")
      leia(cod2)
      pos2 <- localizarEquipe(cod2)

      se (pos1 = 0) ou (pos2 = 0) entao
         escreval("Uma ou ambas as equipes nao foram encontradas.")
      senao
         se pos1 = pos2 entao
            escreval("Informe duas equipes diferentes.")
         senao
            escreval(equipes[pos1].nome, " x ", equipes[pos2].nome)
            escreval("Partidas disputadas entre elas: ", confrontos[pos1, pos2])
         fimse
      fimse
   fimse
fimprocedimento

// Funcao recursiva com caso-base quando a contagem chega a zero.
procedimento contagemRegressiva(n: inteiro)
inicio
   se n <= 0 entao
      escreval("CAMPEONATO INICIADO!")
   senao
      escreval(n, "...")
      contagemRegressiva(n - 1)
   fimse
fimprocedimento

procedimento executarRecursoRecursivo()
inicio
   escreval("Contagem regressiva para o ArenaCode Championship:")
   contagemRegressiva(5)
fimprocedimento

inicio
   // Inicializacao das variaveis globais e da matriz de confrontos.
   qtdEquipes <- 0
   totalPartidas <- 0
   para i de 1 ate MAX_EQUIPES faca
      para j de 1 ate MAX_EQUIPES faca
         confrontos[i, j] <- 0
      fimpara
   fimpara

   repita
      escreval("")
      escreval("===================================")
      escreval("     ARENACODE CHAMPIONSHIP")
      escreval("===================================")
      escreval("1. Cadastrar equipe")
      escreval("2. Listar equipes")
      escreval("3. Registrar resultado de partida")
      escreval("4. Consultar equipe")
      escreval("5. Exibir classificacao geral")
      escreval("6. Exibir estatisticas do campeonato")
      escreval("7. Consultar confrontos")
      escreval("8. Executar recurso recursivo")
      escreval("9. Encerrar sistema")
      escreva("Escolha uma opcao: ")
      leia(opcao)

      escolha opcao
         caso 1
            cadastrarEquipe()
         caso 2
            listarEquipes()
         caso 3
            registrarPartida()
         caso 4
            consultarEquipe()
         caso 5
            exibirClassificacao()
         caso 6
            exibirEstatisticas()
         caso 7
            consultarConfrontos()
         caso 8
            executarRecursoRecursivo()
         caso 9
            escreval("Sistema encerrado. Obrigado por usar o ArenaCode!")
         outrocaso
            escreval("Opcao invalida. Escolha um numero de 1 a 9.")
      fimescolha
   ate opcao = 9

fimalgoritmo
