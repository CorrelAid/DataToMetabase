MetabaseClient <- setRefClass( # nolint
  "MetabaseClient",
  fields = list(
    user = "character",
    password = "character",
    metabase_url = "character",
    session = "character",
    api_uri_prefix = "character"
  )
)

MetabaseClient$methods(
  initialize = function(..., user = NULL, password = NULL, metabase_url = NULL) {
    callSuper(...)
    session <<- ""
    api_uri_prefix <<- "/api"
    if (is.null(user)) {
      user <<- Sys.getenv("METABASE_USER")
    } else {
      user <<- user
    }
    if (is.null(password)) {
      password <<- Sys.getenv("METABASE_PWD")
    } else {
      password <<- password
    }
    if (is.null(metabase_url)) {
      metabase_url <<- Sys.getenv("METABASE_URL")
    } else {
      metabase_url <<- metabase_url
    }
  }
)

MetabaseClient$methods(
  authenticate = function() {
    response <- httr::POST(paste0(.self$metabase_url, .self$api_uri_prefix, "/session"),
      body = list(username = .self$user, password = .self$password),
      encode = "json"
    )

    httr::stop_for_status(response)
    session <<- httr::content(response, as = "parsed")$id
  }
)

MetabaseClient$methods(
  authenticated_get = function(endpoint) {
    if (.self$session == "") {
      .self$authenticate()
    }

    response <- httr::GET(
      paste0(.self$metabase_url, .self$api_uri_prefix, endpoint),
      httr::add_headers("X-Metabase-Session" = .self$session)
    )
    httr::stop_for_status(response)
    httr::content(response, as = "parsed")
  }
)

MetabaseClient$methods(
  authenticated_post = function(endpoint, payload = list()) {
    if (.self$session == "") {
      .self$authenticate()
    }
    response <- httr::POST(
      paste0(.self$metabase_url, .self$api_uri_prefix, endpoint),
      body = jsonlite::toJSON(payload, auto_unbox = TRUE),
      encode = "raw",
      httr::content_type_json(),
      httr::add_headers("X-Metabase-Session" = .self$session)
    )
    httr::stop_for_status(response)
    httr::content(response, as = "parsed")
  }
)

MetabaseClient$methods(
  get_databases = function() {
    databases <- .self$authenticated_get("/database")
    do.call(
      dplyr::bind_rows,
      lapply(databases$data, function(data) {
        list(id = data$id, name = data$name)
      })
    )
  }
)

MetabaseClient$methods(
  get_collections = function() {
    collections <- .self$authenticated_get("/collection/")
    do.call(
      dplyr::bind_rows,
      lapply(collections, function(data) {
        list(id = data$id, location = data$location, name = data$name)
      })
    )
  }
)

MetabaseClient$methods(
  get_items = function(collection_id) {
    items <- .self$authenticated_get(paste0("/collection/", collection_id, "/items"))
    do.call(
      dplyr::bind_rows,
      lapply(items$data, function(item) {
        list(id = item$id, model = item$model, name = item$name)
      })
    )
  }
)

MetabaseClient$methods(
  get_card = function(card_id) {
    card <- .self$authenticated_get(paste0("/card/", card_id))
    card
  }
)

MetabaseClient$methods(
  create_collection = function(collection_name,parent_collection_id ) {
    params <- list( "name"=collection_name,'parent_id'=parent_collection_id, 'color'='#509EE3')
    authenticated_post (endpoint = "/collection/", payload = params)
  }
)
