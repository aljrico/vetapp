#' Run the Shiny Application
#'
#'
#'See \code{shiny::\link[shiny:shinyApp]{shinyApp}} for details.
#'
#' @export
#' @importFrom shiny shinyApp
#' @importFrom golem with_golem_options
#' @rdname run_app
#' 
#' @param ... Carries over the list of arguments available in golem::with_golem_options
run_app <- function(...) {
  with_golem_options(
    app = shinyApp(ui = app_ui, server = app_server), 
    golem_opts = list()
  )
}
