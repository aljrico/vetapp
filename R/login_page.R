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
          textInput(inputId = ns("userName"), label = "Username"),
          passwordInput(inputId = ns("passwd"), label = "Password"),
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

  # Define Variable
  Logged <- FALSE
  my_username <- "test"
  my_password <- "test"
  USER <- reactiveValues(Logged = Logged)

  # Check username and password
  observe({
    if (USER$Logged == FALSE) {
      if (!is.null(input$login_button)) {
        if (input$login_button > 0) {
          Username <- isolate(input$userName)
          Password <- isolate(input$passwd)
          is_username <- which(my_username == Username)
          id_password <- which(my_password == Password)
          if (length(is_username) > 0 & length(id_password) > 0) {
            if (is_username == id_password) {
              USER$Logged <- TRUE
            }
          }
        }
      }
    }
  })

  # React to 'username' and 'password'
  observeEvent(input$login_button, {
    if (USER$Logged) {
      shinyjs::show(id = "login_success")
      shinyjs::hide(id = "login_failure")
      shinyjs::show(id = "sidebar_menu")
      shinyjs::hide(id = "login_form")
      
      shinyWidgets::sendSweetAlert(
        session,
        title = 'Welcome Back!',
        type = 'success'
        
      )
      
    }
    if (!USER$Logged & !is.null(input$login_button)) shinyjs::show(id = "login_failure")
  })
}

## To be copied in the UI
# mod_login_page_ui("login_page_ui_1")

## To be copied in the server
# callModule(mod_login_page_server, "login_page_ui_1")
