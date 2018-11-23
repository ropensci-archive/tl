
<!-- README.md is generated from README.Rmd. Please edit that file -->
tl
==

[![Travis build status](https://travis-ci.org/ropenscilabs/tl.svg?branch=master)](https://travis-ci.org/ropenscilabs/tl) [![Codecov test coverage](https://codecov.io/gh/ropenscilabs/tl/branch/master/graph/badge.svg)](https://codecov.io/gh/ropenscilabs/tl?branch=master)

The goal of tl is to provide an R equivalent to the tldr command line tool, a community-contributed set of quick reference guides for R functions.

> "Perfection is achieved not when there is nothing more to add, but when there is nothing left to take away" - Antoine de Saint-Exupéry

Briefly forgotten how a function works? Don't want to scroll through a long help file to find the example usage? You need tl;dr!

Installation
------------

You can install the current version of tl from [github](https://github.com) with:

``` r
devtools::install_github("ropenscilabs/tl")
```

Examples
--------

Here are some basic examples of how to use tl:

Use the `dr` function to find a help page

``` r
tl:::dr(lm)
#> stats::lm
#> 
#> fits a linear model
#> 
#> - fits a linear model of y dependent on x1 and x2  
#>   m1 <- lm(y ~ x1 + x2)  
#> 
#> - fits on data in data frame df  
#>   m1 <- lm(y ~ x1 + x2, data = df)  
#> 
#> - fits model of y on categorical variable xc  
#>   m1 <- lm(y ~ as.factor(xc), data = df)  
#> 
#> - print model  
#>   summary(m1)

tl::dr(tidyr::gather)
#> tidyr::gather
#> 
#> converts data from wide to long
#> 
#> - collapse columns x1 to x5 into 5 rows  
#>   gather(data, key = "key", value = "value", x1:x5)  
#> 
#> - collapse all columns  
#>   gather(data, key = "key", value = "value")
```

Page you are looking for does not exist? Use the `create_page` function to make one! Please follow the instructions to keep it brief.

``` r
tl::create_page(base::system.file)
```

Want to submit your new page to the `tl` package? Use the `submit_page` function to get instructions on how to add your help page to `tl`

``` r
tl::submit_page(base::system.file)
```
