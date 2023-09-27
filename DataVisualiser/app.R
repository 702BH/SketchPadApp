#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)

csv_file <- "www/samples.csv"

df <- read.csv(csv_file)


# Define UI for application that draws a histogram
ui <- fluidPage(
  titlePanel("Student Drawings"),
  selectInput("student", "Select a Student:", choices = unique(df$student)),
  uiOutput("image_container")
)

# Define server logic required to draw a histogram
server <- function(input, output) {
  
  output$image_container <- renderUI({
    
    selected_student <- input$student
    
    filtered_df <- df[df$student == selected_student, ]
    
    image_tags <- list()
    
    for(i in 1:5){
      image_title <- filtered_df$drawing[i]
      image_path <- paste0("img/",filtered_df$id[i] , ".png")
      
      image_tags[[i]] <- tags$div(
        tags$img(src = image_path, height = "300px"),
        tags$p(image_title, style = "text-align: center;")
      )
      
      
      
    }
    do.call(tagList, image_tags)
    
  })
  
}

# Run the application 
shinyApp(ui = ui, server = server)
