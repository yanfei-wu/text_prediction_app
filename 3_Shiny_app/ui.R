library(shiny)

shinyUI(fluidPage(
  
  theme = "bootstrap.css",
  img(src='header.jpg', height = 80, width = 1550),
  titlePanel("Text Predictor"),
  
  hr(),
  
  sidebarLayout(
    sidebarPanel(
      
      p("This is a text predictor. It can predict the next word you are trying to type based on the words you have already typed. It is designed based on n-gram model and it only supports English for now."),
      strong("Are you ready?"),
      
      textInput("text", label = h3("Please type something below"), value = "Enter here..."),
      
      p("It might take some time. Please be patient.", style = "color:blue"),
      
      hr(),
      h3("You have typed..."),
      fluidRow(column(12, verbatimTextOutput("value"))),
      
      hr(),
      h4("Inspired by"),
      img(src = "swiftkey.jpg", height = 100, width = 200)
    ),
    
    mainPanel(
      h1("Is this what you are going to type next?"), 
      br(),
      

      fluidRow(column(12, align = 'center', 
                      plotOutput("plot1"))),
      
      hr(),
      fluidRow(column(12, align="center", 
                     h4("Thank you for using this app!")))
    ))
  ))
  