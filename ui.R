shinyServer(
  #setwd("~/Desktop/SHINY_scATAC-SEQ")
  
  pageWithSidebar(
    headerPanel  ("Shiny browser for sc-ATAC-Seq"),
    
    sidebarPanel  (
                    selectInput("Peaks", "please select eak type",
                                choices = c("Super peaks>=5 reads", "Normal peaks>=1 read") ) ,
                    sliderInput("Amount of genes", "Select sample size",
                                min=100, max=1000, value = 500, step = 50),
                    conditionalPanel("input.Peaks=='Super peaks>=5 reads'",
                                     textInput("Mean","please enter",5)),
                    conditionalPanel("input.Peaks=='Normal peaks>=1 read'",
                                     textInput("Max median","please enter",5),
                                     textInput("Min median","please enter",5)
                                     )
                    ),
    
    
    mainPanel ("Main is here")
    
    
  )
)



