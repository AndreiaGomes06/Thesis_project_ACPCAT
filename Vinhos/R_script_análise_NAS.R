#Aplicação da análise ACPCat através da função princals() do pacote Gifi para os dados sensoriais recolhidos nas provas de vinhos previamente tratados

#librarias necessárias
library(Gifi)

csv <- read.csv("dataset_tratado_NAS.csv", header = TRUE, sep = ';', na.strings = c(""), stringsAsFactors = TRUE)

#verificação do tipo das variáves após transformação em fatores 
str(csv)

#verificação da dimensão do dataset
dim(data)
#126 observações(linhas) e 25 variáveis(colunas)

#Definir os argumentos da função
#7 Componentes principais - definidos com auxílio do Scree Plot
#número de cópias igual ao número de componentes para as variáveis nominais, para "aliviar" as restrições lineares sobre as variáveis
a <- princals(csv, ndim = 7, levels = c(rep("nominal", 2), rep("ordinal", 18), rep("nominal", 3), "ordinal", "nominal"), ties = "s", degrees = 1, copies = c(7, 7, rep(1,18), rep(7,3), 1, 7), missing = "a", normobj.z = TRUE, active = TRUE,
                       itmax = 1000, eps = 1e-06, verbose = FALSE )

#resultados gerais obtidos
a
#sumário de resultados gerais obtidos
summary(a, cutoff = 0.5)

#Gráficos obtidos:

##Print numa janela à parte
windows()
##Scree plot com princals.plot()  
plot(a, plot.type = "screeplot", xlab = "Componentes", ylab = "Valores próprios", main = "")
#Consideradas as 7 primeiras dimensões

##Transplot - Gráfico que permite comparar os valores observados com os valores transformados na 1ªa dimesão de cada variável
#Os gráfico apresentam-se separados por uma questão de organização do documento escrito
#Gráfico para as Variáveis Vinho e Provador
windows()
plot(a, plot.type = "transplot", plot.dim = c(1,2), var.subset = c("Vinho", "Provador"), xlab = "Categorias", ylab = "Quantificações")
#Gráfico para as variáveis que apresentam as mesmas  quantificações de diferentes categorias
windows()
plot(a, plot.type = "transplot", plot.dim = c(1,2), var.subset = c("Fruto_citrino", "Fruto_arvore", "Fruto_tropical", "Fruto_seco", "Vegetal_fresco", "Melado", "Calor", "Adstrigencia", "Equilibrio", "Persistencia", "Qualidade_cor"), xlab = "Categorias", ylab = "Quantificações")
#Gráfico para as restantes variáveis que será disponibilizado em Apêndice
windows()
plot(a, plot.type = "transplot", plot.dim = c(1,2), var.subset = c("Floral", "Vegetal_seco", "Mineral", "Gas_carbonico", "Docura", "Acidez", "Amargor", "Estrutura", "Limpidez", "Cor", "Intensidade", "Evolucao"), xlab = "Categorias", ylab = "Quantificações")

## Gráfico Jointplot para as 2 primeiras componentes, argumento "expand" utilizado para reduzir o tamanho dos loadings e ser representado com as quantificações das categorias
windows()
plot(a, plot.type = "jointplot",  var.subset = "all", xlab = "Componente 1", ylab = "Componente 2", expand = 0.15, main = "", xlim = c(-0.15, 0.20), ylim = c(-0.15, 0.15))

## Gráfico dos loadings para as 2 primeiras componentes
windows()
plot(a,  var.subset = "all", xlab = "Componente 1", ylab = "Componente 2", main = "")

## Gráfico que representa os scores dos objetos para as 2 primeiras componentes
windows()
plot(a, plot.type = "objplot",var.subset = "all",  xlab = "Componente 1", ylab = "Componente 2", main = "")
#linhas que representam os eixos na origem
abline(h = 0, v = 0, lty = 2, col = "gray")
#adiciona circulos em volta dos grupos formados
draw.circle(-0.5, -1.54, 0.667, border = "darkgrey")
draw.circle(2.1, 0, 0.85, border = "darkgrey")
draw.circle(-0.15, 0.75, 1.4, border = "darkgrey")

## Gráfico do biplot para as 2 primeiras componentes, que sobrepõe o gráfico object e biplot
windows()
plot(a, plot.type = "biplot", var.subset = "all", xlab = "Componente 1", ylab = "Componente 2", main = "", col.scores="darkgrey")
#linhas que representam os eixos na origem
abline(h = 0, v = 0, lty = 2, col = "gray")


#Valores obtidos nos resultados para a função princals():

## Permite extraír os component loadings 
round(a$loadings, 3)

## Quantificações das categorias
a$quantifications
## Na ACPCAT as quantificações na 2ª dimensão são linearmente dependentes da 1ª dimensão

## Matriz de scores, os valores aqui presentes correspondem ao valor da quantificação da sua respetiva categoria
a$scoremat 

## Valores próprios de cada componente
a$evals

## scores transformados de forma ótima
a$transform

## matriz de correlação induzida
a$rhat

## matriz de discriminação 
a$dmeasures

## matriz de discriminação média (average) - entre todas as variáveis 
a$lambda

## peso dos componentes
a$weights

## nº de iterações - previamente definfido
a$ntel

## Valor da função de perda 
a$f

## Dataframe original
a$data

## Dataframe númérico - onde as varíaveis são tratadas como números
a$datanum

## Número de dimensões extraídas
a$ndim

## Função que foi dada para correr a catpca
a$call

