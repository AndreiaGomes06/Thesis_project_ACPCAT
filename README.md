![Simbolo Escola de Engenharia](https://www.eng.uminho.pt/SiteAssets/Logo.PNG)
# Dissertação

## Contexto
Este repositório GitHub foi criado no ambito do desenvolvimento da dissertação de mestrado intitulada "Análise de Componentes Principais para variáveis qualitativas: Exploração em R", aqui está disponivel o código utilizado no decorrer do desenvolvimento deste trabalho. O principal objetivo desta dissertação passa por  passa por uma análise exploratória do *software* R em busca de ferramentas disponíveis para trabalhar com a análise de componentes princcipais categórica (ACPCAT) permitindo assim reduzir o número de *m* variáveis para um menor número de *p* variáveis não correlacionadas chamadas componentes principais, sendo estas componentes responsáveis pela maior variabilidade nos dados.

## Resumo
A análise de grandes conjuntos de dados categóricos é um problema recorrente nas ciências sociais, comportamentais e biológicas. Surge por isso a necessidade de diminuir estes dados conseguindo, contudo, que as perdas de informação sejam mínimas. 

Tendo por base este problema, emergiu o tema desta dissertação, cujo objetivo passa pela análise exploratória do *software* R em busca de ferramentas disponíveis para trabalhar com a análise de componentes principais categórica (ACPCAT), que surge como alternativa à tradicional análise de componentes principais (ACP), e permite reduzir a dimensionalidade de variáveis medidas em escalas diferentes. Esta quantifica as variáveis categóricas utilizando o *optimal scaling*, atribuindo quantificações numéricas às categorias de cada uma das variáveis qualitativas.

De forma a compreender os princípios fundamentais deste método estatístico foi feita uma busca extensiva de fontes bibliográficas, que permitiu, adicionalmente, destacar o pacote *Gifi* e pacote *Homals* como sendo os únicos que possuem funções (*princals()* e *homals()*, respetivamente) que permitem aplicar a ACPCAT. Ambas as funções foram exploradas utilizando o mesmo *dataset* de exemplo, sendo feita uma descrição detalhada dos seus argumentos e dos valores e gráficos obtidos nos resultados como forma de comparação das funcionalidades e recursos que as duas disponibilizam.

O pacote *Gifi* descende do pacote *Homals* como sendo uma versão melhorada, mais fácil de manipular por parte do utilizador e mais flexível devido a uma subtil diferença na formulação da função de perda e ao facto desta utilizar *B-spline*.

Para aprofundar os conhecimentos sobre as funcionalidades e limitações desta função e para estabelecer de que forma dados biológicos podem ser trabalhados foi também executada a análise de um conjunto de dados sensoriais recolhidos de provas de vinhos.

Com o intuito de permitir ao utilizador executar uma ACPCAT de forma simplificada e intuitiva foi criada uma aplicação *web*, que está disponível no endereço <https://andreiagomes.shinyapps.io/Gify/> e pode ser acessada livremente de qualquer dispositivo desde que este tenha acesso à *internet*. A aplicação, de nome *Gify*, tem por base a função *princals()* do pacote *Gifi* e permite ao utilizador, mesmo que este não tenha nenhum tipo de conhecimento sobre o *software* R, carregar o seu conjunto de dados, definir os seus parâmetros de análise, executar a ACPCAT e consultar os resultados, sendo tudo isto processado recorrendo a botões de seleção e espaços de preenchimento.

***Palavras-chave:*** Variáveis categóricas, ACP, ACPCAT, R, *shiny*

## Descrição das pastas

### [Datasets](Datasets)
Nesta pasta estão presentes todos os conjuntos de dados utilizados nas diferentes etapas deste trabalho: BaseDados_organizada, BaseDados_Prova_descritiva, Dados_original, dataset_tratado_NAS, mamiferos e o ficheiro PDF com informações sobre a interpretação das provas de vinhos. 

### [Exploração dos pacotes](Exploração dos pacotes)
Nesta pasta estão os ficheiros R referentes à exploração dos pacotes disponíveis no *sotfware* R: Gifi_análise_nominal, Gifi_análise_ordinal e homals.

### [Vinhos](Vinhos)
Nesta pasta estão presentes os ficheiros R relacionados com o tratamento e exploraçãodos dados sensoriais das provas dos vinhos de forma a profundar o conhecimento sobre as potencialidades da função *princals()* do pacote *Gifi* para a implementação da ACPCAT:  R_script_tratamento_NAS, R_script_análise_NAS e R_script_análise_NAS_var_nominais.

### [App](App)
Por fim, o ficheiro App contém o código que permitiu implementar a aplicação *web* "Gify" que tem como objetivo permitir a utilização da função *princals()* do pacote *Gifi* de forma intuitiva e simplificada.
