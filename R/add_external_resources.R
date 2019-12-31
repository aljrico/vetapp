#' @import shiny
add_external_resources <- function() {
  addResourcePath(
    "www", system.file("app/www", package = "vetapp")
  )

  tags$head(
    golem::activate_js(),
    golem::favicon(),
    tags$link(rel = "stylesheet", type = "text/css", href = "inst/app/www/custom.css"),
    add_external_js(),
    add_external_css()
  )
}

add_external_js <- function() {
  js_files <- as.list(list.files(recursive = TRUE, pattern = "*.js"))
  do.call(includeScript, js_files)
}

add_external_css <- function() {
  css_files <- as.list(list.files(recursive = TRUE, pattern = "*.css"))
  do.call(includeCSS, css_files)
}
