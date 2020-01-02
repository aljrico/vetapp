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

#' Function that loops over the 'slots' of a given object. In the same fashion the 'Apply' function would work over the elements of a list.
#' @rdname slotApply
#' @param x object to be looped upoon
#' @param FUN custom function to be applied upon the object
#' @param ... further parameters to be carried over to the custom function

slotApply <- function(x,FUN,...){
  cl <- class(x)
  result <- list()
  for(i in slotNames(cl)){
    result[[i]] <- FUN(slot(x,i),...)
  }
  result
}