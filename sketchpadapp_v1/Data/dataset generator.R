#dataset generator
library(jsonlite)

input_folder <- "Raw"

output_folder <- "C:/Users/house/Documents/GitHub/SketchPadApp/sketchpadapp_v1/Data/dataset/json"

json_files <- list.files(input_folder, pattern = "*.json", 
                         full.names = TRUE)

index <- 1

for (json_file in json_files){
  
  json_data <- fromJSON(json_file)
  
  drawings <- json_data$drawings
  
  for(drawing_type in names(drawings)) {
    
    drawing_data <- drawings[[drawing_type]]
    
    output_file <- file.path(output_folder, paste0(index, ".json"))
    
    myfile <- toJSON(drawing_data, pretty = TRUE, auto_unbox = TRUE, force = TRUE)
    
    write(myfile, output_file)
    
    cat("Extracted and saved:", output_file, "\n")
    
    index <- index + 1
    
  }
  
}


# draw
library(ggplot2)

img_folder <- "C:/Users/house/Documents/GitHub/SketchPadApp/sketchpadapp_v1/Data/dataset/img"

json_files_processed <- list.files(
  output_folder,
  pattern = "*.json",
  full.names = TRUE
  
)
json_files_num <- json_files_processed[order(as.numeric(gsub("[^0-9]", "", json_files_processed)))]

json_files_num[33]

td <- fromJSON(json_files_num[33])

str(td)


td[[1]]

str(td)

tdf <- do.call(rbind, td)
colnames(tdf) <- c("x", "y")

tdf2 <- as.data.frame(tdf)

tdf2$x

canvas_width <- 400
canvas_height <- 400

all_points <- do.call(rbind, lapply(td, as.data.frame))

all_points$


p2 <- ggplot(all_points, aes(x = V1, y = V2, 
                             group = rep(seq_along(td), sapply(td, nrow)))) +
  geom_path(size = 1.5, lineend = "round", linejoin = "round") +
  xlim(0, canvas_width) +
  ylim(canvas_height, 0) + 
  theme_void() 

p2

ggsave("plottest.png", p2 , 
       width = canvas_width, height = canvas_height, 
       dpi = 100, units = "px")


p <- ggplot(td_1, aes(x,y)) + 
  geom_path(aes(td_2$x, td_2$y)) +
  xlim(0, canvas_width) +
  ylim(canvas_height, 0) + 
  theme_void()


p

image(tdf)



ggsave("C:/Users/house/Documents/GitHub/SketchPadApp/sketchpadapp_v1/Data/dataset/img/test.png",
       p,
       width = 6,
       height = 6,
       dpi = 300,
       angle = 90)


create_plot_from_json <- function(json_file){
  json_data <- fromJSON(json_file)
  
  if(is.list(json_data)){
    
    all_points_j <- do.call(rbind, lapply(json_data, as.data.frame))
    
    p_j <- ggplot(all_points_j, aes(x = V1, y = V2, 
                                    group = rep(seq_along(json_data), sapply(json_data, nrow)))) +
      geom_path(size = 1.5, lineend = "round", linejoin = "round") +
      xlim(0, canvas_width) +
      ylim(canvas_height, 0) + 
      theme_void() 
    
  } else{
    all_points_j <- as.data.frame(matrix(unlist(json_data), ncol = 2, byrow = TRUE))
    colnames(all_points_j) <- c("V1", "V2")
    
    p_j <- ggplot(all_points_j, aes(x = V1, y = V2)) +
      geom_path(size = 1.5, lineend = "round", linejoin = "round") +
      xlim(0, canvas_width) +
      ylim(canvas_height, 0) + 
      theme_void()
  }
  
  return(p_j)
  
  
}


index <- 1

for(json_file in json_files_num){
  
  plot <- create_plot_from_json(json_file)
  
  png_file <- file.path(img_folder, 
                        paste0(index, ".png"))
  
  ggsave(png_file, plot, width = canvas_width, height = canvas_height, 
         dpi = 100, units = "px")
  cat("Saved plot as:", png_file, "\n")
  
  index <- index + 1
  
}




# creating the sample.json file (not sure why we need it)
input_folder <- "Raw"

output_folder <- "C:/Users/house/Documents/GitHub/SketchPadApp/sketchpadapp_v1/Data/js_objects/smaples.js"

id <- 1

combined_data <- list()

json_files_s <- list.files(input_folder, pattern = "*.json", 
                         full.names = TRUE)



test <- json_files_s[1]

tjs <- fromJSON(test)

session_value <- tjs$session



student_value <- tjs$student

for(label in names(tjs$drawings)) {
  
  drawing_data <- list(
    session = session_value,
    student = student_value,
    drawing = label,
    id = id
  )
  
  combined_data <- c(combined_data, list(drawing_data))
  
  
}

combined_data

output_json <- toJSON(combined_data, auto_unbox = TRUE)

output_json

for(json_file in json_files_s){
  
  json_data <- fromJSON(json_file)
  
  session_value <- json_data$session[1]
  student_value <- json_data$student[1]
  
  for(label in names(json_data$drawings)) {
    
    drawing_data <- list(
      session = session_value,
      student = student_value,
      drawing = label,
      id = id
    )
    
    combined_data <- c(combined_data, list(drawing_data))
    
    id <- id + 1
    
    
    
  }


  
}

output_json <- toJSON(combined_data, auto_unbox = TRUE)

writeLines(paste("const samples = ", output_json, ";"), output_folder)



# saving as CSV
combined_df <- do.call(rbind, combined_data)

write.csv(combined_df, "samples.csv", row.names = FALSE)

