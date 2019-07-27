shinyServer(
  #setwd("~/Desktop/SHINY_scATAC-SEQ")

  
  fluidPage(
    navbarPage("sc-ATAC-Seq explorer for Low Grade Gliomas",
               tabPanel("scATAC-Seq"),
               tabPanel("scRNA-Seq")
               #tabPanel("Component 3")
    ),
    
    headerPanel  (h2("Explorer for sc-ATAC-Seq low grade glioma tumours", align="center")),
    headerPanel  ("\n"),

    plotOutput("myPlot", width = "900px",height = "450px"),
    
    hr(),
    hr(),
    hr(),
    hr(),
    hr(),
    
    fluidRow(
      column(3,
             h4("Settings:"),
      sliderInput("dotSize", "Select dot size",
                  min=0.1, max=5, value = 2.1, step = 0.2), 
      br(),
     downloadButton(outputId="download_image",label = "Download plot")

     
    
     
     
     
      
    ),
    column(4, offset = 1,
           radioButtons("Col_group_radio", "Color grouping by:",
                        c('Samples'= 'sample_id', 'Diagnosis'='type_id', 'Gene related'='gene_id'))    ),
    column(4,
           checkboxInput('jitter2', 'Jitter')
    )
    
    )))
    
    #sidebarPanel  (
#                    selectInput("Peaks", "please select peak type",
 #                               choices = c("Super peaks>=5 reads", "Normal peaks>=1 read") ) ,
    #                sliderInput("dotSize", "Select sample size",
     #                            min=1, max=10, value = 5, step = 1),
  #                  conditionalPanel("input.Peaks=='Super peaks>=5 reads'",
   #                                  textInput("Mean","please enter",5)),
    #                conditionalPanel("input.Peaks=='Normal peaks>=1 read'",
     #                                textInput("Max median","please enter",5),
      #                               textInput("Min median","please enter",5)
       #                              )
     #               ),
    
    
#    mainPanel (
 #     plotOutput("myPlot")
  #  )
    
    
#  )
#)



