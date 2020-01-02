#' getDTeval
#'
#' @description getDTeval offers a method of translating coding statements into more efficient versions for
#' improved runtime performance. Using the get() and eval() functions allows for more programmatic coding
#' designs that enable greater flexibility and more dynamic computations. However, in data.table statements,
#' get() and eval() reduce the efficiency of the method by performing work prior to data.table's optimized
#' computations. The getDTeval() function translates get() and eval() statements more efficiently.
#' This allows a user to both incorporate programmatic designs and while utilizing data.table's efficient
#' processing routines.
#'
#' @param the.statement a character value expressing a data.table calculation, such
#' as \code{dt[Age < 50, .(mean(Income)), by = "Region"]}. When the.statement includes variables that are
#' called by reference to a naming constant using get() or eval(), then these statements are translated into
#' the names of the variables for substantial improvements in speed.
#' @param return.as a character value stating what should be returned.  When return.as = "result", the
#'  calculation is evaluated.  When return.as = "code", then the translated coding statement is provided.
#'  When return.as = "all", then a list is returned that includes both the result and the code.
#' @param eval.type a character value stating whether the coding statement should be evaluated in its current
#'  form (eval.type = "as.is") or have its called to get() and eval() translated (eval.type = "optimized", the
#'  default setting).
#' @param envir The environment in which the calculation takes place, with the global environment .GlobalEnv
#' set as the default.
#' @param ... additional arguments to be passed.
#'
#' @source getDTeval::translate.fn.calls
#' @export
getDTeval <-
  function(the.statement,
           return.as = "result",
           eval.type = "optimized",
           envir = .GlobalEnv,
           ...) {
    if (!is.character(the.statement) &
        !is.expression(x = the.statement)) {
      return("Error:  the.statement must be a character or expression.")
    }

    the.statement <- as.character(the.statement)

    if (eval.type != "as.is") {
      pattern.get <- "get("
      pattern.eval <- "eval("

      num.get.calls <-
        length(grep(
          pattern = pattern.get,
          x = the.statement,
          fixed = TRUE
        ))
      num.eval.calls <-
        length(grep(
          pattern = pattern.eval,
          x = the.statement,
          fixed = TRUE
        ))

      if (num.get.calls > 0 | num.eval.calls > 0) {
        the.statement <-
          translate.fn.calls(
            the.statement = the.statement,
            function.name = pattern.get,
            envir = envir
          )

        the.statement <-
          translate.fn.calls(
            the.statement = the.statement,
            function.name = pattern.eval,
            envir = envir
          )
      }
    }

    if (return.as == "code") {
      return(the.statement)
    }
    if (return.as == "all") {
      return(list(
        result = eval(expr = parse(text = the.statement), envir = envir),
        code = the.statement
      ))
    }

    return(eval(expr = parse(text = the.statement), envir = envir))
  }
