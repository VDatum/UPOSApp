
#Starting the server,

shinyServer(
  function(input,output){

    #Reading the dataset
    Dataset <- reactive({
      
      if(is.null(input$file)){return (NULL)}
      else{
        text<-readLines(input$file$datapath)
        text=str_replace_all(text,"[[:punct:]]"," ")
        text=text[text!=""]
        return(text)
      }
    })
    
    #Loading the English model to be used, we can use other models as well
    english_model = reactive({
      english_model = udpipe::udpipe_load_model("english-ud-2.0-170801.udpipe")
      
      return (english_model)
    })
   
    # Populate the annotate tab 
    annot.obj= reactive({
      x<- udpipe_annotate(english_model(), x= Dataset())
      x<-as.data.frame(x)
      return(x)
    })
    
    output$tab2= renderDataTable({
      if(is.null(input$file)){
        output$placeholder=renderText("You have to add a text file to see the annotated object")
        return(NULL)}
      else{
        output$placeholder=renderText(" ")
        out=annot.obj()[,-4]
        return(out)
      }
    })
    
    output$plot1=renderPlot({
      if(is.null(input$file)){
       
        return(NULL)}
      else{
        
        all_nouns=annot.obj()%>%subset(.,upos%in%"NOUN")
        top_nouns=txt_freq(all_nouns$lemma)
        
        wordcloud(top_nouns$key,top_nouns$freq,min.freq=3,colors=1:10)
      }
      
    })
    
    output$plot2=renderPlot({
      if(is.null(input$file)){
        output$placeholderTab3=renderText("You have to add a text file to see the annotated object")
        return(NULL)}
      else{
        output$placeholderTab3=renderText("")
        all_verbs=annot.obj()%>%subset(.,upos%in%"VERB")
        top_verbs=txt_freq(all_verbs$lemma)
        
        wordcloud(top_verbs$key,top_verbs$freq,min.freq=3,colors=1:10)
      }
      
    })
    
    output$plot3=renderPlot({
      if(is.null(input$file)){
        output$placeholderTab4=renderText("You have to add a text file to see the annotated object")
        return(NULL)}
      else{
        output$placeholderTab4=renderText("")
        coor_graph <-cooccurrence(
          x=subset(annot.obj(), upos%in% input$upos),
          term="lemma",
          group= c("doc_id","paragraph_id","sentence_id"))
        
        wordnetwork <- head(coor_graph,50)
        wordnetwork <- igraph::graph_from_data_frame(wordnetwork)
        
        ggraph(wordnetwork,layout="fr")+
          
          geom_edge_link(aes(width=cooc,edge_alpha=cooc),edge_colour="red")+
          geom_node_text(aes(label=name),col="darkgreen",size=4)+
          
          theme_graph(base_family="Arial Narrow")+
          theme(legend.position="none")+
          
          labs(title="Cooccurence Plot")
      }
      
    })
    
    output$plot4 <- renderPlot({
       if(is.null(input$file)){
        return(NULL)
      }
      else{
      set1 <- txt_freq(annot.obj$upos)
      set1$key <- factor(set1$key, levels = rev(set1$key))
      barchart(key ~ freq, data = set1, col = "cadetblue", 
               main = "UPOS (Universal Parts of Speech)\n frequency of occurrence", 
               xlab = "Freq")
        }
      
    })
      
    output$download <-downloadHandler(
      
      filename = function(){
        "annotated_data.csv"
      },
      content = function(file){
        write.csv(annot.obj()[,-4],file,row.names=FALSE)
      }
    )

  })
