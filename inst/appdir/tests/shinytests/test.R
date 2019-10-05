app <- ShinyDriver$new("../../")
app$snapshotInit("test")

app$setInputs(reset_expression = "click")
app$setInputs(highlightExpression = "[1-2]{1}[7-8]{1}[0-9]{2}")
app$setInputs(reset_test_cases = "click")
app$setInputs(highlightTestCases = "1750
18th century", allowInputNoBinding_ = TRUE)
app$snapshot()
