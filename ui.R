shinyServer(
  #setwd("~/Desktop/SHINY_scATAC-SEQ")
  
  pageWithSidebar(
    headerPanel  ("Shiny browser for sc-ATAC-Seq"),
    
    sidebarPanel  (
                    selectInput("Peaks", "please select eak type",
                                choices = c("Super peaks>=5 reads", "Normal peaks>=1 read") ) ,
                    sliderInput("dotSize", "Select sample size",
                                min=1, max=10, value = 5, step = 1),
                    conditionalPanel("input.Peaks=='Super peaks>=5 reads'",
                                     textInput("Mean","please enter",5)),
                    conditionalPanel("input.Peaks=='Normal peaks>=1 read'",
                                     textInput("Max median","please enter",5),
                                     textInput("Min median","please enter",5)
                                     )
                    ),
    
    
    mainPanel (
      plotOutput("myPlot")
    )
    
    
  )
)



