#' Metrics Data
#'
#' This endpoint lists the available metrics for usage with timelines.
#'
#' @param endpoint A string containing the appropriate endpoint.
#'
#' @return A list of the metrics to use with timelines.
#' @export
metrics <- function(endpoint = "metrics") {
  url <- url_builder(endpoint)
  get_and_clean(url)$data
}
