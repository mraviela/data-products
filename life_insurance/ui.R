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
shinyUI(navbarPage("OnLine Life Insurance quotation",
                   tabPanel("Quotations",br(),
                            sidebarPanel(
                              numericInput("age_input","Age:", value = 40, min = 18, max = 75, step = 1),
                              checkboxInput("is_female","Check if you are female", value = FALSE),
                              checkboxInput("is_smoker","Check if you are a smoker", value = TRUE),
                              sliderInput("insured_val","Coverage selector", value = 250000, min = 50000, max = 1000000, step = 10000)
                            ),
                            mainPanel(
                              h3("According to your data your annual insurance price is:"),
                              textOutput("price_output"),
                              h3("Main coverages prices."),
                              plotOutput("distPlot")
                            )
                   ),
                    tabPanel("About", 
                                     h3("Description"),
                                     h5("This application calculate the price for life insurance."),
                                     h4("Elements"),
                                     h5("Age - Your age"),
                                     h5("Female - Check if you are a female"),
                                     h5("Smoker - Check if you are a smoker"),
                                     h5("Coverage selector - Select the desired coverage"))
                            )
          )

  
  