#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)

ui <- fluidPage(
  fluidRow(
    column(3,
           sliderInput(inputId = "slider_input",
                       label = "Example sliderInput",
                       min = 0,
                       max = 10,
                       value = 5
           )
    ),
    column(3,
           numericInput(inputId = "numeric_input",
                        label = "Example numericInput",
                        min = 0,
                        max = 10,
                        value = 5
           )
    ),
    column(3,
           textInput(inputId = "text_input",
                     label = "Example textInput"
           )
    ),
    column(3,
           passwordInput(inputId = "password_input",
                         label = "Example passwordInput"
           )
    )
  ),
  fluidRow(
    column(3,
           dateInput(inputId = "date_input",
                     label = "Example dateInput"
           )
    ),
    column(3,
           dateRangeInput(inputId = "date_range_input",
                          label = "Example dateRangeInput"
           )
    ),
    column(3,
           selectInput(inputId = "select_input",
                       label = "Example selectInput",
                       choices = c("Choice 1",
                                   "Choice 2",
                                   "Choice 3")
           )
    ),
    column(3,
           radioButtons(inputId = "radioButtons",
                        label = "Example radioButtons",
                        choices = c("Choice 1",
                                    "Choice 2",
                                    "Choice 3"))
    )
  )
)

server <- function(input, output) {

}

# Run the application 
shinyApp(ui = ui, server = server)
