

library(shiny)
library(dplyr)
library(ggplot2)

source("marathon_plots_sidebar_layout_module.R")

reactlog::reactlog_enable()
marathon_df <- readRDS("../../data/marathon_winners.rds")
marathon_df <- marathon_df %>% 
  mutate(time_in_minutes = as.numeric(Time) / 60)

ui <- fluidPage(
  titlePanel("London Marathon Winner Data Exploration"),
  fluidRow(
    marathon_plots_sidebar_layout_ui(id = "marathon_plots_1", data_df = marathon_df),
    marathon_plots_sidebar_layout_ui(id = "marathon_plots_2", data_df = marathon_df)
  )
)

server <- function(input, output, session) {
  marathon_plots_sidebar_layout_server(id = "marathon_plots_1", data_df = marathon_df)
  marathon_plots_sidebar_layout_server(id = "marathon_plots_2", data_df = marathon_df)
}

# Run the application 
shinyApp(ui = ui, server = server)
