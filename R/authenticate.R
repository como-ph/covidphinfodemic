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
  Sys.setenv("GITHUB_PAT" = token)
}
