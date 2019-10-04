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
#' @family input elements
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
