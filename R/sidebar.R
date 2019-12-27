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
        shinydashboard::sidebarMenu(
          id = ns("tabs"),
          shinydashboard::menuItem(
            "Menu item 1",
            icon = icon("calendar"),
            tabName = "tab_one"
          ),
          shinydashboard::menuItem(
            "Menu item 2",
            icon = icon("globe"),
            tabName = ns("tab_two")
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
