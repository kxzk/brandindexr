#' Title
#'
#' @param url
#'
#' @return
#' @export
#'
#' @examples
get_and_clean <- function(url) {
  response <- httr::GET(url)
  httr::stop_for_status(response)
  res <- httr::content(response)

  return(res)
}

#' Title
#'
#' @param endpoint
#'
#' @return
#' @export
#'
#' @examples
url_builder <- function(endpoint) {
  base_url <- glue("https://api.brandindex.com/v0/{endpoint}")
  return(base_url)
}
