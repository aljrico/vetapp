#' @import shiny
app_ui <- function() {
  tagList(
    
    # Leave this function for adding external resources
    add_external_resources(),
    # List the first level UI elements here

    header <- shinydashboard::dashboardHeader(title = "VetApp"),
    sidebar <- shinydashboard::dashboardSidebar(sidebar_ui("sidebar")),
    body <- shinydashboard::dashboardBody(
      shinyjs::useShinyjs(),
      login_page_ui("login_page"),
      shinydashboard::tabItems(register_form_ui("register_form"))
    ),

    shinydashboard::dashboardPage(header, sidebar, body, skin = "black")
  )
}