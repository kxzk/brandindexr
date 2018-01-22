#' Sectors with Brands
#'
#' This endpoint contains data that exposes the taxonomy of categories,
#' brands, etc...
#'
#' @param region A string of the region for which the sectors should be listed.
#' @param endpoint A string containing the appropriate endpoint.
#'
#' @return A tibble of sectors with their brands.
#' @export
sectors_with_brands <- function(region, endpoint = "taxonomy/sectors-with-brands.csv?") {
  url <- url_builder(endpoint)
  url_sect_brand <- glue::glue("{url}region={region}")

  response <- httr::GET(url_sect_brand)
  response <- httr::content(response)

  return(response)
}

#' Brand Data
#'
#' This endpoint responds with a payload that describes a specific brand.
#'
#' @param region A string of the region for which the sectors should be listed.
#' @param sector A number for the sector ID that the brand is tied to.
#' @param brand A number for the brand ID that the brand is tied to.
#' @param endpoint A string containing the appropriate endpoint.
#'
#' @return A list of data that describes a specific brand.
#' @export
brand_data <- function(region,
                       sector,
                       brand,
                       endpoint = "taxonomy/brand.json") {
  url <- url_builder(endpoint)
  url_brand <- glue::glue("{url}?region={region}&sector={sector}&brand={brand}")
  get_and_clean(url_brand)
}
