################################################################################
#
#'
#' Perform a search for Philippines- and COVID-19-related GitHub repositories
#'
#' @param query GitHub query.
#' @param per_page How many results per page should be returned. Defaults to
#'   100 (maximum)
#' @param page Results page to return
#'
#' @return A tibble of search results
#'
#' @examples
#' \dontrun{
#'   search_gh_covidph(query = "covid19+philippines+in:readme in:description in:name",
#'                     page = 1)
#' }
#'
#' @export
#'
#
################################################################################

search_gh_covidph <- function(query = NULL,
                              per_page = 100,
                              page = NULL) {
  ##
  x <- gh::gh(endpoint = "/search/repositories",
              q = query,
              accept = "application/vnd.github.v3.text-match+json",
              per_page = per_page)

  ##
  y <- x[[3]] %>%
    lapply(unlist, recursive = FALSE) %>%
    dplyr::bind_rows()

  ## Calculate number of pages
  pages <- if(is.null(page)) ceiling(x[[1]] / per_page) else max(page)

  ##
  if(pages > 1) {
    ##
    for(i in seq_len(pages - 1)) {
      ##
      z <- gh::gh_next(x)[[3]] %>%
        lapply(unlist, recursive = FALSE) %>%
        dplyr::bind_rows()
      ##
      y <- rbind(y, z)
    }
  }

  ## Return
  return(y)
}


################################################################################
#
#'
#' Search for
#'
#'
#
################################################################################
