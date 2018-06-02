if (!require(shiny)){install.packages("shiny")}

library("shiny") # Library required to work this APP

ui <- shinyUI(
  
  fluidPage(
    
    titlePanel("Parts of Speech App"),
    
    sidebarLayout( 
      
      sidebarPanel(  
        
        fileInput("file", "Upload text file"),
        
        
        checkboxGroupInput(inputId = "upos", 
                           label = "Universal Parts-of-Speech Tags", 
                           choices = c("ADJ", "NOUN", "PROPN", "ADV", "VERB"),
                           selected=c("ADJ","NOUN","PROPN")),
        downloadButton("download", "Download Annotation"),
        
        # Include clarifying text ----
        helpText("The model used for this Shiny App is English model.")
        
        
      ),   # end of sidebar panel
      mainPanel(
        
        tabsetPanel(type = "tabs",
                    
                    tabPanel("Overview",
                             img(src="pos.jpg",height=200 ,width=400),
                             h4(p("What kind of files are supported")),
                             p("This shiny app supports only text files."),
                             h4('Description about the app'),
                             p("This app is primarily designed for uploading a file and carrying out the analysis on the text in the file 
                                on the basis of the different parts of speech like Noun, Verb, etc. This app has four tabs- Overview, Annotation,
                                Plots and Coocuurences."),
                             h4('How to use the app?'),
                             p("To use this app, select the file from your computer and upload it using the" ,span(strong("Upload text file")),
                               ", then you can view the annotated table by clicking on the Annotation tab, plots and coocurences by 
                               clicking on the Plots and coocurence tab.") 
                    ),
                    
                    
                    tabPanel("Annotation",p(textOutput('placeholder')),
                             dataTableOutput('tab2')),
                    
                    
                    tabPanel("Plots",
                             p(textOutput('placeholderTab3')),
                             h3("Nouns"),
                             plotOutput('plot1'),
                             h3("Verbs"),
                             plotOutput('plot2')),
                    
                    tabPanel("Co-occurences",p(textOutput('placeholderTab4')),
                             plotOutput('plot3')),
                    tabPanel("Most frequently occured UPOS",p(textOutput('placeholderTab5')),
                             plotOutput('plot4'))
                    

        
                    
        ) # end of tabsetPanel
      )# end of main panel
    ) # end of sidebarLayout
  )  # end if fluidPage
)# end of UI
