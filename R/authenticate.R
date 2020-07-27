################################################################################
#
#'
#' Set GitHub authentication credentials
#'
#' @param token GitHub personal access token (PAT)
#'
#' @return GitHub system environment variables set.
#'
#' @examples
#' \dontrun{
#'   set_gh_token(token = "XXXXXXXXXXXXXXXX")
#' }
#'
#' @export
#'
#
################################################################################

set_gh_token <- function(token) {
  withr::with_envvar(
    Sys.setenv("GITHUB_PAT" = token)
  )
}
