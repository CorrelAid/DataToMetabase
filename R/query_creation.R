#' Create a simple query for Metabase
#'
#' @param table_id ID of the table to be used.
#' @param database_id ID of the database to be used.
#' @returns A R representation of the query json.
create_select_all_columns <- function(table_id, database_id) {
  query <- list(
    database = database_id,
    type = "query",
    query = list(
      `source-table` = table_id
    )
  )
  return(query)
}

#' Create a query for Metabase with specific columns
#'
#' @param table_id ID of the table to be used.
#' @param database_id ID of the database to be used.
#' @param columns vector of column ids to select
#' @returns A R representation of the query json.
create_select_specific_columns <- function(table_id, database_id, columns) {
  query <- list(
    database = database_id,
    type = "query",
    query = list(
      `source-table` = table_id,
      fields = lapply(columns, function(col) {
        list("field", col, NULL)
      })
    )
  )
  return(query)
}
