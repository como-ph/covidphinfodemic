## code to prepare `github search` dataset goes here

githubSearch <- search_gh_covidph(query = "covid19+philippines+in:readme in:name in:description")

usethis::use_data(githubSearch, overwrite = TRUE, compress = "xz")




