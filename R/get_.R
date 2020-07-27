################################################################################
#
#'
#' Extract text from README of GitHub repositories
#'
#' @param repo A vector of GitHub repository URLs
#'
#' @return A vector of text contents of README files
#'
#' @examples
#' get_gh_readme(repo = "https://github.com/como-ph/covidphinfodemic")
#'
#' @export
#'
#
################################################################################

get_gh_readme <- function(repo) {
  x <- stringr::str_split(repo, pattern = "/", simplify = TRUE)

  y <- gh::gh(endpoint = "/repos/:owner/:repo/readme",
              owner = x[ , 1], repo = x[ , 2],
              .accept = "application/vnd.github.v3.raw+json")

  z <- y[[1]] %>%
    unlist()

  return(z)
}
