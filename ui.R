shinyServer(
  #setwd("~/Desktop/SHINY_scATAC-SEQ")

  
  fluidPage(
    navbarPage("sc-ATAC-Seq explorer for Low Grade Gliomas",
               tabPanel("scATAC-Seq"),
               tabPanel("scRNA-Seq")
               #tabPanel("Component 3")
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
                        c('Samples'= 'sample_id', 'Diagnosis'='type_id', 'Gene related'='gene_id'))    ),
    column(4,
           checkboxInput('jitter2', 'Jitter')
    ),
    column(3,
           h3(span(strong(em("Settings:")), style = "color:#212F3D")),
           br(),
           sliderInput("dotSize", strong("Select dot size"),
                       min=0.1, max=5, value = 2.1, step = 0.2), 
           br(),
           checkboxInput('background', strong('Guiding background')),
           br(),
           downloadButton(outputId="download_image",label = "Download plot")
    )
    
    
    )))
    
