get_env <- function(){
  if(exists("files_env", envir = globalenv())){
    files_env <- get("files_env", envir = globalenv())
  }else{
    files_env <<- new.env(parent = emptyenv())
  }
  files_env
}

set_bases_file <- function(bases_file){
  files_env <- get_env()
  files_env$bases_files <- bases_file
}

get_bases_file <- function(){
  files_env <- get_env()
  if(exists("bases_files", envir = files_env) & file.exists(files_env$bases_files)){
    return(files_env$bases_files)
  }else if(file.exists(system.file("extdata","bases.csv"))){
    return(system.file("extdata","bases.csv"))
  }else{
    warning("Loding file bases from package arquivo IPEA")
    return(system.file("extdata","bases.csv", package = "arquivoIPEA"))
  }
}

read_bases <- function(){
  
}