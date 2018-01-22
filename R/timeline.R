#' Formulas
#'
#' Scoring Param    Description           3-Point Measure (Pos/Neg/Neu)       2-Point (yes/no)
#' total            all respondents       unaware == neu                      unaware == no
#' aware            no unaware            no unaware                          no unaware
#' opinion          no unaware or neu     no unaware + neu                    no unaware + neu

#' Timeline Brands
#'
#' This endpoint contains the URLs from where timeline series files can be retrieved.
#' Where indicated, these URLs accept optional parts with demographic and metric
#' filters (referenced as \code{:demo_filters} and \code{:metric_filters}
#' here in the documentation) for the reponses used to calculate the datapoints.
#' \code{:demo_filters} has the following format:
#' \code{:demo_filter_nickname.filter_value[/another_demo.another_value]} (starting
#' with a colon), each slash representing the start of a demo filter. \code{:metric_filters}
#' has the following format:
#' \code{:/brand.brand_id.metric_nick.filter_value[/brand.another_brand_id.another_metric.nick.another_value]}
#' (starting with a colon), each slash representing the start of a demo filter. Notice
#' that each metric filter has to start exactly with the characters \code{brand}
#' (this pattern is used to differentiate between the two types of filters). You
#' can also provide multiple values for each filter; to do so, just put the numeric
#' fitler values as the \code{filter_value} part separated by a comma (",").
#' For example: \code{:/brand.1234.buzz.1,2/brand.2345.quality.9}.
#'
#' @param brand A string in the format \code{region:sector_id:brand_id[:demo_filters]}.
#' @param start_date A string in the format \code{YYYY-MM-DD}.
#' @param end_date A string in the format \code{YYYY-MM-DD}.
#' @param scoring A string containing the scoring option to use (default: "total", "aware", "opinion").
#' @param moving_average A number of the moving_average, in days, to be applied.
#' @param endpoint A string containing the appropriate endpoint.
#'
#' @return A tibble with timeline data.
#' @examples
#' \dontrun(
#' "https://api.brandindex.com/v0/timeline/brands?brand=foo:123:1234:/brand.3456.reputation.1&brand=bar:234:2345:/foo_filter.1/bar_filter.2&start_date=2001-01-01&end_date=2015-02-20&moving_average=4&scoring=opinion"
#' )
#' @export
timeline_brands <- function(brand,
                            start_date,
                            end_date,
                            scoring,
                            moving_average = 1,
                            endpoint = "timeline/brands") {
  url <- url_builder(endpoint)
  url_timeline <- glue("{url}?brand={brand}&start_date={start_date}&end_date={end_date}&moving_average={moving_average}&scoring={scoring}")

  # Set Accept header to blank in order to force CSV format.
  # Otherwise, the API will return JSON.
  brands <- httr::GET(url_timeline, httr::add_headers("Accept" = ""))
  brand_urls <- httr::content(brands)$data

  return(brand_urls)

}

#' Single-Brand Timeline File
#'
#' This endpoint is actually a file payload with datapoint by data and metric,
#' so its content can be save to a file on disk or worked on directly.
#'
#' @param region A string for the region to which the brand belongs.
#' @param sector A number for the sector to which the brand belongs.
#' @param brand_id A number for the brand_id to which the brand belongs.
#' @param start_date A string in the format \code{YYYY-MM-DD}.
#' @param end_date A string in the format \code{YYYY-MM-DD}.
#' @param scoring A string containing the scoring option to use (default: "total", "aware", "opinion").
#' @param moving_average A number of the moving_average, in days, to be applied.
#' @param filters A string in the format \code{[:demo_filters][:metric_filters]}.
#' @param metrics A string containing the specific metrics to include if not all
#' of them are wanted. If you want more than one separate them with a \code{/}.
#' @param endpoint A string containing the appropriate endpoint.
#'
#' @return A tibble of the single-brand datapoint.
#' @export
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

#' Multi-Brand Timeline File
#'
#' This endpoint is similar to simple timeline files, but instead of representing
#' the data for one brand only it can contaim more than one brand per file.
#'
#' It's also possible to roll up the data in periods - for this, see
#' \code{period_type} and \code{period_size} parameters. In this case, when
#' periodizing for more than "every 1 day" (which is the default, i.e., no
#' roll-up done), the first date of each period is used in the resulting data.
#'
#' @param brand A string of the format \code{region:sector_id:brand_id[:demo_filters][:metric_filters]}.
#' Can be provided multiple times - if so, multiple brands will be listed in the
#' response data.
#' @param start_date A string in the format \code{YYYY-MM-DD}.
#' @param end_date A string in the format \code{YYYY-MM-DD}.
#' @param scoring A string containing the scoring option to use (default: "total", "aware", "opinion").
#' @param moving_average A number of the moving_average, in days, to be applied.
#' @param period_type A string for the type of period, if rollling up the
#' datapoints (default: "day", "week", "month", "year").
#' @param period_size A number for the size of the period (default: 1). \code{2}
#' for rolling up "every 2 weeks".
#' @param endpoint A string containing the appropriate endpoint.
#'
#' @return A tibble of multiple brand datapoints.
#' @export
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

#' Multi Sector Timeline
#'
#' This endpoint is similar to simple timeline files, but instead of representing
#' the data for one brand only it can contaim more than one brand per file.
#'
#' You must provide one of \code{sector} or \code{custom_sector}, but not both.
#'
#' It's also possible to roll up the data in periods - for this, see
#' \code{period_type} and \code{period_size} parameters. In this case, when
#' periodizing for more than "every 1 day" (which is the default, i.e., no
#' roll-up done), the first date of each period is used in the resulting data.
#'
#' @param sector A string of the format \code{region:sector_id[:demo_filters][:metric_filters][:metrics]}.
#' Can be provided multiple times - if so, multiple sectors will be listed.
#' @param custom_sector A string of the format \code{region:custom_sector_id[:demo_filters][:metric_filters][:metrics]}. Mutliple can be listed.
#' @param start_date A string in the format \code{YYYY-MM-DD}.
#' @param end_date A string in the format \code{YYYY-MM-DD}.
#' @param scoring A string containing the scoring option to use (default: "total", "aware", "opinion").
#' @param moving_average A number of the moving_average, in days, to be applied.
#' @param period_type A string for the type of period, if rollling up the
#' datapoints (default: "day", "week", "month", "year").
#' @param period_size A number for the size of the period (default: 1). \code{2}
#' for rolling up "every 2 weeks".
#' @param endpoint A string containing the appropriate endpoint.
#'
#' @return A tibble for multiple sector timeline datapoins.
#' @export
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
