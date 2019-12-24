#' @import shiny
app_server <- function(input, output, session) {

  # List the first level callModules here
  callModule(module = login_page_server, id = "login_page") -> log_status
  callModule(module = sidebar_server, id = "sidebar", log_status = log_status)
}
