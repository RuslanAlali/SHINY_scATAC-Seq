shinyServer(
  #setwd("/home/ros/Desktop/SHINY_scATAC-Seq-master")

  fluidPage(
    #gene_list=reactive(read.csv(file="data/gene_list.csv", header = FALSE)),
    style = 'width:900px;',
    navbarPage("sc-ATAC-Seq explorer for Low Grade Gliomas",
               tabPanel("scATAC-Seq"),
               tabPanel("scRNA-Seq")
    ),
    
    headerPanel  (h2("Explorer for sc-ATAC-Seq low grade glioma tumours")),
    headerPanel  ("\n"),

     plotOutput("myPlot", width = "900px",height = "450px"),
    
    br(),
    br(),
    br(),
    br(),
    br(),
    
    fluidRow(
    column(4, offset = 1,
           radioButtons("Col_group_radio", "Color grouping by:",
                        c('Samples'= 'sample_id', 'Diagnosis'='type_id', 'Gene related'='gene_id', 'Compare 2 genes'='gene2_id'))    ),
    
    column(4, 
           conditionalPanel(
             condition = "input.Col_group_radio == 'gene_id'",
             selectInput("selected_gene", "Choose a gene:",
                         choices = list_genes, selected = 'EGR1' )),
           conditionalPanel(
             condition = "input.Col_group_radio == 'gene2_id'",
             selectInput("selected_gene1", "Choose a gene:",
                         choices = list_genes, selected = 'EGR1' ),
           
             selectInput("selected_gene2", "Choose a 2nd gene:",
                         choices = list_genes, selected = 'OLIG2' ))
           ),
    
    column(3,
           h3(span(strong(em("Settings:")), style = "color:#212F3D")),
           br(),
           sliderInput("dotSize", strong("Select dot size"),
                       min=0.1, max=5, value = 2.1, step = 0.2), 
           br(),
           checkboxInput('background', strong('Guiding background'), value = T),
           br(),
           downloadButton(outputId="download_image",label = "Download plot")
    )
    
    
    )))
    
