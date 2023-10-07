# Feature extraction

library(jsonlite)

input_folder <- "dataset/json"

json_files <- list.files(input_folder, pattern = "*.json", 
                         full.names = TRUE)

json_files

test <- fromJSON(json_files[1])

length(test)

class(test)

t2 <- do.call(rbind, test)

t2

class(t2)

length(t2)

nrow(t2)

## REAL
get_path_count <- function(path){
  return(length(path))
}

## REAL
get_point_count <- function(path){
  if(is.list(path)){
    return(nrow(do.call(rbind, path)))
  }else{
    return(length(path))
  }
  
}


# testing functions
test_file <- fromJSON("dataset/json/32.json")

get_point_count(test_file)


head(df)




extract_values <- function(row){
  
  id <- row["id"]
  label <- row["drawing"]
  student_name <- row["student"]
  student_id <- row["session"]
  return(list(ID = id, Label = label, Name = student_name,
              student_id = student_id))
  
}




### REAL

# refactor to apply
csv_file <- "samples.csv"

df <- read.csv(csv_file)

input_folder <- "dataset/json"

json_files <- list.files(input_folder, pattern = "*.json", 
                         full.names = TRUE)

combined_data <- list()


for(i in 1:nrow(df)){
  json_file_name <- paste0(df$id[i], ".json")
  print(json_file_name)
  
  if(json_file_name %in% basename(json_files)){
    
    json_data <- fromJSON(paste0(input_folder, "/", json_file_name))
    
    values <- list(
      path_count = get_path_count(json_data),
      point_count = get_point_count(json_data),
      id = df$id[i],
      label = df$drawing[i],
      s_name = df$student[i],
      s_id = df$session[i]
    )
    
    
    combined_data[[i]] <- values

  }else{
    cat(paste("JSON file", json_file_name, "not found.\n"))
  }
  
  
}

combined_data

combined_df <- do.call(rbind, combined_data)

head(combined_df)

write.csv(combined_df, "features.csv", row.names = FALSE)
