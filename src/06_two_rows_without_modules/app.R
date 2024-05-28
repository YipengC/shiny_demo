

library(shiny)
library(dplyr)
library(ggplot2)

reactlog::reactlog_enable()
marathon_df <- readRDS("../../data/marathon_winners.rds")
marathon_df <- marathon_df %>% 
  mutate(time_in_minutes = as.numeric(Time) / 60)

ui <- fluidPage(
  titlePanel("London Marathon Winner Data Exploration"),
  fluidRow(
    sidebarLayout(
      sidebarPanel = sidebarPanel(
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
        plotOutput(outputId = "time_distribution_plot"),
        plotOutput(outputId = "time_scatter_plot")
      )
    ),
    sidebarLayout(
      sidebarPanel = sidebarPanel(
        sliderInput(
          inputId = "min_year_slider_2",
          label = "Marathon min year:",
          min = min(marathon_df$Year),
          max = max(marathon_df$Year),
          value = min(marathon_df$Year)
        ),
        sliderInput(
          inputId = "max_year_slider_2",
          label = "Marathon max year:",
          min = min(marathon_df$Year),
          max = max(marathon_df$Year),
          value = max(marathon_df$Year)
        ),
        selectInput(
          inputId = "category_select_2",
          label = "Category:",
          choices = unique(marathon_df$Category)
        )
      ),
      mainPanel = mainPanel(
        plotOutput(outputId = "time_distribution_plot_2"),
        plotOutput(outputId = "time_scatter_plot_2")
      )
    )
  )
)

server <- function(input, output, session) {
  filtered_data_reactive <- reactive({
    marathon_df %>%
      filter(Year >= input$min_year_slider, 
             Year <= input$max_year_slider,
             Category == input$category_select)
  })
  
  filtered_data_reactive_2 <- reactive({
    marathon_df %>%
      filter(Year >= input$min_year_slider_2, 
             Year <= input$max_year_slider_2,
             Category == input$category_select_2)
  })
  
  output$time_distribution_plot <- renderPlot({
    # filtered_data <- marathon_df %>%
    #   filter(Year >= input$min_year_slider, 
    #          Year <= input$max_year_slider,
    #          Category == input$category_select)
    filtered_data_reactive() %>%
      ggplot(aes(x = time_in_minutes)) +
        geom_histogram() +
        theme_minimal()
  })
  
  output$time_scatter_plot <- renderPlot({
    # filtered_data <- marathon_df %>%
    #   filter(Year >= input$min_year_slider, 
    #          Year <= input$max_year_slider,
    #          Category == input$category_select)
    filtered_data_reactive() %>%
      ggplot(aes(x = Year, y = time_in_minutes)) +
      geom_point() +
      theme_minimal()
  })
  
  output$time_distribution_plot_2 <- renderPlot({
    # filtered_data <- marathon_df %>%
    #   filter(Year >= input$min_year_slider, 
    #          Year <= input$max_year_slider,
    #          Category == input$category_select)
    filtered_data_reactive_2() %>%
      ggplot(aes(x = time_in_minutes)) +
      geom_histogram() +
      theme_minimal()
  })
  
  output$time_scatter_plot_2 <- renderPlot({
    # filtered_data <- marathon_df %>%
    #   filter(Year >= input$min_year_slider, 
    #          Year <= input$max_year_slider,
    #          Category == input$category_select)
    filtered_data_reactive_2() %>%
      ggplot(aes(x = Year, y = time_in_minutes)) +
      geom_point() +
      theme_minimal()
  })
}

# Run the application 
shinyApp(ui = ui, server = server)
