#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)

# Define UI for application that draws a histogram
ui <- fluidPage(
  tags$script(src = "sketchpad.js"),
  uiOutput("canvasOutput")

)

# Define server logic required to draw a histogram
server <- function(input, output) {
  output$canvasOutput <- renderUI({
    tags$canvas(id = "canavs", width = 400, height = 400)
  })
  
  
  observeEvent(input$canvas_draw, {
    print(input$canvas_draw)
  })
}

# Run the application 
shinyApp(ui = ui, server = server)
