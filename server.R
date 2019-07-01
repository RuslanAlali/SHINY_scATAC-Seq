

shinyServer(function(input, output,session) {
  
  output$myPlot<- renderPlot({
   library(ggplot2)
    our_small_peaky=read.csv(file = "/home/SHINY_scATAC-Seq/colData.csv",row.names = 1)
    tsneY = read.csv(file = "/home/SHINY_scATAC-Seq/TSNE_scATAC.csv",row.names = 1)
    
    graphy= data.frame(tsneY,our_small_peaky)
    colnames(graphy)=c("X","Y","type","sample")
    
    tsize=input$dotSize
    ggplot(graphy,aes(X,Y,col=factor(sample)))+
      scale_colour_manual(name = "samples",values = c("brown3","brown2","cadetblue3"))+
      theme_classic()+
      geom_point(size=tsize)
    #plot(graphy$X,graphy$Y, cex=tsize,col=graphy$sample,pch=19)
    }
    
  )
  
}
)