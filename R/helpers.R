#' Cleaning HTTP GET Requests
#'
#' This function sends a GET request to the appropriate URL.
#' Next, it checks the response and grabs the GET request's
#' content.
#'
#' @param url A string of the url to send the GET request to.
#'
#' @return A response from the GET request (list, tibble, error)
#' @export
get_and_clean <- function(url) {
  response <- httr::GET(url)
  httr::stop_for_status(response)
  res <- httr::content(response)

  return(res)
}

#' Building Up The URL
#'
#' This function holds the base url and takes one endpoint.
#'
#' @param endpoint A string of the endpoint to query.
#'
#' @return A url with the base url and endpoint appended.
#' @export
url_builder <- function(endpoint) {
  base_url <- glue("https://api.brandindex.com/v0/{endpoint}")
  return(base_url)
}
