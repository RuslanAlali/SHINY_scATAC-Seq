#setwd("/home/ros/Desktop/SHINY_scATAC-Seq-master")
#library(shiny)
#runApp()
#install.packages("png")
#if (!require("pacman")) install.packages("pacman")
#if (!require("png")) install.packages("png")


shinyServer(function(input, output,session) {
  
  library(ggplot2)
 
  
  our_small_peaky=read.csv(file = "data/colData.csv",row.names = 1)
  tsneY = read.csv(file = "data/TSNE_scATAC.csv",row.names = 1)
  
  graphy= data.frame(tsneY,our_small_peaky)
  colnames(graphy)=c("X","Y","type","sample")
  

#-----------
#Prepare the plots
#-----------
    plotReactive<-reactive({
    tsize=input$dotSize
    
    if (input$Col_group_radio=="sample_id"){
      plot1=ggplot(graphy,aes(X,Y,col=factor(sample)))+
        scale_colour_manual(values = c("brown4","brown2","coral3","cadetblue3","cadetblue4"), labels = c("Astro1","Astro2","Astro3","Oligo1","Oligo2"),name = "By sample               .")+
        theme_classic()+
        geom_point(size=tsize)
    
      }else if (input$Col_group_radio=="type_id"){
      plot1=ggplot(graphy,aes(X,Y,col=factor(type)))+
        theme(plot.title = element_text("Explorer for sc-ATAC-Seq low grade glioma tumours"))+
        scale_colour_manual(name = "Tumor type",values = c("brown4","cadetblue4"), labels = c("Astrocytoma","Oligodendroglioma"))+
        theme_classic()+
        geom_point(size=tsize)
      
    }else{
      plot1 <-  ggplot(graphy,aes(X,Y,col=factor(type)))+
        theme(plot.title = element_text("Explorer for sc-ATAC-Seq low grade glioma tumours", size=14, face="bold.italic"))+
        scale_colour_manual(name = "Tumor type",values = c("brown4","cadetblue4"), labels = c("Astrocytoma","Oligodendroglioma"))+
        theme_classic()+
        geom_point(size=tsize)
    } 
    
    # Add photo background
    if (input$background) {
      #library(pacman)
      if (!require("png")) install.packages("png")
      library(grid)
      library(png)
      image <- png::readPNG("background.png")
      plot1=plot1+ annotation_custom(rasterGrob(image, width = unit(1,"npc"), height = unit(1,"npc")), -Inf, Inf, -Inf, Inf) }
    else{plot1=plot1}
  })

#-----------
#Render plot
#-----------
  output$myPlot<- renderPlot({
      print(plotReactive())
    }  )
  
#-----------
#Download image
#-----------
    output$download_image<- downloadHandler(  filename = function() { paste('plot', '.png', sep='') },
                                              content=function(file){
                                              png(file)
                                              ggsave(plot= print(plotReactive()) ,filename = file, dpi = 300, width = 12,height = 6, units = "in") }) 
  
})
