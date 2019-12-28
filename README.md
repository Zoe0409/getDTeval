# getDTeval

[![Travis build status](https://travis-ci.org/Zoe0409/getDTeval.svg?branch=master)](https://travis-ci.org/Zoe0409/getDTeval)
[![Codecov test coverage](https://codecov.io/gh/Zoe0409/getDTeval/branch/master/graph/badge.svg)](https://codecov.io/gh/Zoe0409/getDTeval?branch=master)

## Overview  ##

Many newcomers to the data.table package are overwhelmed by the unique syntax . **DTwrappers** is useful in applying data.table with wrapper functions while still maintaining the data.table execution speed. 

## Install the current release from CRAN: ##
`install.packages('getDTeval')`

## Install the development version from GitHub: ##
`devtools::install_github('Zoe0409/getDTeval')`

## Usage ##

**DTwrappers** package has 9 main functions. The main purpose of developing the package is to help users to apply data.table package faster and more convenient.

 - **create.filter.expression** automatically creates filter expressions from a provided a character value, logical value, or expression stating the logical operations.

 - **dt.count** is a wrapper to computations like `dat[the.filter, .N, keyby = grouping.variables]` that counts the number of rows that meets the qualification such as filter and the by (grouping variables).
 
 - **dt.filter** subsets the data corresponding to the filtering statement.
 
 - **dt.select** provides more flexibility in selecting the rows to include such as first.k, last.k, or specific row by setting up the parameters.
 
 - **df.define.variable** is a wrapper to computations like `dat[, new.variable := new.values]` that allows users to re-define the variables so that users have freedom to set the variable name and the the values. The values could be either expression, direct code(data.table format), or character.
 
 - **dt.first.k.rows** returns the first K number of rows from the given data frame based on the variables and the grouping varaibles statement.
 
 - **dt.last.k.rows** returns the last K number of rows from the given data frame based on the variables and the grouping varaibles statement.
 
 - **dt.lapply** is a wrapper to calculations like `dat[the.filter, lapply(X = .SD, FUN = function.name), .SDcols = the.variables, keyby = grouping.variables]` by specifying:
 
    - the.filter (character or expression) for the i step
    
    - the.variables (character vector of column names) for the .SDcols
    
    - the.functions (character vector of function names) for the functions to apply
    
    - grouping.variables (character vector of column names) for the variables to group by.
 
 - **dt.remove.variables** is a wrapper to computations like `dat[, this.variable := NULL]` that removes selected columns from dat
