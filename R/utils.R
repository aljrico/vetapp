#' Pipe operator
#'
#' See \code{magrittr::\link[magrittr:pipe]{\%>\%}} for details.
#'
#' @name %>%
#' @rdname pipe
#' @keywords internal
#' @export
#' @importFrom magrittr %>%
#' @usage lhs \%>\% rhs
NULL

#' Log Action within shiny
#'
#'
#' @name shiny_log
#' @rdname shiny_log
#' @keywords internal
shiny_log <- function(message, env = ''){
  
  env <- toupper(env)
  
  log_message <- glue::glue("[{env}] -- {message}")
  message(log_message)
}