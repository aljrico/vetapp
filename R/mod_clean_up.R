# Housekeeping function to remove all temporary files when the app closes
    
#' @title Clean Up Module
#' @rdname mod_clean_up
#' @export
#' @keywords internal
    
mod_clean_up_server <- function(input, output, session){
  cancel.onSessionEnded <- session$onSessionEnded(function() {
    temporary_files <- list.files(pattern = ".feather", full.names = TRUE, recursive = TRUE)
    file.remove(temporary_files)
    shiny_log('Temporary files removed')
  })
}
    
## To be copied in the UI
# mod_clean_up_ui("clean_up_ui_1")
    
## To be copied in the server
# callModule(mod_clean_up_server, "clean_up_ui_1")
 
