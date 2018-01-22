demo_filters <- function() {}

demo_filter <- function() {}

#' Title
#'
#' @param endpoint
#'
#' @return
#' @export
#'
#' @examples
metric_filters <- function(endpoint = "filters/metrics") {
  url <- url_builder(endpoint)
  get_and_clean(url)$meta
}

#' Title
#'
#' @param endpoint
#'
#' @return
#' @export
#'
#' @examples
metric_values <- function(endpoint = "filters/metrics") {
  url_builder(endpoint)
  get_and_clean(url)$data
}
