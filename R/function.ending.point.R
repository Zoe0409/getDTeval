#' function.ending.point
#'
#' @description Internal function
#'
#' @param all.chars TBD
#' @param beginning.index TBD
#' @param ... Not used at this time.

function.ending.point <- function(all.chars, beginning.index, ...) {
  len <- length(all.chars)
  open.parens <- cumsum(x = all.chars[beginning.index:len] == "(")
  closed.parens <- cumsum(x = all.chars[beginning.index:len] == ")")

  ending.index <-
    beginning.index - 1 + min(which(open.parens > 0 &
                                      open.parens == closed.parens))
  return(ending.index)
}
