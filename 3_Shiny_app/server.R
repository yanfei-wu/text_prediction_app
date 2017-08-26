library(shiny)

source("predictor.R")

shinyServer(function(input, output, clientData, session) {
  
  observe({
    if (nchar(as.character(input$text)) > 0) {
      predict <- predict(input$text)
      
      # show three buttons containing the top 3 predicted word
      output$word1 <- renderUI({
        if(is.na(predict[1])) {
        word1 = "..."
      }
      word1 = predict[1]
      actionButton("word1", word1)
    })
      
      output$word2 <- renderUI({
        if(is.na(predict[2])) {
          word2 = "..."
        }
        word2 = predict[2]
        actionButton("word2", word2)
      })
      
      output$word3 <- renderUI({
        if(is.na(predict[3])) {
          word3 = "..."
        }
        word3 = predict[3]
        actionButton("word3", word3)
      })
      
      # update text input based on user selection
      w <- c(input$word1, input$word2, input$word3)
      
      for (i in seq_along(w)) {
        if (w[i] == 1) {
        isolate ({
          updateTextInput(session, "text",
                          value = paste(input$text, predict[i]))
        })
        }
      }
    } 
  })
  
})  