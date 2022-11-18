

## Manual do Cientista Jr ##


# Amostragem --------------------------------------------------------------

## Sortear um numero 
# vamos comecar a partir do numero sorteado. Vamos amostrar 20 filmes a partir do sorteado. Se for um numero par, iremos amostrar apenas os filmes na posicao par e ser for um numero impar, iremos amostrar apenas os filmes na posicao impar. 

numeros<-c(1:9)
numeros
sample(numeros,size=1, replace=F)
#[1] 6

# seráo amostrados 20 filmes de comedia e 20 filmes de acao

# Pergunta,  hipotese e predicao ------------------------------------------

## Pergunta
# O genero do filme na Netflix afeta relevancia dos filmes?

## Hipotese
# Filmes do genero de comedia apresentam maior relevancia na netflix. 

# vamos operacionalizar a relevancia para % de curtidas
# Vamos operacionalizar gênero do filme para açao e comédia
# a relevancia eh medida em relacao ao numero de curtidas que um filme tem, quanto mais curtidas maior a relevancia. 

## Predicao
# Porcentagem (%) de curtida dos filmes de comedia sao maiores do que filmes de acao

## Faça com outras métricas para voce treinar

# Conceitos de linguagem do R ---------------------------------------------

# TALVEZ A COISA MAIS IMPORTANTE. Toda vez que usamos o simbolo (#) o R entende como uma linha de comando nao analisavel. Isso faz com que esse caractere seja o mais importante do programa, pois nos permite criar comentarios que servem de roteiro para todas as vezes que precisarmos usar esses scripts.

# A linguagem R tambem eh chamada de programação “orientada ao objeto” (object oriented programming), o que significa que utilizar o R envolve basicamente a criacao e manipulacao de objetos em um terminal, em que o usuario tem de dizer exatamente o que deseja que o programa execute, ao inves de simplesmente clicar em botoes.

# O R aceita dois tipos basicos de entrada: letras e caracteres (formam os nomes dos objetos, funcoes e argumentos) e valores (usados para alterar os argumentos ou como dados a serem analisados)

# Como a linguagem do R eh ambiente de programacao, o uso de acentos podem nao ser compreendido e causar erros. Melhor nao usar.

# O R faz distincao entre maiusculas e minusculas.

# O R permite a entrada e criacao de bancos de dados diversos, como matrizes (so dados numericos) e data.frames (dados numericos e categoricos).

# Ao usar ####  depois de um comentario cria-se uma sessao dentro do script. Pode ser usado para dividir seu script em topicos (hipoteses, modelos, analises, graficos, etc)

## Funcoes

sqrt(25)

# PRIMEIRO GRANDE CONCEITO DE PROGRAMACAO DO R

# Funcoes sao codigos preparados para realizar uma tarefa especifica de modo simples (codigos que realizam operacoes em argumentos).

# nome_da_funcao(argumento1, argumento2, …)

# 1. Nome da funcao: remete ao que ela faz
# 2. Parenteses: limitam a funcao
# 3. Argumentos: valores, parametros ou expressoes onde a funcao atuara
# 4. Virgulas: separam os argumentos

dados <- read.table("grafico regressão.txt", h = T, nrows = 10)

## Argumentos

# SEGUNDO GRANDE CONCEITO DE PROGRAMACAO DO R

# Valores ou objetos: a funcao alterara os valores em si ou os valores atribuidos aos objetos
# Parametros: valores fixos que informam um metodo ou a realizacao de uma operacao. Informa-se o nome desse argumento, seguido de “=” e um numero, texto ou as opcoes de TRUE ou FALSE.

dados <- read.table("grafico regressão.txt", h = T, nrows = 10)

## Objetos

# TERCEIRO GRANDE CONCEITO DE PROGRAMACAO DO R

# O R eh uma programacao orientada por objetos. O que isso significa?
# Tudo que vamos fazer no R funcionara com algo que ele identifica como um objeto.
# Objetos sao palavras as quais sao atribuidos dados. A atribuicao possibilita a manipulacao de dados ou armazenamento dos resultados de analises.
# O objeto pode ter qualquer nome.
# Basta digitar o nome desejado, seguido de um sinal de atribuicao (<-) ou =;

dados <- read.table("grafico regressão.txt", h = T, nrows = 10)

## Pacotes

# QUARTO GRANDE GRUPO DE PROGRAMACAO DO R

