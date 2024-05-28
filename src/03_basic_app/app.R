

library(shiny)
library(dplyr)
library(ggplot2)

reactlog::reactlog_enable()
marathon_df <- readRDS("../../data/marathon_winners.rds")
marathon_df <- marathon_df %>% 
  mutate(time_in_minutes = as.numeric(Time) / 60)

ui <- fluidPage(
  titlePanel("London Marathon Winner Data Exploration"),
  sidebarLayout(sidebarPanel = sidebarPanel(
                  sliderInput(
                    inputId = "min_year_slider",
                    label = "Marathon min year:",
                    min = min(marathon_df$Year),
                    max = max(marathon_df$Year),
                    value = min(marathon_df$Year)
                  ),
                  sliderInput(
                    inputId = "max_year_slider",
                    label = "Marathon max year:",
                    min = min(marathon_df$Year),
                    max = max(marathon_df$Year),
                    value = max(marathon_df$Year)
                  ),
                  selectInput(
                    inputId = "category_select",
                    label = "Category:",
                    choices = unique(marathon_df$Category)
                  )
                ),
                mainPanel = mainPanel(
                  plotOutput(outputId = "time_distribution_plot")
                )
  )
)

server <- function(input, output, session) {
  output$time_distribution_plot <- renderPlot({
    filtered_data <- marathon_df %>%
      filter(Year >= input$min_year_slider, 
             Year <= input$max_year_slider,
             Category == input$category_select)
    filtered_data %>%
      ggplot(aes(x = time_in_minutes)) +
        geom_histogram() +
        theme_minimal()
  })
}

# Run the application 
shinyApp(ui = ui, server = server)
