#Script R para o tratamento dos dados sensoriais relativos às provas dos vinhos
# Carregar as bibliotecas necessárias
library(readxl) 
library(ggplot2)  
library(tidyr)
library(openxlsx)

#Carregamento do ficheiro  Excel com os dados
data <- read_excel("dados_original.xlsx")

#primeiras 6 linhas do dataframe
head(data)

#nomes das variáveis
variaveis <- names(data)
print(variaveis)

#dimensão do data frame
dim(data)
#126 observações(linhas) e 50 variáveis(colunas)

#tipo das varáveis 
str(data)

#colunas com valores únicos
var_valores_unicos <- sapply(data, function(col) length(unique(col)))
print(var_valores_unicos)

#Remoção da variável "Especiarias"
data <- subset(data, select = -Especiarias)
#Eliminar as variáveis que correspondem ao grupo Defeitos 28:50
data <- subset (data, select = -c(27:49))
#Remoção da variável "Prova"
data <- subset(data, select = -Prova)


#Verificar se existem valores omissos
any(is.na(data))
#TRUE

# Número de velores omissos por variável
colSums(is.na(data))

# Percentagem de valores omissos de cada variável (coluna) 
percentagem_var_NA <- colMeans(is.na(data)) * 100
round(percentagem_var_NA, 2)

# Número de valores omissos no dataset
soma_NA <- sum(is.na(data))
cat("O número total de valores omissos nos dados é de:", round(soma_NA, 2))

# Percentagem de valores omissos no dataset
percentagem_NA <- mean(is.na(data)) * 100
cat("A percentagem de NA's nos dados é de:", round(percentagem_NA, 2), "%\n")

#Após a remoção dos valores omissos e colunas

#nomes das variáveis
variaveis <- names(data)
print(variaveis)

#dimensão do data frame
dim(data)
#126 observações(linhas) e 25 variáveis(colunas)

#tipo das variáveis
str(data)

#Guardar novo ficheiro pós alterações
#write.csv2(data, "dataset_tratado_NAS.csv", row.names = FALSE, na = '', quote = FALSE)

#Distribuição das categorias de todas as variáveis
windows()
# Transformar o dataframe para o formato longo
df_long <- gather(data, key = Variavel, value = Valor)
# Criar o gráfico de barras 
ggplot(df_long, aes(x = Valor, fill = Valor)) +
  geom_bar() +
  facet_wrap(~ Variavel, scales = "free") +
  labs(title = "Gráfico de barras para cada variável",
       x = "Categorias",
       y = "Contagem") +
  theme_minimal()


#Distribuição das categorias de tendo em conta a variável "Vinho"
# Filtrar o dataframe para as observações com "Vinho" igual a 'A'
dados_Vinho <- data[data$Vinho == 'A', ]

# Transformar o dataframe no formato longo
dados_longos <- gather(dados_Vinho,  key = Variavel, value = Valor)

windows()
# Traçar gráficos de barras

ggplot(dados_longos, aes(x = Valor, fill = Valor)) +
  geom_bar() +
  facet_wrap(~ Variavel, scales = "free") +
  labs(title = 'Características predominantes nas provas para o Vinho "A"',
       x = "Categorias",
       y = "Contagem") +
  theme_minimal()

# Filtrar o dataframe para as observações com "Vinho" igual a 'B'
dados_Vinho_B <- data[data$Vinho == 'B', ]

# Transformar o dataframe no formato longo 
dados_longos_B <- gather(dados_Vinho_B,  key = Variavel, value = Valor)

windows()
# Traçar gráficos de barras

ggplot(dados_longos_B, aes(x = Valor, fill = Valor)) +
  geom_bar() +
  facet_wrap(~ Variavel, scales = "free") +
  labs(title = 'Características predominantes nas provas para o Vinho "B"',
       x = "Categorias",
       y = "Contagem") +
  theme_minimal()

# Filtrar o dataframe para as observações com "Vinho" igual a 'C'
dados_Vinho_C <- data[data$Vinho == 'C', ]

# Transformar o dataframe no formato longo 
dados_longos_C <- gather(dados_Vinho_C,  key = Variavel, value = Valor)

windows()
# Traçar gráficos de barras

ggplot(dados_longos_C, aes(x = Valor, fill = Valor)) +
  geom_bar() +
  facet_wrap(~ Variavel, scales = "free") +
  labs(title = 'Características predominantes nas provas para o Vinho "C"',
       x = "Categorias",
       y = "Contagem") +
  theme_minimal()

# Filtrar o dataframe para as observações com "Vinho" igual a 'D'
dados_Vinho_D <- data[data$Vinho == 'D', ]

# Transformar o dataframe no formato longo 
dados_longos_D <- gather(dados_Vinho_D,  key = Variavel, value = Valor)

windows()
# Traçar gráficos de barras

ggplot(dados_longos_D, aes(x = Valor, fill = Valor)) +
  geom_bar() +
  facet_wrap(~ Variavel, scales = "free") +
  labs(title = 'Características predominantes nas provas para o Vinho "D"',
       x = "Categorias",
       y = "Contagem") +
  theme_minimal()

# Filtrar o dataframe para as observações com "Vinho" igual a 'E'
dados_Vinho_E <- data[data$Vinho == 'E', ]

# Transformar o dataframe no formato longo
dados_longos_E <- gather(dados_Vinho_E,  key = Variavel, value = Valor)

windows()
# Traçar gráficos de barras

ggplot(dados_longos_E, aes(x = Valor, fill = Valor)) +
  geom_bar() +
  facet_wrap(~ Variavel, scales = "free") +
  labs(title = 'Características predominantes nas provas para o Vinho "E"',
       x = "Categorias",
       y = "Contagem") +
  theme_minimal()

# Filtrar o dataframe para as observações com "Vinho" igual a 'F'
dados_Vinho_F <- data[data$Vinho == 'F', ]

# Transformar o dataframe no formato longo 
dados_longos_F <- gather(dados_Vinho_F,  key = Variavel, value = Valor)

windows()
# Traçar gráficos de barras

ggplot(dados_longos_F, aes(x = Valor, fill = Valor)) +
  geom_bar() +
  facet_wrap(~ Variavel, scales = "free") +
  labs(title = 'Características predominantes nas provas para o Vinho "F"',
       x = "Categorias",
       y = "Contagem") +
  theme_minimal()

# Filtrar o dataframe para as observações com "Vinho" igual a 'G'
dados_Vinho_G <- data[data$Vinho == 'G', ]

# Transformar o dataframe no formato longo 
dados_longos_G <- gather(dados_Vinho_G,  key = Variavel, value = Valor)

windows()
# Traçar gráficos de barras

ggplot(dados_longos_G, aes(x = Valor, fill = Valor)) +
  geom_bar() +
  facet_wrap(~ Variavel, scales = "free") +
  labs(title = 'Características predominantes nas provas para o Vinho "G"',
       x = "Categorias",
       y = "Contagem") +
  theme_minimal()

