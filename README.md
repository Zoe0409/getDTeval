# getDTeval

[![Travis build status](https://travis-ci.org/Zoe0409/getDTeval.svg?branch=master)](https://travis-ci.org/Zoe0409/getDTeval)
[![Codecov test coverage](https://codecov.io/gh/Zoe0409/getDTeval/branch/master/graph/badge.svg)](https://codecov.io/gh/Zoe0409/getDTeval?branch=master)

## Overview  ##

Using the get() and eval() functions allows for more programmatic coding designs that enable greater flexibility and more dynamic computations. However, in data.table statements, get() and eval() reduce the efficiency of the method by performing work prior to data.table's optimized computations. **getDTeval** is useful in translateing get() and eval() statements more efficiently for improved runtime performance..

## Install the current release from CRAN: ##
`install.packages('getDTeval')`

## Install the development version from GitHub: ##
`devtools::install_github('Zoe0409/getDTeval')`

## Usage ##

**getDTeval** package has 2 main functions. The main purpose of developing the package is to translates get() and eval() statements more efficiently, which allows a user to both incorporate programmatic designs and while utilizing data.table's efficient processing routines.

 - **benchmark.getDTeval** performs a benchmarking experiment for data.table coding statements that use get() or eval() for programmatic designs.  The a) original statement is compared to b) passing the original statement through getDTeval and also to c) an optimized coding statement.  The results can demonstrate the overall improvement of using the coding translations offered by getDTeval().

 - **getDTeval** offers a method of fully translating coding statements into an optimized coding statement.
