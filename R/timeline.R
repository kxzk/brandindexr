#' Formulas
#'
#' Scoring Param    Description           3-Point Measure (Pos/Neg/Neu)       2-Point (yes/no)
#' total            all respondents       unaware == neu                      unaware == no
#' aware            no unaware            no unaware                          no unaware
#' opinion          no unaware or neu     no unaware + neu                    no unaware + neu

#' Title
#'
#' @param brand
#' @param start_date
#' @param end_date
#' @param scoring
#' @param moving_average
#' @param endpoint

timeline_brands <- function(brand,
                            start_date,
                            end_date,
                            scoring,
                            moving_average = 1,
                            endpoint = "timeline/brands") {
  url <- url_builder(endpoint)
  url_timeline <- glue("{url}?brand={brand}&start_date={start_date}&end_date={end_date}&moving_average={moving_average}&scoring={scoring}")

  # Set Accept header to blank in order to force CSV format.
  # otherwise, the API will return JSON.
  brands <- httr::GET(url_timeline, httr::add_headers("Accept" = ""))
  brand_urls <- httr::content(brands)$data

  return(brand_urls)

}

#' Title
#'
#' @param region
#' @param sector
#' @param brand_id
#' @param start_date
#' @param end_date
#' @param scoring
#' @param moving_average
#' @param filters
#' @param metrics
#' @param endpoint
#'
#' @return
#' @export
#'
#' @examples
single_brand_timeline <- function(region,
                                  sector,
                                  brand_id,
                                  start_date,
                                  end_date,
                                  scoring,
                                  moving_average,
                                  filters = NULL,
                                  metrics = NULL,
                                  endpoint = "timeline/file.csv") {
  url <- url_builder(endpoint)

  if (!is.null(filters) && !is.null(metrics)) {
    url_single_timeline <- glue("{url}?moving_average={moving_average}&end_date={end_date}&scoring={scoring}&brand_id={brand_id}&region={region}&start_date={start_date}&sector={sector}&filters={filters}&metrics={metrics}")
  } else if (is.null(filters) && is.null(metrics)) {
    url_single_timeline <- glue("{url}?moving_average={moving_average}&end_date={end_date}&scoring={scoring}&brand_id={brand_id}&region={region}&start_date={start_date}&sector={sector}")
  } else if (is.null(filters)) {
    url_single_timeline <- glue("{url}?moving_average={moving_average}&end_date={end_date}&scoring={scoring}&brand_id={brand_id}&region={region}&start_date={start_date}&sector={sector}&metrics={metrics}")
  } else {
    url_single_timeline <- glue("{url}?moving_average={moving_average}&end_date={end_date}&scoring={scoring}&brand_id={brand_id}&region={region}&start_date={start_date}&sector={sector}&filters={filters}")
  }

  data <- get_and_clean(url_single_timeline)

  return(data)

}

#' Title
#'
#' @param brand
#' @param start_date
#' @param end_date
#' @param scoring
#' @param moving_average
#' @param period_type
#' @param period_size
#' @param endpoint
#'
#' @return
#' @export
#'
#' @examples
multi_brand_timeline <- function(brand,
                                 start_date,
                                 end_date,
                                 scoring,
                                 moving_average = 1,
                                 period_type = "day",
                                 period_size = 1,
                                 endpoint = "timeline/multi-brand-file.csv") {
  url <- url_builder(endpoint)
  url_multi <- glue("{url}?scoring={scoring}&start_date={start_date}&end_date={end_date}&moving_average={moving_average}&period_type={period_type}&period_size={period_size}&brand={brand}")

  get_and_clean(url_multi)

}

#' Title
#'
#' @param sector
#' @param custom_sector
#' @param start_date
#' @param end_date
#' @param scoring
#' @param moving_average
#' @param period_type
#' @param period_size
#' @param endpoint
#'
#' @return
#' @export
#'
#' @examples
multi_sector_timeline <- function(sector,
                                 custom_sector = NULL,
                                 start_date,
                                 end_date,
                                 scoring,
                                 moving_average = 1,
                                 period_type = "day",
                                 period_size = 1,
                                 endpoint = "timeline/multi-brand-file.csv") {
  url <- url_builder(endpoint)

  if (!is.null(custom_sector)) {
    url_sector <- glue("{url}?scoring={scoring}&start_date={start_date}&end_date={end_date}&moving_average={moving_average}&period_type={period_type}&period_size={period_size}&custom_sector={custom_sector}")
  } else {
    url_sector <- glue("{url}?scoring={scoring}&start_date={start_date}&end_date={end_date}&moving_average={moving_average}&period_type={period_type}&period_size={period_size}&sector={sector}")
  }

  get_and_clean(url_sector)

}
