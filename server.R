install.packages("ggplot2")
library(ggplot2)
tsneY = read.csv(file = "TSNE_scATAC.csv",row.names = 1)
our_small_peaky=read.csv(file = "colData.csv",row.names = 1)
graphy= data.frame(tsneY,our_small_peaky)
colnames(graphy)=c("X","Y","type","sample")


shinyServer(function(input, output,session) {
  
  output$myPlot<- renderPlot({
    tsize=input$dotSize
#    print(tsize)
    ggplot(graphy,aes(X,Y,col=factor(sample)))+
      scale_colour_manual(name = "samples",values = c("brown3","brown2","cadetblue3"))+
      theme_classic()+
      geom_point(size=tsize)
  }
    
  )
  
  
  
  
  
}
)