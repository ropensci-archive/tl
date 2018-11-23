
<!-- README.md is generated from README.Rmd. Please edit that file -->
tl
==

[![Travis build status](https://travis-ci.org/ropenscilabs/tl.svg?branch=master)](https://travis-ci.org/ropenscilabs/tl) [![Codecov test coverage](https://codecov.io/gh/ropenscilabs/tl/branch/master/graph/badge.svg)](https://codecov.io/gh/ropenscilabs/tl?branch=master)

The goal of tl is to provide an R equivalent to the tldr command line tool, a community-contributed set of quick reference guides for R functions.

Installation
------------

You can install the current version of tl from [github](https://github.com) with:

``` r
devtools::install_github("ropenscilabs/tl")
```

Example
-------

Here are some basic examples of how to use tl:

``` r
tl:::dr(stats::lm)

tl::dr(plot, graphics)
```
