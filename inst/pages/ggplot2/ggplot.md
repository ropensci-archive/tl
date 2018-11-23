# ggplot2::ggplot

grammar of graphics plotting

- dot plot of y against x  
`ggplot(data, aes(x = x, y = y)) + geom_point()`

- line plot of y against x  
`ggplot(data, aes(x = x, y = y)) + geom_line()`

- apply minimal theme over existing plot `p`  
`p + theme_bw()`
