library("vcr")
invisible(vcr::vcr_configure(
  dir = vcr::vcr_test_path("fixtures"),
  filter_request_headers = list(`X-Metabase-Session` = "<sanitized>"),
  filter_sensitive_data_regex = list(
    `"username":"<sanitized>"` = '"username":"[^"]*"',
    `"password":"<sanitized>"` = '"password":"[^"]*"',
    `{"id":"<sanitized>"}` = '\\{"id":"[^"]*"\\}',
    `"first_name":"<sanitized>"` = '"first_name":"[^"]*"',
    `"last_name":"<sanitized>"` = '"last_name":"[^"]*"',
    `"email":"<sanitized>"` = '"email":"[^"]*"',
    `https://notarealinstance.metabase.com` = Sys.getenv("METABASE_URL")
  ),
  match_requests_on = c("method", "path")
))
vcr::check_cassette_names()
