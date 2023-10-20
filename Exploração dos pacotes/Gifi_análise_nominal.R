#Aplicação da análise ACPCat através da função princals() do pacote Gifi para o dataset de exemplo "mammals", considerando todas as variáveis como nominais

#librarias necessárias
library(Gifi)

#Dataset exemplo
data("mammals")
mammals
##Contagem do número de observações do dataset (n) -> 66 linhas
nrow(mammals)
##Contagem do número de variáveis do dataset (m) -> 8 colunas
ncol(mammals)

#ACPCAT para o dataset mammals, que segue transformação nominal, foram considerdos 5 componentes após análise do gráfico Scree plot
#O número de copias iguala o numero de componentes para "aliviar" as restrições lineares sobre as variáveis
acpcat_nm <- princals(mammals, levels = "nominal", ndim = 5,  copies = c(rep(5, ncol(mammals))))

#resultados gerais obtidos
acpcat_nm
# 18 iterações para convergir, autovalor de 5.861 para 1ª dimensão, 3.04 para a 2ª dimensão, 2.201 para a 3ª dimensão, 1.751 para a 4ª dimensão e de 1.407 para a 5ª dimensão, valor da função de perda de 0.644
#sumário de resultados gerais obtidos
summary(acpcat_nm)
#VAF total de 75,05%

##Scree plot com princals.plot() 
## Print numa janela à parte
windows()
plot(acpcat_nm, plot.type = "screeplot", xlab = "Componentes", ylab = "Valores próprios", main = "")
#Consideradas as 5 primeiras dimensões

## Print numa janela à parte
windows()
## Transplot - Gráfico que permite comparar os valores observados com os valores transformados na 1ªa dimesão de cada variável
plot(acpcat_nm, plot.type = "transplot", plot.dim = c(1,2), var.subset = "all", lwd = 1, xlab = "Categorias", ylab = "Quantificações")

## Permite extraír os component loadings 
acpcat_nm$loadings 
## Print numa janela à parte
windows()
## Gráfico jointplot - não é possivel obter um gráfico de loadings uma vez que todas as variáveis são categoricas
plot(acpcat_nm, plot.type = "jointplot", var.subset = "all", xlab = "Componente 1", ylab = "Componente 2", main = "")

## Score de cada objeto (linha) na 1ª e 2ª dimensão
round(acpcat_nm$objectscores, 3)

## Print numa janela à parte
windows()
## Gráfico que representa os scores dos objetos nas 2 dimensões
plot(acpcat_nm, plot.type = "objplot", var.subset = "all",  xlab = "Componente 1", ylab = "Componente 2", main = "")


## Quantificações das categorias
acpcat_nm$quantifications
## Na ACPCAT as quantificações na 2ª dimensão são linearmente dependentes da 1ª dimensão

## Matriz de scores, os valores aqui presentes correspondem ao valor da quantificação da sua respetiva categoria
acpcat_nm$scoremat 

## Valores próprios de cada variável
acpcat_nm$evals

## scores transformados de forma ótima
acpcat_nm$transform

## matriz de correlação induzida
acpcat_nm$rhat

## matriz de discriminação 
acpcat_nm$dmeasures

## matriz de discriminação média (average) - entre todas as variáveis 
acpcat_nm$lambda

## peso dos componentes
acpcat_nm$weights

## nº de iterações - foi definido por nós, só serve para ver
acpcat_nm$ntel

## Valor da função de perda 
acpcat_nm$f

## Dataframe original
acpcat_nm$data

## Dataframe númérico - onde as varíaveis são tratadas como números
acpcat_nm$datanum

## Número de dimensões extraídas
acpcat_nm$ndim

## Função que foi dada para correr a catpca
acpcat_nm$call

