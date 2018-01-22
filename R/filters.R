#' Title
#'
#' @param region
#' @param sector
#' @param custom_sector
#' @param endpoint
#'
#' @return
#' @export
#'
#' @examples
demo_filters <- function(region,
                         sector = NULL,
                         custom_sector = NULL,
                         endpoint = "filters/demos") {
  url <- url_builder(endpoint)

  if (!is.null(sector) && !is.null(custom_sector)) {
    stop("CHOOSE ONE: either sector or custom_sector")
  } else if (!is.null(sector)) {
   url_filters <- glue("{url}?region={region}&sector={sector}")
  } else if (!is.null(custom_sector)) {
   url_filters <- glue("{url}?region={region}&custom_sector={custom_sector}")
  } else {
   url_filters <- glue("{url}?region={region}")
  }

  get_and_clean(url_filters)

}

#' Title
#'
#' @param region
#' @param name
#' @param endpoint
#'
#' @return
#' @export
#'
#' @examples
demo_filter <- function(region,
                        name,
                        endpoint = "filters/demo") {
  url <- url_builder(endpoint)
  url_filter <- glue("{url}?region={region}&name={name}")
  get_and_clean(url_filter)
}

#' Title
#'
#' @param endpoint
#'
#' @return
#' @export
#'
#' @examples
metric_filters <- function(endpoint = "filters/metrics") {
  url <- url_builder(endpoint)
  get_and_clean(url)$meta
}

#' Title
#'
#' @param endpoint
#'
#' @return
#' @export
#'
#' @examples
metric_values <- function(endpoint = "filters/metrics") {
  url_builder(endpoint)
  get_and_clean(url)$data
}
