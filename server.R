#setwd("/home/ros/Desktop/SHINY_scATAC-Seq-master")
#library(shiny)
#runApp()
#install.packages("png")
#if (!require("pacman")) install.packages("pacman")
#if (!require("png")) install.packages("png")
#install.packages("shinythemes")


shinyServer(function(input, output,session) {
  
  library(ggplot2)
  
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
          genes1=gene_matrix[input$selected_gene1,]
          genes2=gene_matrix[input$selected_gene2,]
          genes= rep(0,ncol(gene_matrix))
          genes=genes1+2*genes2
          graphy= data.frame(tsneY,our_small_peaky,genes)
         colnames(graphy)=c("X","Y","type","sample","gene")
         plot1 <-  ggplot(graphy,aes(X,Y,col=factor(type),shape=factor(genes)))+
           theme(plot.title = element_text("Explorer for sc-ATAC-Seq low grade glioma tumours", size=14, face="bold.italic"))+
           scale_colour_manual(name = " Tumor type",values = c("brown4","cadetblue4"), labels = c("Astrocytoma","Oligodendroglioma"))+
           scale_shape_manual(name  =paste(input$selected_gene1,"and",input$selected_gene2,"peaks"), values = c(1, 6, 8 ,19),labels=c("None",input$selected_gene1,input$selected_gene2,"Both")) +
           theme_classic()+
           geom_point(size=tsize)         
         
         table1<-table(t(genes))
         names(table1)<-c("None",input$selected_gene1,input$selected_gene2,"both")
         table1=data.frame(table1)
         colnames(table1)<-c("Gene", "Total_count")
         table1=cbind(table1,Astro=c(sum(genes[,graphy$type=="astro"]==0),
                                     sum(genes[,graphy$type=="astro"]==1),
                                     sum(genes[,graphy$type=="astro"]==2),
                                     sum(genes[,graphy$type=="astro"]==3)) )
         table1=cbind(table1,Oligo=c(sum(genes[,graphy$type=="Codel"]==0),
                                     sum(genes[,graphy$type=="Codel"]==1),
                                     sum(genes[,graphy$type=="Codel"]==2),
                                     sum(genes[,graphy$type=="Codel"]==3)))
                                     
         colnames(table1)<-c("Gene", "Total","Astro","Oligo")
         #render stat table
         output$myTable1<- renderTable({
           table1
         }  )
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
      table0<-table(t(genes))
      names(table0)<-c("None",input$selected_gene)
      table0=data.frame(table0)
      table0=cbind(table0,Astro=c(length(gene_matrix[input$selected_gene,graphy$type=="astro"])-sum(gene_matrix[input$selected_gene,graphy$type=="astro"]),
                                  sum(gene_matrix[input$selected_gene,graphy$type=="astro"])))
      table0=cbind(table0,Oligo=c(length(gene_matrix[input$selected_gene,graphy$type=="Codel"])-sum(gene_matrix[input$selected_gene,graphy$type=="Codel"]),
                                  sum(gene_matrix[input$selected_gene,graphy$type=="Codel"])))
      colnames(table0)<-c("Gene", "Total","Astro","Oligo")
      tableX<-reactive(table0)
      #render stat table
      output$myTable <- renderTable({
        table0
      }  )
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
