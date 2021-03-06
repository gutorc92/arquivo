get_env <- function(){
  if(exists("files_env", envir = globalenv())){
    files_env <- get("files_env", envir = globalenv())
  }else{
    files_env <<- new.env(parent = emptyenv())
  }
  files_env
}

check_variable <- function(var_name){
  files_env <- get_env()
  if(exists(var_name, envir = files_env)){
    return(TRUE)
  }
  return(FALSE)
}

set_variable <- function(var_name, var){
  files_env <- get_env()
  files_env[[var_name]] <- var
}

#' @export
set_bases_file <- function(bases_file){
  files_env <- get_env()
  files_env$bases_file <- bases_file
}

get_bases_file <- function(){
  files_env <- get_env()
  if(check_variable("bases_file")){
    if(file.exists(files_env$bases_file)){
      return(files_env$bases_file)
    }else{
      rm(bases_file, envir = files_env)
      retrun(get_bases_file())
    }
  }else if(file.exists(system.file("extdata","bases.csv"))){
    return(system.file("extdata","bases.csv"))
  }else{
    warning("Loding file bases from package arquivo IPEA")
    return(system.file("extdata","bases.csv", package = "arquivoIPEA"))
  }
}



read_bases <- function(force_read = F){
  if(check_variable("bases") == F | force_read == T){
    bases_file <- get_bases_file()
    bases <- read.csv2(bases_file, skip = 2, stringsAsFactors = F)
    set_variable("bases", bases)
  }else{
    return(get("bases", envir = get_env()))
  }
  bases
}

read_servers <- function(force_read = F){
  if(check_variable("servers") == F | force_read == T){
    bases_file <- get_bases_file()
    servers <- read.csv2(bases_file, nrows = 1, stringsAsFactors = F)
    set_variable("servers", servers)
  }else{
    return(get("servers", envir = get_env()))
  }
  servers
}

#' @export
set_server <- function(server_name){
  servers <- read_servers()
  if(!(server_name %in% colnames(servers))){
    stop(paste(server_name,"does not exist", sep = " "))
  }
  n <- match("server2", colnames(servers))
  server <- servers[1, n]
  set_variable("server", server)
}

#' @export
#'
get_file_input <- function(base){
  bases <- read_bases()
  if("file_name_input" %in% colnames(bases)){
    return(file.path(bases[bases == base, "dir_input"], bases[bases == base, "file_name_input"]))
  }else{
    return(file.path(bases[bases == base, "dir_input"], bases[bases == base, "file_name"]))
  }
}

#' @export
#'
get_file_output <- function(base){
  bases <- read_bases()
  if("file_name_output" %in% colnames(bases)){
    return(file.path(bases[bases == base, "dir_output"], bases[bases == base, "file_name_output"]))
  }else{
    return(file.path(bases[bases == base, "dir_output"], bases[bases == base, "file_name"]))
  }
}


