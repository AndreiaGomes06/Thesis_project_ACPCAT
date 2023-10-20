#Aplicação da análise ACPCat através da função princals() do pacote Gifi para o dataset de exemplo "mammals", considerando todas as variáveis como ordinais

#librarias necessárias
library(Gifi)
library("plotrix") 

#Dataset exemplo
data("mammals")
mammals
##Contagem do número de observações do dataset (n) -> 66 linhas
nrow(mammals)
##Contagem do número de variáveis do dataset (m) -> 8 colunas
ncol(mammals)

#ACPCAT para o dataset mammals, que segue transformação ordinal, argumentos default
acpcatmm <- princals(mammals, ndim = 2, levels = "ordinal", ties = "s", degrees = 1, copies = 1, missing = "s", normobj.z = TRUE, active = TRUE,
                     itmax = 1000, eps = 1e-06, verbose = FALSE )

#resultados gerais obtidos
acpcatmm
# 40 iterações para convergir, autovalor de 5.611 para 1ª dimensão e 1.143 para a 2ª dimensão, valor da função de perda de 0.578
#sumário de resultados gerais obtidos
summary(acpcatmm)
#VAF total de 84,43%

## Print numa janela à parte
windows()
##Scree plot com princals.plot() 
plot(acpcatmm, plot.type = "screeplot", xlab = "Componentes", ylab = "Valores próprios", main ="")
#Consideradas as 2 primeiras dimensões

## Print numa janela à parte
windows()
## Transplot - Gráfico que permite comparar os valores observados com os valores transformados na 1ªa dimesão de cada variável
plot(acpcatmm, plot.type = "transplot", plot.dim = c(1,2), var.subset = "all", lwd = 1, xlab = "Categorias", ylab = "Quantificações")
#Todas funções apresentam a forma de uma escada crescente, a ordinalidade da escala original (no eixo x) é matida nas transformações (no eixo y)

## Permite extraír os component loadings 
acpcatmm$loadings 

## Print numa janela à parte
windows()
## Gráfico dos loadings 
plot(acpcatmm, plot.dim = c(1, 2), var.subset = "all", xlab = "Componente 1", ylab = "Componente 2", main = "")

## Score de cada objeto (linha) na 1ª e 2ª dimensão
round(acpcatmm$objectscores, 3)

## Print numa janela à parte
windows()
## Gráfico que representa os scores dos objetos nas 2 dimensões
plot(acpcatmm, plot.type = "objplot", var.subset = "all",  xlab = "Componente 1", ylab = "Componente 2", main = "")
#linhas que representam os eixos na origem
abline(h = 0, v = 0, lty = 2, col = "gray")
#adiciona circulos em volta dos grupos formados
draw.circle(-1.3, -0.6, 0.55, border = "darkgrey")
draw.circle(0.78, -0.86, 0.715, border = "darkgrey")
draw.circle(-0.02, 0.80, 1.095, border = "darkgrey")

## Print numa janela à parte
windows()
## Gráfico biplot permite ter os scores e os loadings no mesmo gráfico, de forma a relacionar os mesmos
plot(acpcatmm, plot.type = "biplot", var.subset = "all", xlab = "Componente 1", ylab = "Componente 2", main = "", expand = 0.7, cex.scores = 0.6, col.scores = "gray")
#linhas que representam os eixos na origem
abline(h = 0, v = 0, lty = 2, col = "gray")

## Quantificações das categorias
acpcatmm$quantifications
## Na ACPCAT as quantificações na 2ª dimensão são linearmente dependentes da 1ª dimensão

## Matriz de scores, os valores aqui presentes correspondem ao valor da quantificação da sua respetiva categoria
acpcatmm$scoremat 

## Valores próprios de cada variável
acpcatmm$evals

## scores transformados de forma ótima
acpcatmm$transform

## matriz de correlação induzida
acpcatmm$rhat

## matriz de discriminação 
acpcatmm$dmeasures

## matriz de discriminação média (average) - entre todas as variáveis 
acpcatmm$lambda

## peso dos componentes
acpcatmm$weights

## nº de iterações - foi definido por nós, só serve para ver
acpcatmm$ntel

## Valor da função de perda 
acpcatmm$f

## Dataframe original
acpcatmm$data

## Dataframe númérico - onde as varíaveis são tratadas como números
acpcatmm$datanum

## Número de dimensões extraídas
acpcatmm$ndim

## Função que foi dada para correr a catpca
acpcatmm$call




