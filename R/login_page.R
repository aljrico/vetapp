# Module UI

#' @title   mod_login_page_ui and mod_login_page_server
#' @description  A shiny Module.
#'
#' @param id shiny id
#' @param input internal
#' @param output internal
#' @param session internal
#'
#' @rdname login_page
#'
#' @keywords internal
#' @export
#' @importFrom shiny NS tagList
login_page_ui <- function(id) {
  ns <- NS(id)
  tagList(
    shinyjs::hidden(
      div(
        id = ns("login_form"),
        shinydashboard::box(
          textInput(inputId = ns("username"), label = "Username"),
          passwordInput(inputId = ns("password"), label = "Password"),
          br(),
          shinyWidgets::actionBttn(
            inputId = ns("login_button"),
            label = NULL,
            style = "material-circle",
            color = "default",
            icon = icon("sign-in-alt")
          ),
          soldHeader = TRUE,
          width = 4
        )
      )
    ),

    shinyjs::hidden(
      div(
        id = ns("login_failure"),
        h5(paste0("Sorry, username and/or password do not check."))
      )
    )
  )
}

# Module Server

#' @rdname login_page
#' @export
#' @keywords internal

login_page_server <- function(input, output, session) {
  ns <- session$ns

  # Show Login Form
  shinyjs::show(id = "login_form")
  
  check_login <- function(username, password, click){
    
    # Default Status
    user_info <- list(logged = FALSE, username = NA, click = NA)
    
    # Retrieve Credentials
    my_username <- "test"
    my_password <- "test"
    
    # Find Username and Password in the Credentials
    is_username <- which(my_username == username)
    is_password <- which(my_password == password)
    
    if(length(is_username) > 0 & length(is_password) > 0){
      if(is_username == is_password){
        user_info$logged <- TRUE
        user_info$username <- username
      }
    }
    
    return(user_info)
  }
  ui_reaction_to_log_status <- function(logged, click){
    if(!is.null(click)){
      if (logged) {
        shinyjs::hide(id = "login_failure")
        shinyjs::hide(id = "login_form")
      }else{
        shinyjs::show(id = "login_failure")
      }
    }

  }
  
  log_status <- eventReactive(input$login_button, {

      user_username <- input$username
      user_password <- input$password
      user_click    <- input$login_button

    log <- check_login(username = user_username, password = user_password, click = user_click)
    ui_reaction_to_log_status(logged = log$logged, click = user_click)
    
    log
  })
  
  return(log_status)
}

## To be copied in the UI
# mod_login_page_ui("login_page_ui_1")

## To be copied in the server
# callModule(mod_login_page_server, "login_page_ui_1")
