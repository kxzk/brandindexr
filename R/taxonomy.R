#' Title
#'
#' @param region
#' @param endpoint
#'
#' @return
#' @export
#'
#' @examples
sectors_with_brands <- function(region, endpoint = "taxonomy/sectors-with-brands.csv?") {
  url <- url_builder(endpoint)
  url_sect_brand <- glue("{url}region={region}")

  response <- httr::GET(url_sect_brand)
  response <- httr::content(response)

  return(response)
}

#' Title
#'
#' @param region
#' @param sector
#' @param brand
#' @param endpoint
#'
#' @return
#' @export
#'
#' @examples
brand_data <- function(region,
                       sector,
                       brand,
                       endpoint = "taxonomy/brand.json") {
  url <- url_builder(endpoint)
  url_brand <- glue("{url}?region={region}&sector={sector}&brand={brand}")
  get_and_clean(url_brand)
}
