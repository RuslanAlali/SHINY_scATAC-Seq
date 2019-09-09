shinyServer(
  #setwd("/home/ros/Desktop/SHINY_scATAC-Seq-master")
  #install.packages("shinythemes")
  fixedPage(
    
     # theme = shinytheme("flatly"),
    navbarPage(
               title = "LGG single cell explorer",
               tabPanel("scATAC-Seq")#,
               #tabPanel("Integrative analysis with scRNA-Seq")
    ),

    
    headerPanel  (h2("Explorer for scATAC-Seq low grade glioma tumours")),
    headerPanel  ("\n"),
    headerPanel  ("\n"),
    column(12, align="center",
           plotOutput("myPlot", width = "900px",height = "450px")
    ),
    
    br(),
    br(),
    br(),
    br(),
    br(),
    
    fixedRow(
    column(3, offset = 1,
           radioButtons("Col_group_radio", "Color grouping by:",
                        c('Samples'= 'sample_id', 'Diagnosis'='type_id', 'Gene related'='gene_id', 'Compare 2 genes'='gene2_id'))    ),
    
    column(5, 
           conditionalPanel(
             condition = "input.Col_group_radio == 'gene_id'",
             selectInput("selected_gene", "Choose a gene:",
                         choices = list_genes, selected = 'EGR1' ),
             tableOutput("myTable")
           ),
           
           conditionalPanel(
             condition = "input.Col_group_radio == 'gene2_id'",
             selectInput("selected_gene1", "Choose a gene:",
                         choices = list_genes, selected = 'EGR1' ),
           
             selectInput("selected_gene2", "Choose a 2nd gene:",
                         choices = list_genes, selected = 'OLIG2' ),
             tableOutput("myTable1")
             )
           
           ),
    
    column(3,
           h3(span(strong(em("Settings:")), style = "color:#212F3D")),
           br(),
           sliderInput("dotSize", strong("Select dot size"),
                       min=0.1, max=5, value = 2.1, step = 0.2), 
           br(),
           checkboxInput('background', strong('Guiding background'), value = F),
           br(),
           downloadButton(outputId="download_image",label = "Download plot")
    )
    
    
    )))
    