# Pacotes são conjuntos extras de funções para executar tarefas específicas, além dos pacotes instalados no R Base. 
# Existe literalmente milhares de pacotes (~19,000) para as mais diversas tarefas: estatística, ecologia, geografia, sensoriamento remoto, econometria, ciências sociais, gráficos, machine learning, etc.
# No R, quando tratamos de pacotes, devemos destacar a diferenca de dois conceitos: instalar um pacote e carregar um pacote.
# A instalacao de pacotes possui algumas caracteristicas:
# Instala-se um pacote apenas uma vez
# Precisamos estar conectados a internet
# O nome do pacote precisa estar entre aspas na funcao de instalacao

install.packages("ggplot2")

# O carregamento de pacotes possui algumas caracteristicas:
# Carrega-se o pacote toda vez que se abre uma nova sessao do R
# Nao precisamos estar conectados a internet
# O nome do pacote nao precisa estar entre aspas na funcao de carregamento

# Funcoes:

library(ggplot2)
require(ggplot2)

## Agora vamos meter a mao na massa e analisar os dados do projeto que desenvolvemos ao longo da nossa oficina

# Instalando os pacotes que vamos usar ----------------------------

pkgs <- c("ggplot2", 
          "xlsx",
          "ggthemes")

install.packages(pkgs)

library(ggplot2) # grafico
library(ggthemes) # temas extras do ggplot2
library(xlsx) # importar a planilha em xlsx

# Importando os nossos dados ----------------------------------------------------------
setwd("~/Library/CloudStorage/OneDrive-Pessoal/Análises R/ASR oficina ")

dir()
dados <- read.xlsx(
  "netflix.xlsx",
  sheetIndex = 1,
  as.data.frame = T,
  h = T
)
dados
attach(dados)
summary(dados)

# Anlisando os nosso dados ------------------------------------------------

## criando o nosso modelo
names(dados)
mod1 <- glm(curtidas ~ genero,
            family = binomial, 
            data = dados)

## diagnose dos residuos 

par(mfrow = c(2, 2))
plot(mod1)
par(mfrow = c(1, 1))

summary(mod1)
1.4081/38

## ajustando o modelo
mod2 <- glm(curtidas ~ genero,
            family = quasibinomial, 
            data = dados)

summary(mod2)
1.4081/38

## teste do modelo
anova(mod2, test = "F")

## grafico padrao
boxplot(curtidas~genero)

# Trabalhando no grafico ------------------------------------

## grafico padrao
ggplot(dados, aes(x= genero, y = curtidas)) +
  geom_boxplot()

ggplot(dados, aes(x= genero, y = curtidas)) +
  geom_violin()

ggplot(dados, aes(x= genero, y = curtidas)) +
  geom_point()

ggplot(dados, aes(x= genero, y = curtidas)) +
  geom_violin() +
  geom_boxplot() +
  geom_point()

## camada por camada
ggplot(dados, aes(x= genero, y = curtidas, fill = genero)) +
  geom_boxplot(width = .3,
               alpha = .6)


ggplot(dados, aes(x= genero, y = curtidas, fill = genero)) +
  geom_violin(trim = F, 
              alpha = .4)

ggplot(dados, aes(x= genero, y = curtidas, fill = genero)) +
  geom_point(aes(color = genero),
             shape = 16, 
             position = position_jitter(0.1),
             cex = 4, 
             alpha = .8)

ggplot(dados, aes(x= genero, y = curtidas, fill = genero)) +
  geom_boxplot(width = .3,
               alpha = .6) +
  geom_violin(trim = F, 
              alpha = .4) +
  geom_point(aes(color = genero),
             shape = 16, 
             position = position_jitter(0.1),
             cex = 4, 
             alpha = .8)

 # Grafico para publicacao -------------------------------------------------

ggplot(dados, aes(x= genero, y = curtidas, fill = genero)) +
  geom_boxplot(width = .3,
               alpha = .6) +
  geom_violin(trim = F, 
              alpha = .4,
              ) +
  geom_point(aes(color = genero),
              shape = 16, 
              position = position_jitter(0.1),
              cex = 4, 
              alpha = .8) +
  scale_colour_manual(values = c("darkorange", "cyan4")) +
  scale_fill_manual(values = c("darkorange", "cyan4")) +
  scale_y_continuous(breaks = seq(from = 0.4, 
                                  to = 1, 
                                  by = .1),
                     limits = c(0.4, 1)) +
  scale_x_discrete(labels = c("Ação e Aventura",
                              "Comédia")) +
  theme_test(base_size = 14) +
  labs(x = "Gênero dos filmes", 
       y = "Relevância (% de curtidas)") + 
  theme_test(base_size = 14) +
  theme(legend.position = "none")

## salvando a figura 
ggsave("fig1.png", width = 7, height = 5, dpi = 300)



