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
    textInput("student", label = "", placeholder = "Type your name"),
    textOutput("instructions"),
    fluidRow(
      actionButton("advanceBtn", label = "Advance"),
      actionButton("nextBtn", label = "Next", disabled = "true"),
      actionButton("saveBtn", label = "Save", disabled = "true")
    ),
    
    
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
    
    new_index_r <- index_r() + 1
    index_r(new_index_r)
    output$instructions <- renderText({
      paste0("please draw a ", labels[index_r()])
    })

  })
  
  sketch_info <- reactive({
    list(
      name = input$student
    )
  })
  
  sketch_data <- reactive({
    req(input$sketchData)
    list(data = input$sketchData)
  })
  
  observe({
    req(input$sketchData)
    #print(sketch_info())
    print(sketch_data())
  })
  
  labels <- c("car", "fish", "house", "tree", "bicycle",
              "guitar", "pencil", "clock")
  
  
  index_r <- reactiveVal(0)
  
  observeEvent(input$nextBtn, {
    new_index_r <- index_r() + 1
    if(new_index_r <= length(labels)){
      index_r(new_index_r)
      
      output$instructions <- renderText({
        paste0("please draw a ", labels[index_r()])
      })
      
    }else{
      session$sendCustomMessage(type = 'nextbutton', message = "")
      output$instructions <- renderText({
        paste0("please save your drawings")
      })
      
    }
    
  })
  

}

# Run the application 
shinyApp(ui = ui, server = server)
