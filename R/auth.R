#' Simple Authentication
#'
#' Simple login authentication to the YouGov BrandIndex API.
#'
#' @param email A string containing your email used to login.
#' @param password A string containing your password used to login.
#' @param endpoint A string containing the appropriate endpoint.
#'
#' @return A tibble containing cookie information.
#'
#' @export
bi_auth <- function(email, password, endpoint = "login") {
  input <- c(email, password)
  if (!is.character(input)) { stop("EXPECTED TYPES: (email: str, password: str)") }

  url <- url_builder(endpoint)
  url_auth <- glue::glue("{url}?email={email}&password={password}")

  response <- httr::POST(url_auth)
  httr::stop_for_status(response)

  sucess <- glue::glue("

                       =============== SUCCESS: YOU'RE LOGGED IN ===============

                       Try a couple of quick queries to make sure everything is
                       functioning.

                       company_defaults()

                       metrics()

                       ")
  print(sucess)
}
