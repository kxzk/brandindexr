#' Title
#'
#' @param endpoint
#'
#' @return
#' @export
#'
#' @examples
company_defaults <- function(endpoint = "company/defaults") {
  url <- url_builder(endpoint)
  get_and_clean(url)$data
}

#' Title
#'
#' @param endpoint
#'
#' @return
#' @export
#'
#' @examples
company_regions <- function(endpoint = "company/region") {
  url <- url_builder(endpoint)
  get_and_clean(url)$data
}

#' Title
#'
#' @param region
#' @param custom
#' @param inactive
#' @param endpoint
#'
#' @return
#' @export
#'
#' @examples
company_sectors <- function(region,
                            custom = 0,
                            inactive = 0,
                            endpoint = "company/sectors?region=") {
  url <- url_builder(endpoint)
  url_region <- glue("{url}{region}&{custom}&{inactive}")
  get_and_clean(url_region)$data
}

#' Title
#'
#' @param region
#' @param endpoint
#'
#' @return
#' @export
#'
#' @examples
company_custom_sectors <- function(region, endpoint = "company/custom-sectors") {
  url <- url_builder(endpoint)
  url_sectors <- glue("{url}?region={region}")
  get_and_clean(url_sectors)$data
}

#' Title
#'
#' @param region
#' @param sector
#' @param custom_sector
#' @param inactive
#' @param endpoint
#'
#' @return
#' @export
#'
#' @examples
company_brands <- function(region,
                           sector = NULL,
                           custom_sector = NULL,
                           inactive = 0,
                           endpoint = "company/brands") {
  url <- url_builder(endpoint)

  if (!is.null(sector)) {
    url_brands <- glue("{url}?region={region}&sector={sector}")
  } else {
    url_brands <- glue("{url}?region={region}&custom_sector={custom_sector}")
  }

  get_and_clean(url_brands)$data
}
