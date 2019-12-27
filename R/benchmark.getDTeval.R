#' benchmark.getDTeval
#'
#' @description Performs a benchmarking experiment for data.table coding statements that use get() or eval() for programmatic designs.  The a) original statement is compared to b) passing the original statement through getDTeval and also to c) an optimized coding statement.  The results can demonstrate the overall improvement of using the coding translations offered by getDTeval().
#'
#' @param the.statement a character value expressing a data.table calculation, such as \code{dt[Age < 50, .(mean(Income)), by = "Region"]}. When the.statement includes variables that are called by reference to a naming constant using get() or eval(), then these statements are translated into the names of the variables for substantial improvements in speed.
#' @param times The number of iterations to run the benchmarking experiment.
#' @param seed an integer value specifying the seed of the pseudorandom number generator.
#' @param envir The environment in which the calculation takes place, with the global environment .GlobalEnv set as the default.
#' @param ... additional arguments to be passed.
#'
#' @source getDTeval::getDTeval
#' @import data.table
#' @import microbenchmark
#' @import stats
#'
#' @export
benchmark.getDTeval <- function(the.statement, times = 30, seed = 47, envir = .GlobalEnv, ...){
  "." <- NULL
  "category" <- NULL
  "seconds" <- NULL

  set.seed(seed = seed)

  if(!is.character(the.statement) & !is.expression(x = the.statement)){
    return("Error:  the.statement must be a character or expression.")
  }

  translated.statement <- getDTeval(the.statement = the.statement, return.as = "code", envir = envir)

  times.translated <- data.table::as.data.table(microbenchmark::microbenchmark(eval(parse(text = translated.statement)), times = times))
  times.translated[, category := "optimized DT statement"]


  times.dt <- data.table::as.data.table(microbenchmark::microbenchmark(eval(parse(text = the.statement)), times = times))
  times.dt[, category := "original statement"]

  times.getDTeval <- data.table::as.data.table(microbenchmark::microbenchmark(getDTeval(the.statement = the.statement, return.as = "result", envir = envir), times = times))
  times.getDTeval[, category := "getDTeval"]


  res <- rbindlist(l = list(times.translated, times.dt, times.getDTeval), fill = TRUE)
  res[, seconds := stats::time / (10^9)]

  the.tab <- res[, .(metric = names(summary(seconds)), seconds = summary(seconds)), keyby = "category"]

  the.summary <- data.table::dcast.data.table(data = the.tab, formula = category ~ metric, value.var = "seconds")

  setcolorder(x = the.summary, neworder = c("category", "Min.", "1st Qu.", "Median", "Mean", "3rd Qu.", "Max."))

  setorderv(x = the.summary, cols = "Mean")

  return(the.summary)
}
