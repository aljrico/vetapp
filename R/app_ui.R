#' @import shiny
app_ui <- function() {
  tagList(
    # Leave this function for adding external resources
    golem_add_external_resources(),
    # List the first level UI elements here 
    
    header <- shinydashboard::dashboardHeader(title = 'VetApp'),
    sidebar <- shinydashboard::dashboardSidebar(sidebar_ui("sidebar")),
    body <- shinydashboard::dashboardBody(
      shinyjs::useShinyjs(),
      login_page_ui("login_page")
    ),
    
    shinydashboard::dashboardPage(header, sidebar, body, skin = "black")
  )
}

#' @import shiny
golem_add_external_resources <- function(){
  
  addResourcePath(
    'www', system.file('app/www', package = 'vetapp')
  )
 
  tags$head(
    golem::activate_js(),
    golem::favicon(),
    tags$link(rel="stylesheet", type="text/css", href="inst/app/www/custom.css")
    
    # Add here all the external resources
    # If you have a custom.css in the inst/app/www
    # Or for example, you can add shinyalert::useShinyalert() here
    #tags$link(rel="stylesheet", type="text/css", href="www/custom.css")
  )
}
