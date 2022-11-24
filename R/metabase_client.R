# ' Authenticate to Metabase
# '
# ' Initialize an authenticated session with Metabase.
# '
# ' @param base_url The base URL of your Metabase server
# ' @param username The username to log in as
# '
# ' @return Metabaser session
# '
# ' @examples
# ' mb_session <- metabase_auth()
#'
#' @export
metabase_auth <- function() {
  creds <- list(
    username = Sys.getenv("METABASE_USER"),
    password = Sys.getenv("METABASE_PWD")
  )
  api_url <- Sys.getenv("METABASE_API_URL")
  creds_json <- jsonlite::toJSON(creds, auto_unbox = TRUE)
  resp <- httr::POST(paste0(api_url, "/api/session"),
                    httr::add_headers(
                      "Content-Type" = "application/json"
                    ),
                    body = creds_json
  )

  if (resp$status_code >= 200 && resp$status_code < 300) {
    json_auth_response <- httr::content(resp, "text")
    mb_session_token <- toString(jsonlite::fromJSON(json_auth_response))

    # make sure session is legit
    mb_session <- list(
      base_url = api_url,
      token = mb_session_token
    )
    print("Session is authenticated")
    return(mb_session)
  } else {
    print(paste0("Session is not authenticated and the error code is: ", resp$status_code))
    return(NULL)
  }
}
