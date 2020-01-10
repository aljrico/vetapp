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
  bs4Dash::bs4TabItem(
    tabName = "login",

    tagList(
      div(
        id = ns("login_box"),
        style = "width: 500px; max-width: 100%; margin: 0 auto; padding: 20px;",
        wellPanel(
          div(
            id = ns("login_form"),
            textInput(inputId = ns("username"), label = tagList(icon("user"), "Username")),
            passwordInput(inputId = ns("password"), label = tagList(icon("unlock-alt"), "Password")),
            shinyjs::hidden(
              div(
                id = ns("login_failure"),
                tags$p("Oops! Incorrect username or password!", style = "color: red; font-weight: 600;")
              )
            )
          ),
          shinyjs::hidden(
            div(
              id = ns("login_success"),
              tags$p("Yay! Welcome Back!", style = "color: green; font-weight: 600;")
            )
          ),
          br(),
          shinyWidgets::actionBttn(
            inputId = ns("login_button"),
            label = NULL,
            style = "material-circle",
            color = "default",
            icon = icon("sign-in-alt")
          )
        )
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

  check_login <- function(username, password, click) {

    # Default Status
    user_info <- list(logged = FALSE, username = NA, click = NA)

    # Retrieve Credentials
    my_username <- "test"
    my_password <- "test"

    # Find Username and Password in the Credentials
    is_username <- which(my_username == username)
    is_password <- which(my_password == password)

    if (length(is_username) > 0 & length(is_password) > 0) {
      if (is_username == is_password) {
        user_info$logged <- TRUE
        user_info$username <- username
      }
    }

    return(user_info)
  }
  ui_reaction_to_log_status <- function(logged, click) {
    if (!is.null(click)) {
      if (logged) {
        shinyjs::hide(id = "login_failure")
        shinyjs::hide(id = "login_form")
        shinyjs::hide(id = "login_button")
        shinyjs::show(id = "login_success")
        shinyjs::delay(2500, shinyjs::hide(id = "login_box", anim = TRUE, time = 0.1, animType = "fade"))
      } else {
        shinyjs::show(id = "login_failure")
        shinyjs::delay(1000, shinyjs::toggle(id = "login_failure", anim = TRUE, time = 1, animType = "fade"))
      }
    }
  }

  log_status <- eventReactive(input$login_button, {
    user_username <- input$username
    user_password <- input$password
    user_click <- input$login_button

    log <- check_login(username = user_username, password = user_password, click = user_click)
    ui_reaction_to_log_status(logged = log$logged, click = user_click)

    log
  })

  return(log_status)
}
