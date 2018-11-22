# tidyr::gather

converts data from wide to long

- collapse columns x1 to x5 into 5 rows  
`gather(data, key = "key", value = "value", x1:x5)`

- collapse all columns  
`gather(data, key = "key", value = "value")`
