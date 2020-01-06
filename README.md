# getDTeval

[![Travis build status](https://travis-ci.org/Zoe0409/getDTeval.svg?branch=master)](https://travis-ci.org/Zoe0409/getDTeval)

## Overview  ##

Using the `get()` and `eval()` functions allows for more programmatic coding designs that enable greater flexibility and more dynamic computations. However, in data.table statements, `get()` and `eval()` reduce the efficiency of the method by performing work prior to data.table's optimized computations. **getDTeval** is useful in translateing `get()` and `eval()` statements more efficiently for improved runtime performance.

## Install the current release from CRAN: ##
`install.packages('getDTeval')`

## Install the development version from GitHub: ##
`devtools::install_github('Zoe0409/getDTeval')`

## Functions ##

**getDTeval** package has 2 main functions. The main purpose of developing the package is to translates `get()` and `eval()` statements more efficiently, which allows a user to both incorporate programmatic designs and while utilizing data.table's efficient processing routines.

 - **benchmark.getDTeval** performs a benchmarking experiment for data.table coding statements that use `get()` or `eval()` for programmatic designs.  The a) original statement is compared to b) passing the original statement through getDTeval and also to c) an optimized coding statement.  The results can demonstrate the overall improvement of using the coding translations offered by `getDTeval::getDTeval()`.

 - **getDTeval** offers a method of fully translating coding statements into an optimized coding statement.

## Applications and benefits ##

There are some major applications to the getDTeval package:

1). Combining programmatic coding designs with data.table's efficiency. Better utilizing `get()` and `eval()` without the trade-offs in performance.

2). Expanding on the use of `eval()` in data.table's calculations.

3). Expanding on the use of `eval()` in dplyr code.

## Examples ##

Import the data from formulaic package:

```r
dat = formulaic::snack.dat
```

The dat contains 25 features

```r 
names(dat)

 [1] "Age"                      
 [2] "Gender"                   
 [3] "Income"                   
 [4] "Region"                   
 [5] "Persona"                  
 [6] "Product"                  
 [7] "Awareness"                
 [8] "BP_For_Me_0_10"           
 [9] "BP_Fits_Budget_0_10"      
[10] "BP_Tastes_Great_0_10"     
[11] "BP_Good_To_Share_0_10"    
[12] "BP_Like_Logo_0_10"        
[13] "BP_Special_Occasions_0_10"
[14] "BP_Everyday_Snack_0_10"   
[15] "BP_Healthy_0_10"          
[16] "BP_Delicious_0_10"        
[17] "BP_Right_Amount_0_10"     
[18] "BP_Relaxing_0_10"         
[19] "Consideration"            
[20] "Consumption"              
[21] "Satisfaction"             
[22] "Advocacy"                 
[23] "Age Group"                
[24] "Income Group"             
[25] "User ID"
```

Set up some constant names:

```r
mean.age.name = "Mean Age"
age.name = "Age"
awareness.name = "Awareness"
gender.name = "Gender"
region.name = "Region"
```

**Use cases of benchmark.getDTeval function**

```r
sample.dat <- dat[sample(x = 1:.N, size = 10^6, replace = TRUE)]
the.statement <- "sample.dat[get(age.name) > 65, .(mean_awareness = mean(get(awareness.name))), keyby = c(eval(gender.name), region.name)]"
benchmark.getDTeval(the.statement = the.statement)
```

**Use cases of getDTeval function**

1. returning the translated coding statement:

```r
the.statement <- "dat[get(gender.name) == 'Female', mean(get(age.name)), keyby = region.name]"
getDTeval(the.statement = the.statement, return.as = "code")

[1] "dat[Gender == 'Female', mean(Age), keyby = region.name]"
```

2. returning the calculation result:

```r
getDTeval(the.statement = the.statement, return.as = "result")

      Region       V1
1:   Midwest 54.96774
2: Northeast 55.90385
3:     South 55.45205
4:      West 54.70430
```

3. returning the a list of the calculation result and the code:

```r
getDTeval(the.statement = the.statement, return.as = "all")

$result
      Region       V1
1:   Midwest 54.96774
2: Northeast 55.90385
3:     South 55.45205
4:      West 54.70430

$code
[1] "dat[Gender == 'Female', mean(Age), keyby = region.name]"
```

Please check out the vignettes file to see more examples and details.
