#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)

# Define UI for application that draws a histogram
shinyUI(fluidPage(
  
  # Application title
  titlePanel("OnLine Life Insurance quotation"),
  
  # Sidebar with a slider input for number of bins 
  sidebarLayout(
    sidebarPanel(
       numericInput("age_input","Age:", value = 40, min = 18, max = 75, step = 1),
       checkboxInput("is_female","Check if you are female", value = FALSE),
       checkboxInput("is_smoker","Check if you are a smoker", value = TRUE),
       sliderInput("insured_val","Coverage selector", value = 250000, min = 50000, max = 1000000, step = 10000)
    ),
    
    # Show a plot of the generated distribution
    mainPanel(
       
       #h3("Calculation age"),
       #textOutput("calc_age_output"),
       h3("According to your data your annual insurance price is:"),
       textOutput("price_output"),
       h3("Main coverages prices."),
       plotOutput("distPlot")
       
    )
  )
))
