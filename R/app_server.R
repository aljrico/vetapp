#' @import shiny
app_server <- function(input, output,session) {
  # List the first level callModules here
  callModule(login_page_server, "login_page")
}
