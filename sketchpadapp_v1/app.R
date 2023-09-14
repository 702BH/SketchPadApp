#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
devtools::load_all("~/GitHub/SketchPadApp/sketchpad")


# Define UI for application that draws a histogram
ui <- fluidPage(
  tags$head(tags$script(src = "message-handler.js")),
  titlePanel("Data Creator"),
  fluidRow(
    textInput("student", label = "Type your name", placeholder = "Type your name"),
    actionButton("advanceBtn", label = "Advance")
    
  ),
  conditionalPanel(
    condition = "input.student == ",
    sketchpadOutput("test"))
  

)

# Define server logic required to draw a histogram
server <- function(input, output, session) {
  output$test <- renderSketchpad({
    sketchpad("test")
  })
  
  observeEvent(input$advanceBtn, {
    session$sendCustomMessage(type = 'testmessage',
                              message = input$student)
  })
  
  

}

# Run the application 
shinyApp(ui = ui, server = server)
