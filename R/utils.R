#' @note taken from shiny:::shinyInputLabel
shinyInputLabel <- function(inputId, label = NULL) {
  tags$label(
    label, class = "control-label", `for` = inputId,
    class = if (is.null(label)) "shiny-label-null"
  )
}

#' @note taken from shiny:::utils
dropNulls <- function(x) {
  x[!vapply(x, is.null, FUN.VALUE = logical(1))]
}
