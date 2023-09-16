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

labels <- c("car", "fish", "house", "tree", "bicycle",
            "guitar", "pencil", "clock")


# Define UI for application that draws a histogram
ui <- fluidPage(
  tags$head(tags$script(src = "message-handler.js")),
  titlePanel("Data Creator"),
  fluidRow(
    textInput("student", label = "", placeholder = "Type your name"),
    actionButton("advanceBtn", label = "Advance")
    
  ),
  fluidRow(id = "sketchrow", style = "visibility: hidden",
    sketchpadOutput("test")
  )
  
    
)
  

# Define server logic required to draw a histogram
server <- function(input, output, session) {
  output$test <- renderSketchpad({
    sketchpad("test")
  })
  
  observeEvent(input$advanceBtn, {
    session$sendCustomMessage(type = 'testmessage',
                              message = list(name = input$student,
                                             item = sample(labels, 1)))
  })
  
  sketch_info <- reactive({
    list(
      name = input$student
    )
  })
  
  observe({
    print(sketch_info())
  })

}

# Run the application 
shinyApp(ui = ui, server = server)
