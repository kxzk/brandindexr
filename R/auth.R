#' Title
#'
#' @param email
#' @param password
#' @param endpoint
#'
#' @return
#' @export
#'
#' @examples
bi_auth <- function(email, password, endpoint = "login") {
  input <- c(email, password)
  if (!is.character(input)) { stop("EXPECTED TYPES: (email: str, password: str)") }

  url <- url_builder(endpoint)
  url_auth <- glue("{url}?email={email}&password={password}")

  response <- httr::POST(url_auth)
  httr::stop_for_status(response)
  res <- response$cookies

  cookies_tbl <- tibble::as_tibble(res)
  cookies_tbl
}
