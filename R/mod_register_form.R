# Module UI
  
#' @title   mod_register_form_ui and mod_register_form_server
#' @description  A shiny Module.
#'
#' @param id shiny id
#' @param input internal
#' @param output internal
#' @param session internal
#'
#' @rdname mod_register_form
#'
#' @keywords internal
#' @export 
#' @importFrom shiny NS tagList 
register_form_ui <- function(id){
  ns <- NS(id)
  shinydashboard::tabItem(
    tabName = 'register_form',
          h2('Register Form')
          )
  
}
    
# Module Server
    
#' @rdname mod_register_form
#' @export
#' @keywords internal
    
register_form_server <- function(input, output, session){
  ns <- session$ns
}
    
## To be copied in the UI
# mod_register_form_ui("register_form_ui_1")
    
## To be copied in the server
# callModule(mod_register_form_server, "register_form_ui_1")
 
