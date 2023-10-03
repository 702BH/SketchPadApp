# Feature extraction

library(jsonlite)

input_folder <- "dataset/json"

json_files <- list.files(input_folder, pattern = "*.json", 
                         full.names = TRUE)

test <- fromJSON(json_files[1])

length(test)

class(test)

t2 <- do.call(rbind, test)

t2

class(t2)

length(t2)

nrow(t2)

get_path_count <- function(path){
  return(length(path))
}

get_point_count <- function(path){
  return(nrow(do.call(rbind, path)))
}



csv_file <- "samples.csv"

df <- read.csv(csv_file)

head(df)


input_folder <- "dataset/json"

json_files <- list.files(input_folder, pattern = "*.json", 
                         full.names = TRUE)

combined_data <- list()

extract_values <- function(row){
  
  id <- row["id"]
  label <- row["drawing"]
  student_name <- row["student"]
  student_id <- row["session"]
  return(list(ID = id, Label = label, Name = student_name,
              student_id = student_id))
  
}



for(sample in df[1,]){
  json_file_name <- paste0(sample["id"], ".json")
  
  if(json_file_name %in% basename(json_files)){
    
    json_data <- fromJSON(paste0(input_folder, "/", json_file_name))
    
    t <- get_path_count(json_data)
    print(t)

  }else{
    cat(paste("JSON file", json_file_name, "not found.\n"))
  }
  
  
}
