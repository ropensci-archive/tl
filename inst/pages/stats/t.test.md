# stats::t.test

> performs one or two-sample t-tests on vectors of data.

- t.test of difference between two vectors x and y
  `t.test(x, y)`

- test of differences in y between groups on x in data.frame df
    `t.test(y ~ x, data = df)`

- As above, assumes variance equal
  `t.test(y ~ x, data = df, var.equal = TRUE)

- Specifies one-tailed test
  `t.test(x, y, alternative, "greater")`
