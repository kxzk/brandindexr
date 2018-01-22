#' Title
#'
#' @param endpoint
#'
#' @return
#' @export
#'
#' @examples
metrics <- function(endpoint = "metrics") {
  url <- url_builder(endpoint)
  get_and_clean(url)$data
}
