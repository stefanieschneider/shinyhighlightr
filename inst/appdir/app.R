library(shinyhighlightr)

ui <- fluidPage(
  textMarkupInput(
    inputId = "highlight", labels = c("Expression", "Test Cases"),
    placeholder = c("Define Expression", "Define Test Cases"),
    values = list(
      "[1-2]{1}[0-9]{3}",
      c(
        "19th century", "1855",
        "between 1905 and 1910"
      )
    )
  ),
  div(
    class = "form-group shiny-input-container",
    actionButton("reset_expression", "Reset Expression"),
    actionButton("reset_test_cases", "Reset Test Cases")
  )
)

server <- function(input, output, session) {
  observeEvent(input$reset_expression, {
    updateTextMarkupInput(
      session, inputId = "highlight",
      labels = c("Expression Changed", NA),
      values = list("[1-2]{1}[7-8]{1}[0-9]{2}", NA),
      placeholders = c("Define Expression Changed", NA)
    )
  })

  observeEvent(input$reset_test_cases, {
    updateTextMarkupInput(
      session, inputId = "highlight",
      labels = c(NA, "Test Cases Changed"),
      values = list(NA, c("1750", "18th century")),
      placeholders = c(NA, "Define Test Cases Changed")
    )
  })
}

shinyApp(ui, server)
