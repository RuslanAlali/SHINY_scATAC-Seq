#setwd("/home/ros/Desktop/SHINY_scATAC-Seq-master")
#library(shiny)
#runApp()
#install.packages("png")
library(ggplot2)

shinyServer(function(input, output,session) {
  our_small_peaky=read.csv(file = "colData.csv",row.names = 1)
  tsneY = read.csv(file = "TSNE_scATAC.csv",row.names = 1)
  
  graphy= data.frame(tsneY,our_small_peaky)
  colnames(graphy)=c("X","Y","type","sample")
  
  Ploting=NULL
  
  plotReactive<-reactive({
    tsize=input$dotSize
    if (input$Col_group_radio=="sample_id"){
      plot1=ggplot(graphy,aes(X,Y,col=factor(sample)))+
        scale_colour_manual(name = "By sample               .",values = c("brown4","brown2","coral3","cadetblue3","cadetblue4"), labels = c("Astro1","Astro2","Astro3","Oligo1","Oligo2"))+
        theme_classic()+
        geom_point(size=tsize)
    }else if (input$Col_group_radio=="type_id"){
      plot1=ggplot(graphy,aes(X,Y,col=factor(type)))+
        scale_colour_manual(name = "Tumor type",values = c("brown4","cadetblue4"), labels = c("Astrocytoma","Oligodendroglioma"))+
        theme_classic()+
        geom_point(size=tsize)
      
    }else{
      plot1 <-  ggplot(graphy,aes(X,Y,col=factor(type)))+
        scale_colour_manual(name = "Tumor type",values = c("brown4","cadetblue4"), labels = c("Astrocytoma","Oligodendroglioma"))+
        theme_classic()+
        geom_point(size=tsize)
    } 
  })
  
  
  output$myPlot<- renderPlot({
      print(plotReactive())
    }  )
  


  output$download_image<- downloadHandler(        filename = function() { paste('plot', '.png', sep='') },
                                                  content=function(file){
                                                    png(file)
                                                    ggsave(plot= print(plotReactive()) ,filename = file,  width = 9,height = 4.5, units = "in")
                                                     }) 
  
})
