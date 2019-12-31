#' translate.fn.calls
#'
#' @description Internal function
#'
#' @param the.statement a character value expressing a data.table calculation, such as \code{dt[Age < 50, .(mean(Income)), by = "Region"]}. When the.statement includes variables that are called by reference to a naming constant using get() or eval(), then these statements are translated into the names of the variables for substantial improvements in speed.
#' @param function.name translation basis either "get(" or "eval(" to perform the corresponding function. Set as "get(" as default.
#' @param envir The environment in which the calculation takes place, with the global environment .GlobalEnv set as the default.
#' @param ... additional arguments to be passed.
#'
#' @import formulaic

translate.fn.calls <-
  function(the.statement,
           function.name = "get(",
           envir = .GlobalEnv,
           ...) {
    fn.chars <- strsplit(x = function.name, split = "")[[1]]
    all.chars <- strsplit(x = the.statement, split = "")[[1]]

    first.chars <- which(all.chars == fn.chars[1])

    the.begin <-
      first.chars[as.logical(lapply(
        X = first.chars,
        FUN = function(x) {
          return(paste(all.chars[x:(x + length(fn.chars) - 1)], collapse = "") == function.name)
        }
      ))]

    len <- length(the.begin)
    if (len > 0) {
      for (i in 1:length(the.begin)) {
        the.end <-
          function.ending.point(all.chars = all.chars, beginning.index = the.begin[i], ...)
        the.call <-
          paste(all.chars[the.begin[i]:the.end], collapse = "")
        arg <-
          trimws(
            x = gsub(
              pattern = function.name,
              replacement = "eval(",
              x = the.call,
              fixed = TRUE
            ),
            which = "both"
          )

        evaluated.arg <-
          formulaic::add.backtick(x = eval(expr = parse(text = arg), envir = envir),
                                  include.backtick = "as.needed")
        if (function.name == "eval(") {
          evaluated.arg <- sprintf("'%s'", evaluated.arg)
        }
        all.chars[the.begin[i]:the.end] <- ""
        all.chars[the.begin[i]] <- evaluated.arg
      }
    }
    the.statement <- paste(all.chars, collapse = "")
    return(the.statement)
  }
