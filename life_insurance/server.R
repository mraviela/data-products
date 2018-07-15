#
# This is the server logic of a Shiny web application. You can run the 
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)
library(caret)

# Define server logic required to draw a histogram
shinyServer(function(input, output) {
  options(scipen=999)
  #Values for age
  age <- c(18,18,18,18,
           20,20,20,20,
           25,25,25,25,
           30,30,30,30,
           35,35,35,35,
           40,40,40,40,
           45,45,45,45,
           50,50,50,50,
           55,55,55,55,
           60,60,60,60,
           65,65,65,65,
           70,70,70,70,
           75,75,75,75)
  
  #Values for coverage in dollars
  coverage <- c(50000,250000,500000,1000000,
                100000,250000,500000,1000000,
                100000,250000,500000,1000000,
                100000,250000,500000,1000000,
                100000,250000,500000,1000000,
                100000,250000,750000,1000000,
                100000,250000,750000,1000000,
                100000,250000,750000,1000000,
                100000,250000,750000,1000000,
                100000,250000,750000,1000000,
                100000,250000,750000,1000000,
                100000,250000,750000,1000000,
                100000,250000,750000,1000000)
  
  #Values for premium price
  premium <- c(128,227,437,480,
               184,254,444,490,
               188,256,450,510,
               196,266,474,540,
               210,291,499,630,
               237,380,687,890,
               303,596,1025,1340,
               427,891,1782,2350,
               659,1459,3185,4220,
               1088,2361,5892,7830,
               1958,4496,13146,16634,
               3660,7656,22505,29943,
               4974,12238,29712,38673)
  
  
  #Creating the dataset with insurance quotes   
  insurance.data <- data.frame(age,coverage,premium)
  
  #Model creation
  
  model <- glm(premium ~ age + coverage + I(age * log(coverage)) + I(age^2 * coverage), data=insurance.data, family = Gamma(link="log"))

  #for debuging porposes
  output$calc_age_output <- reactive({
    female_factor <- input$is_female * 3
    smoker_factor <- input$is_smoker * 3
    calc_age <- input$age_input - female_factor + smoker_factor
    calc_age
  })
  
  #To get out the predicted price
  output$price_output <- reactive({
    calc_age <- input$age_input - (input$is_female * 3) + (input$is_smoker * 3)
    result  <- exp(predict(model, newdata = data.frame(age=calc_age,coverage=input$insured_val)))
    #print(result)
    as.integer(result)
  })
  
  #To get out the prices plot 
  output$distPlot <- renderPlot({
    calc_age <- input$age_input - (input$is_female * 3) + (input$is_smoker * 3)
    ages <- c(calc_age,calc_age,calc_age,calc_age,calc_age,calc_age,calc_age,calc_age,calc_age,calc_age,calc_age)
    coverages <- c(50000,100000,200000,300000,400000,500000,600000,700000,800000,900000,1000000)
    quote_data <- data.frame(age=ages,coverage=coverages)
    prices <- exp(predict(model, newdata = quote_data))
    
    plot(x = coverages, y = prices, xlab="Coverages available to you")
    
  })
  
})
