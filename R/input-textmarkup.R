#' @title Create a Text Markup Input Control
#'
#' @description Create a text markup input control to highlight patterns in
#' text values. Two input fields are created: one to specify the expression
#' to be marked; another where this expression is marked in unstructured
#' text values, e.g., test cases for a regular expression.
#'
#' @param inputId The \code{input} slot that will be used to access the values.
#' @param labels Display labels for the control, or \code{NULL} for no labels.
#' @param values A list of vectors of initial values.
#' @param width The width of the input, e.g., \code{'100\%'}; see
#' \link{validateCssUnit}.
#' @param height The height of the input, e.g., \code{'400px'}; see
#' \link{validateCssUnit}.
#' @param placeholders A vector of character strings giving the user a hint
#' as to what can be entered into the control. Internet Explorer 8 and 9 do
#' not support this option.
#'
#' @return A text markup input control that can be added to a UI definition.
#'
#' @seealso \link{updateTextMarkupInput}
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
#'     )
#'   )
#'
#'   server <- function(input, output, session) {
#'
#'   }
#'
#'   shinyApp(ui, server)
#' }
#'
#' @importFrom shiny restoreInput validateCssUnit
#' @importFrom htmltools div tags attachDependencies htmlDependency
#'
#' @export
textMarkupInput <- function(inputId, labels, values = list("", ""),
    width = NULL, height = NULL, placeholders = NULL) {
  inputIdExpression <- paste0(inputId, "Expression")
  inputIdTestCases <- paste0(inputId, "TestCases")

  if (length(values[[2]]) > 1)
    values[[2]] <- paste(values[[2]], collapse = "\n")

  values[[1]] <- restoreInput(inputIdExpression, values[[1]])
  values[[2]] <- restoreInput(inputIdTestCases, values[[2]])

  style <- paste(
    if (!is.null(width))
      paste0("width: ",  validateCssUnit(width),  ";"),
    if (!is.null(height))
      paste0("height: ", validateCssUnit(height), ";"),
    "resize: vertical;"
  )

  if (length(style) == 0) style <- NULL

  if (length(placeholders) == 0) placeholders <- c("", "")
  if (length(placeholders) == 1) placeholders <- c(placeholders, "")

  div_container <- div(
    class = "form-group shiny-input-container codemirror-editor",
    id = inputId, style = paste(
      if (!is.null(width))
        paste0("width: ", validateCssUnit(width), ";")
    ),
    shinyInputLabel(inputIdExpression, labels[1]),
    tags$input(
      id = inputIdExpression, class = "form-control", type = "text",
      placeholder = placeholders[1], value = values[[1]]),
    shinyInputLabel(inputIdTestCases, labels[2]),
    tags$textarea(
      id = inputIdTestCases, class = "form-control", type = "text",
      placeholder = placeholders[2], style = style, values[[2]]
    )
  )

  attachDependencies(
    div_container, htmlDependency(
      name = "codemirror", version = "5.49.0",
      package = "shinyhighlightr", src = "assets",
      script = c(
        "js/srl-bundle.js", "js/codemirror.js",
        "js/codemirror-bindings.js", "js/addon/placeholder.js"
      ),
      stylesheet = "css/codemirror.css"
    ), append = TRUE
  )
}
