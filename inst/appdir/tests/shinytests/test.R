app <- ShinyDriver$new("../../")
app$snapshotInit("test")

app$setInputs(reset_expression = "click")
app$setInputs(highlightExpression = "[1-2]{1}[7-8]{1}[0-9]{2}")
app$setInputs(highlightTestCases = "19th century
1855
between 1905 and 1910", allowInputNoBinding_ = TRUE)
app$snapshot()

app$setInputs(reset_test_cases = "click")
app$setInputs(highlightExpression = "[1-2]{1}[7-8]{1}[0-9]{2}")
app$setInputs(highlightTestCases = "1750
18th century", allowInputNoBinding_ = TRUE)
app$snapshot()
