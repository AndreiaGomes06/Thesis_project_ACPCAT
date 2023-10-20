#Aplicação web que permite utilizar a função princals() do pacote Gifi para realizar uma análise do componentes principais categórica

#Librarias utilizadas
library(shiny)
library(shinydashboard)
library(DT)
library(Gifi)
library(gotop)

# UI - User interface
ui <- dashboardPage(skin = "purple",
                    dashboardHeader(title = "Gify", titleWidth = 180
                    ),
  #Nomes das secções do separador lateral                  
  dashboardSidebar(
    width = 180, #tamanho do separador
    sidebarMenu(
      id = "tabs",
      menuItem("User guides", tabName = "guide", icon = icon("book")),          #nome da secçao | id da secçao | icon apresentado
      menuItem("Upload file", tabName = "upload", icon = icon("file-arrow-up")),
      menuItem("Run analysis", tabName = "runfunc", icon = icon("play")),
      menuItem("Summary of the results", tabName = "result_sum", icon = icon("square-poll-horizontal")),
      menuItem("Values", tabName = "valuesobt", icon = icon("list-ul")),
      menuItem("Plots", tabName = "plots", icon = icon("chart-line"))
    )),
  dashboardBody(
    tabItems(
      # User guidelines - descrição das secções disponiveis na aplicação
      tabItem(tabName = "guide",
              HTML("<h3>Key insights for a better understanding of the Gify application:</h3>
       <p>This app allows you to perform a Categorical Principal Component Analysis (CatPCA) using the function 'princals()' from the Gifi package.<p> 
       <p>More informations about this function and package are available at <a href='https://CRAN.R-project.org/package=Gifi'>CRAN</a>.</p>"),
              # Upload
              br(),
              HTML("<h4>Step 1: Upload file</h4>
       <p>You can upload your data in a form of a CVS file in the section 'Upload file'. There, you can also define the parameters for reading your file.</p>"),
              #Run analysis
              HTML("<h4>Step 2: Run analysis</h4>
       <p>In the 'Run analysis' section, you can define the arguments to be used in the 'princals()' function. Please note that the question 'How to define the analysis level?' is crucial for 
       determining whether you want to use predefined analysis levels (ordinal, nominal, metric) or if you prefer to manually define the spline analysis (ordinal and knots). 
       The arguments that follow will depend on your choice. After carefully reviewing all the arguments, you can click the button 'Run analysis', which will automatically send you to the results section.</p>"),
              # Results and summary 
              HTML("<h4>Step 3: Summary of the results</h4>
       <p>In the section 'Summary of the results' is presented the general results and the summary of the results, including the loss value, the number of iterations, the eigenvalues, 
       the component loadings, the Variance Accounted For (VAF) and the cumulative VAF.</p>"),
              # Values 
              HTML("<h4>Step 4: Values</h4>
       <p>In the section 'Values', you can view all the values that can be obtained from the 'princals()' function, that can also be cross-checked at <a href='https://CRAN.R-project.org/package=Gifi'>CRAN</a>.</p>"),
              # Plots
              HTML("<h4>Step 5: Plots</h4>
       <p>Lastly, in the 'Plots' section, it is possible to view the plots obtained (Screeplot, Transplot, Loadplot, Objectplot, Biplot and Jointplot) and choose which dimentions to present, as well the expansion factor for loadings to better fit the joint and biplots. Additionally, the user can download the plots to their own computer.<p>"),
              # Example dataset
              HTML("<h4>Example dataset</h4>
       <p>It is also possible, in order to test the app and gain more insight, to download the 'mammals' dataset, in form of a csv file, using the button below. This dataset is part of the Gifi package and contains data related to the dental pattern of 66 different mammals. 
                   The dataset comprises 8 variables, providing information about the number of upper incisors, lower incisors, upper canines, lower canines, upper premolars, lower premolars, upper molars, and finally, the number of lower molars. More details about this dataset are also available at <a href='https://CRAN.R-project.org/package=Gifi'>CRAN</a>. <p>"),
              # Download example dataset
              downloadButton("download_excel", "Download example file"),
              br(),
              HTML("<h4>Enjoy!</h4>")
      ),
      # Escolha dos argumentos da dunção princals() 
      tabItem(tabName = "runfunc",
              fluidRow(
              box(              #cria 2 caixas numa página que permite separar os argumentos fixos e os argumentos dependentes das variáveis
              use_gotop(),      #botão que permite regressar ao topo da página
              title = h3("Choose the arguments for the princals() function"), width = 6, solidHeader = TRUE,
            
              numericInput("num_dim", "Number of dimensions?", value = 2, min = 2, max = 50),
              selectInput("ties", "How to handle ties?", choices = c("s", "p", "t")),
              selectInput("missing", "How to handle missing values?", choices = c("s", "m", "a")),
              selectInput("norm", "Object scores are z-scores?", choices = c("True", "False")),
              numericInput("itmax", "Maximum number of iterations:", value = 1000, min = 1),
              numericInput("eps", "Convergence criterion:", value = 1e-06)
              ),
              box(              #argumentos dependentes das variáveis
                  selectInput("type_analysis", "How to define the analysis levels?", 
                              choices = c("predefined levels", "manual splines")),
              conditionalPanel( #painéis condicionais que aparecem dependendo da opção escolhida na questão "How to define the analysis levels?"
                condition = "input.read_data > 0 && input.type_analysis == 'predefined levels'",
                uiOutput("ui_predefined_analysis"),
                actionButton("run_analysis_predefined", "Run Analysis", class = "btn-block")
              ),
              conditionalPanel(
                condition = "input.read_data > 0 && input.type_analysis == 'manual splines'",
                uiOutput("ui_spline_analysis"),
                actionButton("run_analysis_spline", "Run Analysis", class = "btn-block")
              )
              )),
      ),
      # Resultados gerais e súmario de resultados
      tabItem(tabName = "result_sum",
              h3("Summary of the obtained results"),
              #output
              verbatimTextOutput("analysis_output"),
              verbatimTextOutput("output_summary"),
              ),
      # Valores obtidos
      tabItem(tabName = "valuesobt",
              h3("Obtained values"),   #Opção que permite escolher que valores dos resultados pretende visualizar
              selectInput("values", "Values:", choices = c("transform", "rhat", "evals", "objectscores", "scoremat", "quantifications", "dmeasures", "lambda", "weights", "loadings", "ntel", "f", "data", "datanum", "ndim", "call")),
              #output
              verbatimTextOutput("analysis_values")
      ),
      # Resultados gráficos
      tabItem(tabName = "plots",
              h3("Plots"),             #Opção que permite escolher que gráficos dos resultados pretende visualizar que será dependente do nivel de análise escolhido para as variáveis
              selectInput("plottype", "Plot type:", choices = NULL), 
              numericInput("ndim1", "Dimension to be plotted:", value = 1, min = 1), #Dimensão a ser traçada no gráfico
              numericInput("ndim2", "Dimension to be plotted:", value = 2, min = 1), #Dimensão a ser traçada no gráfico
              numericInput("expand", "Expansion factor for loadings:", value = 1),   #Critério de expansão para ajustar o tamanho dos loadings no gráfico Joint e Biplot
              #output
              div(
              plotOutput("plot", height = "600px", width = "60%"),  #Ajuste do tamanho do output do gráfico e alinhar ao centro da página
              style = "display: flex; justify-content: center; align-items: center; height: 100vh;"),
              downloadButton("download", "Download Plot")           #Botão que permite fazer download do gráfico
      ),
      # Upload CSV file  
      tabItem(tabName = "upload", 
              h3(fileInput("upload", "Upload a CSV file", accept = c(
                'text/csv','text/comma-separated-values', '.csv'))),
              checkboxInput("header", "Header", value = TRUE),
              checkboxInput("rownames", "Row names", value = FALSE),
              radioButtons("separator","Separator: ", choices = c(";", ",", ":"), selected = ";", inline = TRUE),
              radioButtons("disp", "Display", choices = c("Head", "All"), selected = "Head"),
              actionButton("read_data", "Read Data"),                #Botão que permite fazer a leitura dos dados 
              #output
              DT::dataTableOutput("head")
      )
    )
  ), tags$head(tags$style(HTML('* {font-family: "Arial"};'))))       # Tipo de letra utilizado na aplicação

#Server - backend
server <- function(input, output, session) {
  # Donwload do dataset de exemplo "mammals"  
  output$download_excel <- downloadHandler(
    filename = function() {
      "example_dataset_mammals.csv"  
    },
    content = function(file) {
      file.copy("mamiferos.csv", file)
    }
  )
  
  # Upload dataset
  dataset <- reactiveVal(NULL)
  variable_names <- reactiveVal(character(0))
  
  observeEvent(input$read_data, {
    if (!is.null(input$upload)) {
      if (input$rownames == FALSE) { 
        dataset(read.csv(input$upload$datapath, header = input$header, sep = input$separator, na.strings = c(""), stringsAsFactors = TRUE))
        variable_names(names(dataset()))  #considera os nomes das variáveis
      } else {           #se o dataset não tiver a primeira coluna como nomes das observações
        dataset(read.csv(input$upload$datapath, header = input$header, sep = input$separator, row.names = 1, na.strings = c(""), stringsAsFactors = TRUE ))
        variable_names(names(dataset())) 
        }
    }
  })

  # Como representar os dados - head ou full dataset
  observeEvent(input$read_data, {
    output$head <- DT::renderDataTable({
    if(input$disp == "Head") {  #output das primeiras 6 linhas
      return(head(dataset()))
    }
    else {
      return(dataset())         #output do dataset completo
    }
  }, options = list(scrollX = TRUE))
  })
  
  # Se type_analysis = predefined levels -> conditional panel,  
  output$ui_predefined_analysis <- renderUI({           
    ui_predefined_list <- lapply(variable_names(), function(var) {  #para cada variável do dataset carregado
      tagList(                                                      #taglist - permite agrupar todos os elementos numa só estrutura
        selectInput(inputId = paste0(var, "_analysis"),             #id para usar posteriormente ex.: var_analysis
                    label = paste("Select analysis type for the variable", var),
                    choices = c("ordinal", "nominal", "metric")),
        numericInput(inputId = paste0(var, "_degree"), label = paste("Spline degree of the variable", var), value = 1),
        numericInput(inputId = paste0(var, "_copies"), label = paste("Number of copies of the variable", var), value = 1, min = 0),
        selectInput(inputId = paste0(var, "_active"), label = paste("Is the variable", var,"active for this analysis?"),
                    choices = c( "True", "False"))
      )
    })
    do.call(tagList, ui_predefined_list)
  })
  
  # Tipo de gráficos condicionais que dependem se os níveis de análise escolhidos são iguais para todas as vriáveis ou não 
  plot_types <- reactive({
    analysis_level <- lapply(variable_names(), function(var) {
      input_id <- paste0(var, "_analysis")   #forma o id 
      input[[input_id]]                      #input$input_id, valor que foi escolhido pelo utilizador para var_analysis
    })
    # segundo o que foi escolhido vão aperecer os botões de seleção para a escolha do tipo de gráfico
    if (all(analysis_level == "ordinal")) {                                           #se todas as variáveis forem ordinais é excluída a opção jointplot que só funciona se existerem variáveis categóricas
      return(c("screeplot", "transplot", "loadplot", "biplot", "objplot"))
    } else if (any(analysis_level == "metric") && any(analysis_level == "ordinal")) { #se forem escolhidos somente niveis de análise ordinais e numéricos esta restrição mantem-se
      return(c("screeplot", "transplot", "loadplot", "biplot", "objplot"))
    } else if (all(analysis_level == "nominal")) {                                    #se todas as variáveis forem nominais são excluídas as opções load e biplot, uma vez que só existerem variáveis categóricas
      return(c("screeplot", "transplot", "jointplot", "objplot"))
    } else {                                                                          #no caso de termos análises mistas, com variáveis categóricas, todas as opções de gráficos podem ser visualizadas
      return(c("screeplot", "transplot", "jointplot", "loadplot", "biplot", "objplot")) 
    }
    
  })
  
  # Update dos tipos de gráficos que aparecem na opção do input 
  observe({
    updateSelectInput(session, "plottype", choices = plot_types()) 
  })
  
  # Se type_analysis = manual splines -> conditional panel,
  output$ui_spline_analysis <- renderUI({
    ui_spline_list <- lapply(variable_names(), function(var) {
      tagList(
        selectInput(inputId = paste0(var, "_ordinal"), label = paste("Does the variable", var, "follow an ordinal order?"),
                    choices = c( "True", "False")),
        #knots
        selectInput(inputId = paste0(var, "_knotstype"), label = paste("Type of knots for the variable", var, ":"),
                    choices = c("D", "R", "E", "Q")),
        numericInput(inputId = paste0(var, "_knotsnum"), label = paste("Number of interior knots (ignored for type = 'E' and type = 'D') for the variable", var), value = 3),
        #
        numericInput(inputId = paste0(var, "_degree"), label = paste("Spline degree of the variable", var), value = 1),
        numericInput(inputId = paste0(var, "_copies"), label = paste("Number of copies of the variable", var), value = 1, min = 0),
        selectInput(inputId = paste0(var, "_active"), label = paste("Is the variable", var,"active for this analysis?"),
                    choices = c( "True", "False"))
      )
    })
    do.call(tagList, ui_spline_list)
  })
  
  # Se a opção de análise escolhida for predefined levels
  observeEvent(input$run_analysis_predefined, {
    analysis_arguments <- lapply(variable_names(), function(var) {
      analysis_inputId <- paste0(var, "_analysis") 
      degree_inputId <- paste0(var, "_degree")
      copies_inputId <- paste0(var, "_copies")
      active_inputId <- paste0(var, "_active")
      
      analysis_type_res <- input[[analysis_inputId]]              #valor escolhido para a opção var_analysis
      degree_res <- input[[degree_inputId]]
      copies_res <- input[[copies_inputId]]
      active_res <- input[[active_inputId]]
      
      list(variable = var, analysis_type_res = analysis_type_res, degree_res = degree_res, copies_res = copies_res, active_res = active_res) #lista com as escolhas de cada variável 
    })      
    
    analysis_levels <- sapply(analysis_arguments, function(arg) { #junta todos os analysis_type_res de todas as variáveis num vetor
      arg$analysis_type_res 
    })

    num_degree <- sapply(analysis_arguments, function(arg) {
      arg$degree_res
    })
    
    num_copies <- sapply(analysis_arguments, function(arg) {
      arg$copies_res
    })
    
    active_variables <- sapply(analysis_arguments, function(arg) {
      arg$active_res
    })
    #todos os argumentos são passados à função princals() na forma de vetores que seguem a ordem das variáveis no dataset original ou de valores unitários se for esse o caso
    analysis_result_predefined <- princals(
      dataset(),
      ndim = input$num_dim,
      levels = analysis_levels,
      ties = input$ties,
      degrees = num_degree,
      copies = num_copies,
      missing = input$missing,
      normobj.z = input$norm,
      active = active_variables,
      itmax = input$itmax,
      eps = input$eps
    )
    
    # Resultados gerais e sumário de resultados
    output$analysis_output <- renderPrint({analysis_result_predefined})                   #resultados gerais dados pela função
    output$output_summary <- renderPrint({                                                #sumário dos resultados dados pela função
      summary(analysis_result_predefined, cutoff = 0.5)
    })
    # Valores obtidos
    output$analysis_values <- renderPrint({ analysis_result_predefined[[input$values]] }) #valores de resultados obtidos pela função
    # Resultados gráficos
    output$plot <- renderPlot({                                                           #gráficos obtidos pela função
      plot(analysis_result_predefined, plot.type = input$plottype, plot.dim = c(input$ndim1, input$ndim2), expand = input$expand)
    })
    
    # Update TabItem
    updateTabItems(session, "tabs", selected = "result_sum" )                             #envia o utilizador automáticamente para o separador sumário de resultados
    
    # Download dos gráfcos como imagens .png 
    output$download <- downloadHandler(                                                   #permite fazer o download dos gráficos para o computador pessoal do utilizador
      filename = function(){
        paste("plot","png", sep = ".")
      },
      content = function(file){
        png(file)
        plot(analysis_result_predefined, plot.type = input$plottype, plot.dim = c(input$ndim1, input$ndim2))
        dev.off()
      }
    )
  
  })
  
  # Se a opção de análise escolhida for manual splines
  # O mesmo raciocinio descrito anteriormente és seguido para o caso de ser escolhida a opção de definir uma análise spline, onde o argumento "levels" é substituido pelos arumentos "ordinal" e "knots"
  observeEvent(input$run_analysis_spline, {
    analysis_arguments <- lapply(variable_names(), function(var) {
      ordinal_inputId <- paste0(var, "_ordinal")
      knotstype_inputId <- paste0(var, "_knotstype")
      knotsnum_inputId <- paste0(var, "_knotsnum")
      degree_inputId <- paste0(var, "_degree")
      copies_inputId <- paste0(var, "_copies")
      active_inputId <- paste0(var, "_active")
      
      ordinal_res <- input[[ordinal_inputId]]
      knotstype_res <- input[[knotstype_inputId]]
      knotsnum_res <- input[[knotsnum_inputId]]
      degree_res <- input[[degree_inputId]]
      copies_res <- input[[copies_inputId]]
      active_res <- input[[active_inputId]]
      
      
      list(variable = var, ordinal_res = ordinal_res, knotstype_res = knotstype_res, knotsnum_res = knotsnum_res, degree_res = degree_res, copies_res = copies_res, active_res = active_res)
    })
    
    
    var_ordinal <- sapply(analysis_arguments, function(arg) { 
      arg$ordinal_res
    })
    
    knots_types <- sapply(analysis_arguments, function(arg) {
      arg$knotstype_res
    })
    
    num_knots <- sapply(analysis_arguments, function(arg) {
      arg$knotsnum_res
    })
    
    num_degree <- sapply(analysis_arguments, function(arg) {
      arg$degree_res
    })
    
    num_copies <- sapply(analysis_arguments, function(arg) {
      arg$copies_res
    })
    
    active_variables <- sapply(analysis_arguments, function(arg) {
      arg$active_res
    })
    
    num_knots <- as.numeric(num_knots)     #o número de nós é transformado numa variável numérica 
    knots_list <- list()
    
    # Função auxíliar KnotsGifi 
    for (i in seq_along(dataset())) {                                                       #o tipo e número de nós é definido individualmente para cada variável e agrupado numa lista para ser passado à função princasl()
      if (knots_types[i] %in% c("D", "R", "E", "Q")) {                                      #verifica de o tipo de knots corresponde ao aceites pela função
        knots_list[i] <- knotsGifi(dataset()[, i], type = knots_types[i], n = num_knots[i]) #corre a função auxiliar KnotsGifi o guarda o resultado numa lista 
      }
    }
    
    analysis_result_spline <- princals(
      dataset(),
      ndim = input$num_dim,
      ordinal = var_ordinal,
      knots = knots_list,
      ties = input$ties,
      degrees = num_degree,
      copies = num_copies,
      missing = input$missing,
      normobj.z = input$norm,
      active = active_variables,
      itmax = input$itmax,
      eps = input$eps
    )
    
    # Resultados gerais e sumário de resultados
    output$analysis_output <- renderPrint({ analysis_result_spline })
    output$output_summary <- renderPrint({summary(analysis_result_spline, cutoff = 0.5)})
    # Valores obtidos
    output$analysis_values <- renderPrint({ analysis_result_spline[[input$values]] })
    # Resultados gráficos
    output$plot <- renderPlot({
      plot(analysis_result_spline, plot.type = input$plottype, plot.dim = c(input$ndim1, input$ndim2), expand = input$expand)
    })
    
    #Update TabItem
    updateTabItems(session, "tabs", selected = "result_sum")
    
    # Download dos gráfcos como imagens .png 
    output$download <- downloadHandler(
      filename = function(){
        paste("plot","png", sep = ".")
      },
      content = function(file){
        png(file)
        plot(analysis_result_spline, plot.type = input$plottype, plot.dim = c(input$ndim1, input$ndim2))
        dev.off()
      }
    )
  })
  
  
}

# Função que permite agregar os dois componentes anteriores e tonar a aplicação funcional
shinyApp(ui, server)


