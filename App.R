library(shiny)
library(datasets)
library(ggplot2)
mpgData <- mtcars
ui <- fluidPage(
  titlePanel("IE 421 Homework- Lal Akın"),
  
  sidebarLayout(
    
    sidebarPanel(
      
      selectInput("variable", "Variable:",
                  c("Cylinders" = "cyl",
                    "Transmission" = "am",
                    "Gears" = "gear")),
      checkboxInput("outliers", "Show outliers", TRUE)
      
    ),
    
    mainPanel(
      
      h3(textOutput("caption")),
      
      plotOutput("mpgPlot")
      
    )
  )
)

server <- function(input, output) {
  
  formulaText <- reactive({
    paste("mpg ~", input$variable)
  })
  
  output$caption <- renderText({
    formulaText()
  })
  

  output$mpgPlot <- renderPlot({
  ggplot(data=mpgData, aes(x=mpg)) + 
      geom_histogram(binwidth=5,col= "mistyrose", 
                     fill="thistle4",alpha = 1) + facet_wrap(~mpgData[[input$variable]], nrow = 3)
  })
  
}
shinyApp(ui, server)








