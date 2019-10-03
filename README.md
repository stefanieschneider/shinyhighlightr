
<!-- README.md is generated from README.Rmd. Please edit that file -->

# shinyhighlightr <img src="man/figures/example.gif" align="right" width="225" />

[![Lifecycle](https://img.shields.io/badge/lifecycle-experimental-orange.svg)](https://www.tidyverse.org/lifecycle/#experimental)
[![Travis CI build
status](https://travis-ci.org/stefanieschneider/shinyhighlightr.svg?branch=master)](https://travis-ci.org/stefanieschneider/shinyhighlightr)
[![AppVeyor build
status](https://ci.appveyor.com/api/projects/status/github/stefanieschneider/shinyhighlightr?branch=master&svg=true)](https://ci.appveyor.com/project/stefanieschneider/shinyhighlightr)

## Overview

This R package creates text markup input controls to highlight patterns
in text values. It is highly inspired by the online regular expression
tester and debugger [Regex101](https://regex101.com/). Two input fields
are created: one to specify the expression to be marked; another where
this expression is marked in unstructured text values, e.g., test cases
for a regular expression. shinyhighlightr is build on top of
[CodeMirror](https://github.com/codemirror/CodeMirror), a versatile text
editor implemented in JavaScript.

## Installation

You can install the development version of shinyhighlightr from
[GitHub](https://github.com/stefanieschneider/shinyhighlightr) use:

``` r
# install.packages("devtools")
devtools::install_github("stefanieschneider/shinyhighlightr")
```

## Usage

``` r
if (interactive()) {
  library(shiny)
  library(shinyhighlightr)

  ui <- fluidPage(
    textMarkupInput(
      inputId = "highlight",
      labels = c("Expression", "Test Cases"),
      values = list(
        "[1-2]{1}[0-9]{3}",
        c(
          "19th century", "1855",
          "between 1905 and 1910"
        )
      )
    )
  )

  server <- function(input, output, session) {

  }

  shinyApp(ui, server)
}
```

## Contributing

Please report issues, feature requests, and questions to the [GitHub
issue
tracker](https://github.com/stefanieschneider/shinyhighlightr/issues).
We have a [Contributor Code of
Conduct](https://github.com/stefanieschneider/shinyhighlightr/blob/master/CODE_OF_CONDUCT.md).
By participating in shinyhighlightr you agree to abide by its terms.
