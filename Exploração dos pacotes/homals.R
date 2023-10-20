#Aplicação da análise ACPCat através da função homals() do pacote Homals para o dataset de exemplo "mammals", considerando todas as variáveis como ordinais

#librarias necessárias
library(homals)
#dados 
data("mammals")


#Consideramdo todas as variáveis como ordinais e estabelecendo rank = 1, que permite aplicar a ACPCat, mantendo o resto dos argumentos default
hm <- homals(mammals, ndim = 2, rank = 1, level = "ordinal")

#resultados gerais obtidos
hm
#sumário de resultados gerais obtidos
summary(hm)
# 11 iterações para convergir, autovalor de 0.0341 para 1ª dimensão e 0.0180 para a 2ª dimensão, valor da função de perda de 0.001104055
#Para cada variável permite ver os valores dos loadings, centroídes e quantificações das categorias e qunatificações low-rank

# Nome do data frame
hm$data
# Lista dos scores das categorias para cada variável
hm$catscores
# Matriz que contem os dados reproduzidos baseados nos scores das categorias
hm$scoremat
# Matriz com os object scores em cada dimensão
hm$objscores
# Lista dos centróides das categorias
hm$cat.centroids
# Matriz de indicadores codificada em dummy
hm$ind.mat
# Lista das cargas das variáveis em cada dimensão
hm$loadings
# Lista de quantificações de rank inferior
hm$low.rank
# Matriz com valores de discriminação para cada variável em cada dimensão
hm$discrim
# Número de iterações
hm$niter
# Valores próprios finais
hm$eigenvalues
# Valor da função de perda
hm$loss
# Vetor com o rank de cada variável
hm$rank.vec
# Vetor com as variáveis ativas/inativas
hm$active

#Gráficos descritos na parte escrita da dissertação:

## Print numa janela à parte
windows()
# Load plot 
plot(hm, plot.type = "loadplot", main = "", xlab = "Componente 1", ylab = "Componente 2")
## Print numa janela à parte
windows()
# Joint plot 
plot(hm, plot.type = "jointplot", main = "", xlab = "Componente 1", ylab = "Componente 2", leg.pos = "bottomleft")
abline(h = 0, v = 0, lty = 2, col = "gray")
## Print numa janela à parte
windows()
# Object plot 
plot(hm, plot.type = "objplot", main = "", xlab = "Componente 1", ylab = "Componente 2")
abline(h = 0, v = 0, lty = 2, col = "gray")
## Print numa janela à parte
windows()
## Category plot - Traça as quantificações das categorias para cada variável separadamente
plot(hm, plot.type = "catplot", main = "", xlab = "Componente 1", ylab = "Componente 2")
## Print numa janela à parte
windows()
# Transformation plot 
plot(hm, plot.type = "trfplot", xlab = "Categorias", ylab = "Quantificações")
## Print numa janela à parte
windows()
# Scree plot - só dá as dimensões escolhidas
plot(hm, plot.type = "screeplot", main = "", xlab = "Componentes", ylab = "Valores próprios")
## Print numa janela à parte
windows()
# Matriz de discriminação - Traça as medidas de descriminação para cada variável 
plot(hm, plot.type = "dmplot", main = "", xlab = "Componente 1", ylab = "Componente 2")


#Gráficos não especificos para a ACPCat

## Print numa janela à parte
windows()
# Graph plot 
plot(hm, plot.type = "graphplot", xlab = "Componente 1", ylab = "Componente 2")
abline(h = 0, v = 0, lty = 2, col = "gray")
## Print numa janela à parte
windows()
#Voronoi plot
plot(hm, plot.type = "vorplot")
## Print numa janela à parte
windows()
# Hull plot 
plot(hm, plot.type = "hullplot")
## Print numa janela à parte
windows()
# Lab plot 
plot(hm, plot.type = "labplot")
## Print numa janela à parte
windows()
# Span plot
plot(hm, plot.type = "spanplot")
## Print numa janela à parte
windows()
# Star plot 
plot(hm, plot.type = "starplot")
## Print numa janela à parte
windows()
# Loss plot 
plot(hm, plot.type = "lossplot")
## Print numa janela à parte
windows()
#Projection plot
plot(hm, plot.type = "prjplot")
## Print numa janela à parte
windows()
#Vector plot
plot(hm, plot.type = "vecplot")


