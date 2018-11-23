# mgcv::gam

fits a generalized additive model

- fits a model of y as an additive function of smoothed x1 and x2, in data frame df
`m <- gam(y ~ s(x1) + s(x2), data = df)`

- fits model of y as a tensor-product smooth (interaction) of x1 and x2
`m <- gam(y ~ te(x1, x2), data = df)`

- fits a binomial model using successes and failures as a smooth function of x
`m <- gam(cbind(successes, failures) ~ s(x), family = binomial, data = df)`

- print model
`summary(m)`
