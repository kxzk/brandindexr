#' Company Defaults
#'
#' This endpoint contains the default values used for your company's default
#' region, sector and brand - which are used in a number of scenarios
#' where either of them is not provided.
#'
#' @param endpoint A string containing the appropriate endpoint.
#'
#' @return A list of the company defaults.
#' @export
company_defaults <- function(endpoint = "company/defaults") {
  url <- url_builder(endpoint)
  get_and_clean(url)$data
}

#' Company Regions
#'
#' This endpoint contains the regions accessible by your company.
#'
#' @param endpoint A string containing the appropriate endpoint.
#'
#' @return A list of regions accessible by your company.
#' @export
company_regions <- function(endpoint = "company/region") {
  url <- url_builder(endpoint)
  get_and_clean(url)$data
}

#' Company Sectors
#'
#' This endpoint contains the sectors by your company, by region.
#'
#' @param region A string for which the sectors should be listed.
#' @param custom A number value to return expired sectors (default: 0, 1)
#' @param inactive A number value to return custom sectors (default: 0, 1)
#' @param endpoint A string containing the appropriate endpoint.
#'
#' @return A list of sectors by region.
#' @export
company_sectors <- function(region,
                            custom = 0,
                            inactive = 0,
                            endpoint = "company/sectors?region=") {
  url <- url_builder(endpoint)
  url_region <- glue("{url}{region}&{custom}&{inactive}")
  get_and_clean(url_region)$data
}

#' Company Custom Sectors
#'
#' @param region A string containing the region for which custom sectors
#' should be listed.
#' @param endpoint A string containing the appropriate endpoint.
#'
#' @return A list of regions for which the custom sectors should be listed.
#' @export
company_custom_sectors <- function(region, endpoint = "company/custom-sectors") {
  url <- url_builder(endpoint)
  url_sectors <- glue("{url}?region={region}")
  get_and_clean(url_sectors)$data
}

#' Company Brands
#'
#' This endpoint contains the brands accessibel by your company, by region
#' and sector.
#'
#' You may list brands by either \emph{sector} or \emph{custom_sector},
#' but not both.
#'
#' @param region A string containing the region for which the brand should be listed.
#' @param sector A number containing the sector for which the brands should be listed.
#' @param custom_sector A number for the custom sector for which brands should be listed.
#' @param inactive A number value to return inactive brands as well (default: 0, 1)
#' @param endpoint
#'
#' @return A list of brands accessibly by your company, by region and sector.
#' @export
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
