# base::regexec

pattern matching and replacement

- extract matches in string x based on pattern y
`strex <- regmatches(x, regexec(y, x)); strex("catbathat", "t(..)")`
