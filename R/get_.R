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
  ##
  x <- stringr::str_split(repo, pattern = "/") %>% unlist()

  ##
  resp <- httr::GET(paste("https://api.github.com/repos", x[1], x[2], "readme", sep = "/"),
                    httr::authenticate(user = Sys.getenv("GITHUB_USER"),
                                       password = Sys.getenv("GITHUB_PAT")))

  ##
  if(any(is.na(x)) | httr::http_error(resp)) {
    z <- NA
  } else {
    y <- gh::gh(endpoint = "/repos/:owner/:repo/readme",
                owner = x[1], repo = x[2],
                .accept = "application/vnd.github.v3.raw+json")

    ##
    z <- y[[1]]
  }

  ## Return z
  return(z)
}


################################################################################
#
#'
#' Extract text from actual dashboard websites
#'
#' @param url A vector of dashboard websites
#'
#' @return A vector of text contents of dashboard websites
#'
#' @examples
#' get_db_text(url = "https://covid19.mathdro.id")
#'
#' @export
#'
#
################################################################################

get_db_text <- function(url) {

  if(is.na(url) | url == "" | url == "https://www.covid19ph.live" |
     url == "https://jsonresume.org/" |
     url == "https://go-covid19.sideprojects.fun/api/v1/docs/index.html" |
     url == "https://covid19api.io/api/v1" |
     url == "https://aboutme.dennielstephen.now.sh") {
    z <- NA
  } else {
    ##
    resp <- try(httr::GET(url))

    if(class(resp) == "try-error") {
      z <- NA
    } else {
      if(httr::http_error(resp)) {
        z <- NA
      } else {
        ## Start an html session
        htmlSession <- rvest::html_session(url = url)

        x <- htmlSession %>%
          xml2::read_html() %>%
          rvest::html_node(css = "body p") %>%
          rvest::html_text()

        if(class(x) == "list") {
          x <- unlist(x)
        }
        ##
        z <- x
      }
    }
  }
  ## Return z
  return(z)
}
