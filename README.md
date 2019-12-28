# getDTeval

[![Travis build status](https://travis-ci.org/Zoe0409/getDTeval.svg?branch=master)](https://travis-ci.org/Zoe0409/getDTeval)

## Overview  ##

Using the get() and eval() functions allows for more programmatic coding designs that enable greater flexibility and more dynamic computations. However, in data.table statements, get() and eval() reduce the efficiency of the method by performing work prior to data.table's optimized computations. **getDTeval** is useful in translateing get() and eval() statements more efficiently for improved runtime performance.

## Install the current release from CRAN: ##
`install.packages('getDTeval')`

## Install the development version from GitHub: ##
`devtools::install_github('Zoe0409/getDTeval')`

## Functions ##

**getDTeval** package has 2 main functions. The main purpose of developing the package is to translates get() and eval() statements more efficiently, which allows a user to both incorporate programmatic designs and while utilizing data.table's efficient processing routines.

 - **benchmark.getDTeval** performs a benchmarking experiment for data.table coding statements that use get() or eval() for programmatic designs.  The a) original statement is compared to b) passing the original statement through getDTeval and also to c) an optimized coding statement.  The results can demonstrate the overall improvement of using the coding translations offered by getDTeval().

 - **getDTeval** offers a method of fully translating coding statements into an optimized coding statement.

## Applications and benefits ##

There are some major applications to the getDTeval package:

1). Combining programmatic coding designs with data.table's efficiency. Better utilizing get() and eval() without the trade-offs in performance.

2). Expanding on the use of eval() in data.table's calculations.

3). Expanding on the use of eval() in dplyr code.

Please check out the vignettes file to see more examples and details.
