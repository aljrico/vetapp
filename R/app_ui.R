#' @import shiny
app_ui <- function() {


  # List the first level UI elements here

  sidebar <- bs4Dash::bs4DashSidebar(
    skin = "dark",
    status = "primary",
    title = "VetApp",
    brandColor = "primary",
    src = "https://cdn3.iconfinder.com/data/icons/veterinary-pet-care-bicolor/96/vet_prescription-2-512.png",
    elevation = 3,
    opacity = 0.8,
    sidebar_ui("sidebar")
  )

  body <- bs4Dash::bs4DashBody(
    # Leave this function for adding external resources
    add_external_resources(),
    shinyjs::useShinyjs(),
    waiter::use_waiter(),

    bs4Dash::bs4TabItems(
      login_page_ui("login_page"),
      register_form_ui("register_form")
    )
  )
  
  bs4Dash::bs4DashPage(
    loading_duration = 5,
    old_school = FALSE,
    sidebar_min = TRUE,
    sidebar_collapsed = TRUE,
    controlbar_collapsed = FALSE,
    controlbar_overlay = TRUE,
    title = "VetApp",
    sidebar = sidebar,
    body = body
  )
}
