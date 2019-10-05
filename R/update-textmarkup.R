#' @title Change the value of a text markup input on the client
#'
#' @description Change the value of a text markup input on the client.
#'
#' @param session The \code{session} object passed to function given to
#' \code{shinyServer}.
#' @param inputId The id of the input object.
#' @param labels The labels to set for the input object.
#' @param values the values to set for the input object.
#' @param placeholders The placeholders to set for the input object.
#'
#' @seealso \link{textMarkupInput}
#'
#' @examples
#' ## Only run examples in interactive R sessions
#' if (interactive()) {
#'   library(shiny)
#'   library(shinyhighlightr)
#'
#'   ui <- fluidPage(
#'     textMarkupInput(
#'       inputId = "highlight", labels = c("Expression", "Test Cases"),
#'       placeholder = c("Define Expression", "Define Test Cases"),
#'       values = list(
#'         "[1-2]{1}[0-9]{3}",
#'         c(
#'           "19th century", "1855",
#'           "between 1905 and 1910"
#'         )
#'       )
#'     ),
#'
#'     div(
#'       class = "form-group shiny-input-container",
#'       actionButton("reset_expression", "Reset Expression"),
#'       actionButton("reset_test_cases", "Reset Test Cases")
#'     )
#'   )
#'
#'   server <- function(input, output, session) {
#'     observeEvent(input$reset_expression, {
#'       updateTextMarkupInput(
#'         session, inputId = "highlight",
#'         labels = c("Expression Changed", NA),
#'         values = list("[1-2]{1}[7-8]{1}[0-9]{2}", NA),
#'         placeholders = c("Define Expression Changed", NA)
#'       )
#'     })
#'
#'     observeEvent(input$reset_test_cases, {
#'       updateTextMarkupInput(
#'         session, inputId = "highlight",
#'         labels = c(NA, "Test Cases Changed"),
#'         values = list(NA, c("1750", "18th century")),
#'         placeholders = c(NA, "Define Test Cases Changed")
#'       )
#'     })
#'   }
#'
#'   shinyApp(ui, server)
#' }
#'
#' @export
updateTextMarkupInput <- function(session, inputId, labels = NULL,
    values = NULL, placeholders = NULL) {
  if (!is.null(values) && length(values[[2]]) > 1)
    values[[2]] <- paste(values[[2]], collapse = "\n")

  message <- dropNulls(
    list(
      labels = labels, values = values,
      placeholders = placeholders
    )
  )

  session$sendInputMessage(inputId, message)
}
