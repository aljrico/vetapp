# Module UI

#' @title   Sidebar Module
#' @description  A shiny Module.
#'
#' @param id shiny id
#' @param input internal
#' @param output internal
#' @param session internal
#'
#' @rdname sidebar
#'
#' @keywords internal
#' @export
#' @importFrom shiny NS tagList
sidebar_ui <- function(id) {
  ns <- NS(id)
  tagList(
    shinyjs::hidden(
      div(
        id = ns("my_sidebar"),
        bs4Dash::bs4SidebarMenu(
          id = ns("tabs"),
          bs4Dash::bs4SidebarMenuItem(
            "Home",
            icon = "home",
            tabName = "home"
          ),
          bs4Dash::bs4SidebarMenuItem(
            "Register Form",
            icon = "edit",
            tabName = "register_form"
          )
        )
      )
    )
  )
}

# Module Server

#' @rdname sidebar
#' @export
#' @keywords internal

sidebar_server <- function(input, output, session, log_status) {
  ns <- session$ns
  observeEvent(log_status()$click, {
    if (!is.null(log_status()$logged)) {
      if (log_status()$logged) {
        shinyjs::show(id = "my_sidebar", anim = TRUE, animType = "slide", time = 0.2)
      }
    }
  })
}

## To be copied in the UI
# mod_sidebar_ui("sidebar_ui_1")

## To be copied in the server
# callModule(mod_sidebar_server, "sidebar_ui_1")
