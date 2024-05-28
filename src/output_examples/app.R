library(shiny)

ui <- fluidPage(
  fluidRow(
    column(
      4,
      plotOutput(outputId = "plot_output")
    ),
    column(
      4,
      textOutput(outputId = "text_output")
    ),
    column(
      4,
      tableOutput(outputId = "table_output")
    )
  )
)

server <- function(input, output) {
  output$plot_output <- renderPlot({
    data <- runif(100)
    hist(data)
  })
  
  output$text_output <- renderText({
    "Example text output"
  })
  
  output$table_output <- renderTable({
    data.frame(a = c(1,2,3,4), b = c(5,6,7,8))
  })
}

# Run the application 
shinyApp(ui = ui, server = server)
