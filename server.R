#setwd("/home/ros/Desktop/SHINY_scATAC-Seq-master")
#library(shiny)
#runApp()
#install.packages("png")
#if (!require("pacman")) install.packages("pacman")
#if (!require("png")) install.packages("png")


shinyServer(function(input, output,session) {
  
  library(ggplot2)
 
  #gene_list=reactive({read.csv(file="data/gene_matrix.csv", header = FALSE)})
  
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
       
        }else if (input$Col_group_radio=="gene2_id"){
          genes=as.numeric(factor(colSums(gene_matrix[c(input$selected_gene1,input$selected_gene2),])>1,labels=c(0,1)))-1
         graphy= data.frame(tsneY,our_small_peaky,genes)
         colnames(graphy)=c("X","Y","type","sample","gene")
         plot1 <-  ggplot(graphy,aes(X,Y,col=factor(type),shape=factor(genes)))+
           theme(plot.title = element_text("Explorer for sc-ATAC-Seq low grade glioma tumours", size=14, face="bold.italic"))+
           scale_colour_manual(name = " Tumor type",values = c("brown4","cadetblue4"), labels = c("Astrocytoma","Oligodendroglioma"))+
           scale_shape_manual(name  =paste(input$selected_gene1,"and",input$selected_gene2,"peaks"), values = c(1, 19),labels=c("FALSE", "TRUE")) +
           theme_classic()+
           geom_point(size=tsize)         
       }else{
      
      genes=gene_matrix[input$selected_gene,]
      graphy= data.frame(tsneY,our_small_peaky,genes)
      colnames(graphy)=c("X","Y","type","sample","gene")
      plot1 <-  ggplot(graphy,aes(X,Y,col=factor(type),shape=factor(genes)))+
        theme(plot.title = element_text("Explorer for sc-ATAC-Seq low grade glioma tumours", size=14, face="bold.italic"))+
        scale_colour_manual(name = " Tumor type",values = c("brown4","cadetblue4"), labels = c("Astrocytoma","Oligodendroglioma"))+
        scale_shape_manual(name  =paste(input$selected_gene,"peaks"), values = c(1, 19),labels=c("FALSE", "TRUE")) +
        theme_classic()+
        geom_point(size=tsize)
    } 
    
    # Add photo background
    if (input$background) {
      #library(pacman)
      #sudo chmod 777 /usr/local/lib/R/site-library
      if (!require("png")) install.packages("png")
      library(grid)
      library(png)
      image <- png::readPNG("img/background.png")
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
