#' Demographic Filters
#'
#' This endpoint contains the demographic filters that your company
#' is able to use.
#'
#' The \emph{sector} and \emph{custom_sector} are mutually exclusive.
#'
#' @param region A string for which the demographic filters should be listed.
#' @param sector A number of the sector for which the demographic filtes should be listed.
#' @param custom_sector A number of the custom sector for which the demographic filters should be listed.
#' @param endpoint A string containing the appropriate endpoint.
#'
#' @return A list of demographic filters.
#' @export
demo_filters <- function(region,
                         sector = NULL,
                         custom_sector = NULL,
                         endpoint = "filters/demos") {
  url <- url_builder(endpoint)

  if (!is.null(sector) && !is.null(custom_sector)) {
    stop("CHOOSE ONE: either sector or custom_sector")
  } else if (!is.null(sector)) {
   url_filters <- glue::glue("{url}?region={region}&sector={sector}")
  } else if (!is.null(custom_sector)) {
   url_filters <- glue::glue("{url}?region={region}&custom_sector={custom_sector}")
  } else {
   url_filters <- glue::glue("{url}?region={region}")
  }

  get_and_clean(url_filters)

}

#' Demographic Filter
#'
#' This endpoint contains the demographic filter description for a particular demographic filter required.
#'
#' @param region A string containing the region for which the demographic filter should be described.
#' @param name A string containing the \emph{name} for the demographic filter to be described.
#' @param endpoint A string containing the appropriate endpoint.
#'
#' @return A list of filter descriptions for a particular demographic filter.
#' @export
demo_filter <- function(region,
                        name,
                        endpoint = "filters/demo") {
  url <- url_builder(endpoint)
  url_filter <- glue::glue("{url}?region={region}&name={name}")
  get_and_clean(url_filter)
}

#' Metric Filters
#'
#' This endpoint contains the metric filters that your company is able to use.
#'
#' @param endpoint A string containing the appropriate endpoint.
#'
#' @return A list of metric filters.
#' @export
metric_filters <- function(endpoint = "filters/metrics") {
  url <- url_builder(endpoint)
  get_and_clean(url)$meta
}


#' Composite Filters
#' 
#' This endpoint contains the composite filters that your company is able to use.
#'
#' @param region A string representing the region for which the composite filters should be listed.
#' @param endpoint A string containing the appropriate endpoint.
#'
#' @return A list of composite filters.
#' @export
composite_filter <- function(region,
                             endpoint = "filters/composite-filters") {
  url <- url_builder(endpoint)
  url_filter <- glue::glue("{url}?region={region}")
  get_and_clean(url_filter)
}

#' Composite Filter
#' 
#' This endpoint describes a composite filter that your company is able to use.
#'
#' @param id A string containing the ID for which the composite filter should be described.
#' @param endpoint A string containing the appropriate endpoint.
#'
#' @return An ID for the composite filter described.
#' @export
composite_filters <- function(id,
                              endpoint = "filters/composite-filter") {
  url <- url_builder(endpoint)
  url_filter <- glue::glue("{url}?id={id")
  get_and_clean(url_filter)
}