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





