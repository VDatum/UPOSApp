if(!require(shiny)){install.packages("shiny")}
if(!require(udpipe)){install.packages("udpipe")}
if(!require(textrank)){install.packages("textrank")}
if(!require(lattice)){install.packages("lattice")}
if(!require(ggraph)){install.packages("ggraph")}
if(!require(igraph)){install.packages("igraph")}
if(!require(ggplot2)){install.packages("ggplot2")}
if(!require(wordcloud)){install.packages("wordcloud")}
if (!require(tidyverse)) {install.packages("tidyverse")}
if (!require(tidytext)) {install.packages("tidytext")}
if (!require(tm)) {install.packages("tm")}
if(!require(stringr)){install.packages("stringr")}
if (!require(rsconnect)){install.packages("rsconnect")}


library(shiny)
library(udpipe)
library(textrank)
library(lattice)
library(ggraph)
library(igraph)
library(ggplot2)
library(wordcloud)
library(stringr)
library(rsconnect)
library('tm')
library(textstem)

#shiny: helps to build shiny app and has various features neccessary for building shiny app
#udpipe: it is a NLP processing toolkit which has language independent tokenization, lemmetization etc.
#textrank: a graph-based ranking model for text processing which can be used to find the most 
          #relevant sentences in text and also to find keywords
#lattice:attempts to improve on base R graphics by providing better defaults and 
         #the ability to easily display multivariate relationships

model <- udpipe_download_model(language = "english")
getwd()
