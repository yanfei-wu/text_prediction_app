library(shiny)

shinyUI(fluidPage(
  
  theme = "bootstrap.css",
  titlePanel(h1(HTML("<strong>Text Predictor</strong>"))),
  h5("By Yanfei Wu"),
  hr(),
  
  fluidRow(
    column(12, 
      p("This is a text predictive app, inspired by Swiftkey, a predictive keyboard on smart phones."), 
      p(" "),
      p("Just like typing on a smart phone, you can simply type in the input box. The app \
        will display 3 most probable options of the next word based on your input. You can click on one of \
        them if you see a match or just keep typing. See if the app finishes your thoughts."),
      p(" "),
      p("The heart of this app is a predictive text model based on N-gram frequency with 'stupid backoff algorithm'. \
        A text corpus consisting of English news, blogs, and tweets are cleaned and used for building N-gram frequency tables. \
        The frequency tables serve as frequency dictionaries for the predictive model."), 
      p(" "),
      p("Note that currently this app only supports English."),
      
    br(),
      
    column(12,  align = "center",
           h4("Input Text (English Only)"),
           tags$textarea(id="text", rows=5, cols=60, ""), 
           tags$head(tags$style(type="text/css", "#text { width: 70%}"))
                      ))),
    hr(),

  fluidRow(  
    column(12, align = "center",
                      h4("Top Suggested Next Word")),
    column(4, align = "right", uiOutput("word1")),
    column(4, align = "center", uiOutput("word2")),
    column(4, align = "left", uiOutput("word3"))

  ))
)
  