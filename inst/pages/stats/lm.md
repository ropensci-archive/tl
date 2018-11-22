# stats::lm

> fits a linear model

- fits a linear model of y dependent on x1 and x2
  `m1 <- lm(y ~ x1 + x2)`

- fits on data in data frame df
  `m1 <- lm(y ~ x1 + x2, data = df)`

- fits model of y on categorical variable xc
  `m1 <- lm(y ~ as.factor(xc), data = df)`

- print model
  `summary(m1)`
