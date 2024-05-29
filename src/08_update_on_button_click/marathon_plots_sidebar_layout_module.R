marathon_plots_sidebar_layout_ui <- function(id, data_df) {
  tagList(
    sidebarLayout(
      sidebarPanel = sidebarPanel(
        sliderInput(
          inputId = NS(id, "min_year_slider"),
          label = "Marathon min year:",
          min = min(data_df$Year),
          max = max(data_df$Year),
          value = min(data_df$Year)
        ),
        sliderInput(
          inputId = NS(id, "max_year_slider"),
          label = "Marathon max year:",
          min = min(data_df$Year),
          max = max(data_df$Year),
          value = max(data_df$Year)
        ),
        selectInput(
          inputId = NS(id, "category_select"),
          label = "Category:",
          choices = unique(data_df$Category)
        ),
        actionButton(
          inputId = NS(id, "filter_update_button"),
          label = "Update"
        )
      ),
      mainPanel = mainPanel(
        plotOutput(outputId = NS(id, "time_distribution_plot")),
        plotOutput(outputId = NS(id, "time_scatter_plot"))
      )
    )
  )
}

marathon_plots_sidebar_layout_server <- function(id, data_df) {
  moduleServer(id, function(input, output, session) {
    filtered_data_reactive <- eventReactive(input$filter_update_button, {
      data_df %>%
        filter(Year >= input$min_year_slider, 
               Year <= input$max_year_slider,
               Category == input$category_select)
    })
    
    output$time_distribution_plot <- renderPlot({
      filtered_data_reactive() %>%
        ggplot(aes(x = time_in_minutes)) +
        geom_histogram() +
        theme_minimal()
    })
    
    output$time_scatter_plot <- renderPlot({
      filtered_data_reactive() %>%
        ggplot(aes(x = Year, y = time_in_minutes)) +
        geom_point() +
        theme_minimal()
    })
  })
}