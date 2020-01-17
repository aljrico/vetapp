#' @import shiny
app_server <- function(input, output, session) {

  # List the first level callModules here
  callModule(module = login_page_server, id = "login_page") -> log_status
  callModule(module = sidebar_server, id = "sidebar", log_status = log_status)
  callModule(module = clients_database_server, "clients_database")
  callModule(module = register_form_server, id = "register_form")
  callModule(module = mod_clean_up_server, id = 'clean_up')
}
