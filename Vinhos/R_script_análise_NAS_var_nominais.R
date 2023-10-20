#Aplicação da análise ACPCat através da função princals() do pacote Gifi para os dados sensoriais recolhidos nas provas de vinhos previamente tratados, 
#considerando as variáveis com categorias empatadas como nominais

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
a_nominal <- princals(csv, ndim = 9, levels = c("nominal", "nominal", "nominal", "nominal", "nominal", "ordinal", "ordinal", "nominal", "nominal", "nominal", rep("ordinal",4), "nominal", "ordinal", "nominal", "ordinal", "nominal", "nominal", "nominal", "nominal", "nominal", "nominal", "nominal"), ties = "s", degrees = 1, 
                                      copies = c(9, 9, 9, 9, 9, 1, 1, 9, 9, 9, 1, 1, 1, 1, 9, 1, 9, 1, 9, 9, 9, 9, 9, 9, 9), missing = "a", normobj.z = TRUE, active = TRUE, itmax = 1000, eps = 1e-06, verbose = FALSE )

#resultados gerais obtidos
a_nominal
#sumário de resultados gerais obtidos
summary(a_nominal, cutoff = 0.5)

#Gráficos obtidos:

##Print numa janela à parte
windows()
##Scree plot com princals.plot()  
plot(a_nominal, plot.type = "screeplot", xlab = "Componentes", ylab = "Valores próprios", main = "")


##Transplot - Gráfico que permite comparar os valores observados com os valores transformados na 1ªa dimesão de cada variável
#Os gráfico apresentam-se separados por uma questão de organização do documento escrito
#Gráfico para as Variáveis Vinho e Provador
windows()
plot(a_nominal, plot.type = "transplot", plot.dim = c(1,2), var.subset = c("Vinho", "Provador"), xlab = "Categorias", ylab = "Quantificações")
#Gráfico para as variáveis que apresentam as mesmas  quantificações de diferentes categorias
windows()
plot(a_nominal, plot.type = "transplot", plot.dim = c(1,2), var.subset = c("Fruto_citrino", "Fruto_arvore", "Fruto_tropical", "Vegetal_fresco", "Vegetal_seco", "Melado", "Calor", "Adstrigencia", "Equilibrio", "Persistencia", "Qualidade_cor"), xlab = "Categorias", ylab = "Quantificações")
#Gráfico para as restantes variáveis que será disponibilizado em Apêndice
windows()
plot(a_nominal, plot.type = "transplot", plot.dim = c(1,2), var.subset = c("Fruto_seco", "Floral", "Mineral", "Gas_carbonico", "Docura", "Acidez", "Amargor", "Estrutura", "Limpidez", "Cor", "Intensidade", "Evolucao"), xlab = "Categorias", ylab = "Quantificações")
