#setwd("~/Desktop/SHINY_scATAC-SEQ")


shinyServer(function(input, output,session) {
  our_small_peaky=read.csv(file = "colData.csv",row.names = 1)
  tsneY = read.csv(file = "TSNE_scATAC.csv",row.names = 1)
  
  output$myPlot<- renderPlot({
   library(ggplot2)
    
    graphy= data.frame(tsneY,our_small_peaky)
    colnames(graphy)=c("X","Y","type","sample")
    
    tsize=input$dotSize
    ggplot(graphy,aes(X,Y,col=factor(sample)))+
      scale_colour_manual(name = "samples",values = c("brown4","brown2","cadetblue3"))+
      theme_classic()+
      geom_point(size=tsize)
    #plot(graphy$X,graphy$Y, cex=tsize,col=graphy$sample,pch=19)
    }
    
  )
  
}
)