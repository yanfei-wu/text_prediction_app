library(shiny)

source("predictor.R")

shinyServer(function(input, output) {
  
  output$value <- renderPrint({ input$text })
  
  output$plot1 <- renderPlot({
    
    predict <- predict(input$text)
    
    par(mar = c(0,0,0,0))
  
    plot(c(0, 1), c(0, 1), ann = F, bty = 'n', type = 'n', xaxt = 'n', yaxt = 'n')
    
    text(x = 0.5, y = 0.5, paste(predict$last[1], "\n",
                                 predict$last[2], "\n",
                                 predict$last[3], "\n"),
         cex = 4, col = "orange") 
    
    })


})
