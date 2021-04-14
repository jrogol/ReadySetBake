createStructure <- function(...) {
  # An empty vector to contain existing folders
  exists <- c()
  
  # An empty vector to contain the folders to create
  created <- c()
  
  # Turn arguments into a list
  l <- list(...)
  
  # Set the default folders to create
  if (length(l) == 0) {
    l <-
      list("Data",
           "Markdown",
           "Output",
           "Reports",
           "SQL",
           "R",
           "Snippets",
           "Assets")
  }
  
  # Iterate over the list of folders to create. If it doesn't exist, create it.
  for (i in l) {
    if (!dir.exists(i)) {
      dir.create(i)
      created <- c(created, i)
    } else {
      exists <- c(exists, i)
    }
  }
  
  # Print the names of existing and/or newly created folders
  if (length(exists) > 0) {
    message(sprintf(
      "Folder(s) already exist for: %s",
      purrr::reduce(exists, paste, sep = ", ")
    ))
  }
  
  if (length(created) > 0) {
    message(sprintf(
      "Created folder(s) for: %s",
      purrr::reduce(created, paste, sep = ", ")
    ))
    
  }
}
