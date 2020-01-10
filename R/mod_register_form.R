# Module UI

#' @title   mod_register_form_ui and mod_register_form_server
#' @description  A shiny Module.
#'
#' @param id shiny id
#' @param input internal
#' @param output internal
#' @param session internal
#'
#' @rdname mod_register_form
#'
#' @keywords internal
#' @export
#' @importFrom shiny NS tagList
register_form_ui <- function(id) {
  ns <- NS(id)

  animals_list <- c(
    "Dog",
    "Cat",
    "Hamster",
    "Ferret",
    "Fish"
  )

  bs4Dash::bs4TabItem(
    tabName = "register_form",
    h1("Register Form"),
    bs4Dash::box(
      title = strong("New Pet!"),
      status = "primary",
      side = 'left',
      textInput(
        inputId = ns("pet_name"),
        label = "Pet's Name",
        placeholder = "Felix"
      ),
      shinyWidgets::pickerInput(
        inputId = ns("pet_owner_name"),
        label = "Select Owner",
        choices = LETTERS,
        multiple = FALSE
      ),
      selectInput(
        inputId = ns("pet_animal"),
        label = "What animal?",
        choices = animals_list %>% base::sort()
      ),
      textInput(
        inputId = ns("pet_weight"),
        label = "Weight (Kg)",
        placeholder = 10
      ),
      textInput(
        inputId = ns("pet_age"),
        label = "Age",
        placeholder = "2 weeks / 6 months / 1 year / 3.5 years"
      ),
      shinyWidgets::actionBttn(
        inputId = ns("pet_submit_form"),
        label = NULL,
        style = "material-circle",
        color = "primary",
        icon = icon("save")
      )
    ),
    bs4Dash::box(
      title = strong("New Owner!"),
      status = "success",
      side = 'right',
      textInput(
        inputId = ns("owner_first_name"),
        label = "Full name",
        placeholder = "James"
      ),
      textInput(
        inputId = ns("owner_last_name"),
        label = "Full name",
        placeholder = "Smith"
      ),

      hr(),
      h4("Contact Details"),
      textInput(
        inputId = ns("owner_phone_number"),
        label = "Contact Number",
        placeholder = "+44 0111 222 444"
      ),
      textInput(
        inputId = ns("owner_email"),
        label = "email",
        placeholder = "asdf@gmail.com"
      ),

      hr(),
      h4("Address Details"),
      textInput(
        inputId = ns("owner_street_name"),
        label = "Street Name",
        placeholder = "221B Baker Sreet"
      ),
      textInput(
        inputId = ns("owner_post_code"),
        label = "Post Code",
        placeholder = "NW1 6XE"
      ),
      textInput(
        inputId = ns("owner_city"),
        label = "City",
        placeholder = "London"
      ),
      shinyWidgets::actionBttn(
        inputId = ns("submit_form"),
        label = NULL,
        style = "material-circle",
        color = "success",
        icon = icon("save")
      )
    )
  )
}

# Module Server

#' @rdname mod_register_form
#' @export
#' @keywords internal

register_form_server <- function(input, output, session) {
  ns <- session$ns

  observeEvent(input[["pet_submit_form"]], {
    message("Button pushed")

    shinyWidgets::sendSweetAlert(
      session = session,
      title = "New Pet Submitted Correctly!",
      text = "",
      type = "success"
    )
  })

  observeEvent(input[["submit_form"]], {
    waiter::show_waiter(
      waiter::spin_folding_cube()
    )

    new_log <-
      data.frame(
        first_name = input[["owner_first_name"]],
        last_name = input[["owner_last_name"]],
        street_name = input[["owner_street_name"]],
        post_code = input[["owner_post_code"]],
        email = input[["owner_email"]],
        phone_number = input[["owner_phone_number"]] %>% stringr::str_remove_all(" ")
      )
    owner_files <- class_owner_files$new()
    owner_files$add_log(new_log)
    owner_files$upload_data()

    waiter::hide_waiter()

    shinyWidgets::sendSweetAlert(
      session = session,
      title = "Data Submitted Successfully!",
      text = "",
      type = "success"
    )

    message("Owner Data Uploaded")
  })
}

## To be copied in the UI
# mod_register_form_ui("register_form_ui_1")

## To be copied in the server
# callModule(mod_register_form_server, "register_form_ui_1")
