# Module UI

#' @title   mod_clients_database_ui and mod_clients_database_server
#' @description  A shiny Module.
#'
#' @param id shiny id
#' @param input internal
#' @param output internal
#' @param session internal
#'
#' @rdname mod_clients_database
#'
#' @keywords internal
#' @export
#' @importFrom shiny NS tagList
clients_database_ui <- function(id) {
  ns <- NS(id)

  bs4Dash::bs4TabItem(
    tabName = "clients_database",
    column(
      width = 12,
      align = "center",
      div(
        id = ns("all_owners_ui"),
        bs4Dash::bs4Box(
          width = 10,
          DT::DTOutput(ns("clients_database"))
        )
      ),
      shinyjs::hidden(div(
        id = ns("single_owner_ui"),
        bs4Dash::bs4Box(
          # shinyWidgets::actionBttn(
          #   inputId = ns("back_button"),
          #   label = NULL,
          #   style = "material-circle",
          #   color = "default",
          #   icon = icon("arrow-alt-circle-left")
          # ),
          tags$button(
            id = ns("back_button"),
            class = "action-button bttn bttn-material-circle",
            icon("arrow-alt-circle-left")
          ),
          width = 10
        )
      ))
    )
  )
}

# Module Server

#' @rdname mod_clients_database
#' @export
#' @keywords internal

clients_database_server <- function(input, output, session) {
  ns <- session$ns


  owner_files <- class_owner_files$new()
  clients_database <- owner_files$data

  output[["clients_database"]] <-
    DT::renderDT(
      DT::datatable(
        clients_database,
        selection = "single",
        filter = list(position = "top", clear = FALSE),
        options = list(
          search = list(regex = TRUE, caseInsensitive = FALSE, search = ""),
          pageLength = 15,
          lengthChange = FALSE
        )
      )
    )
  
  output[['back_arrow']] <-
    renderUI({
      tags$img(src = "www/img/arrow.svg", class = "clickimg", 'data-value' = 'arrow.svg')
    })


  observeEvent(input$clients_database_row_last_clicked, {
    row_index <- input$clients_database_row_last_clicked
    print(tibble::as_tibble(clients_database)[row_index, ])

    shinyjs::toggle(id = "all_owners_ui", anim = TRUE, animType = "fade", time = 0.1)
    shinyjs::toggle(id = "single_owner_ui", anim = TRUE, animType = "fade", time = 0.1)
  })

  observeEvent(input$back_button, {
    shinyjs::toggle(id = "all_owners_ui", anim = TRUE, animType = "fade", time = 0.1)
    shinyjs::toggle(id = "single_owner_ui", anim = TRUE, animType = "fade", time = 0.1)
  })
}

## To be copied in the UI
# mod_clients_database_ui("clients_database_ui_1")

## To be copied in the server
# callModule(mod_clients_database_server, "clients_database_ui_1")
