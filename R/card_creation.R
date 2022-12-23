#' Id look up with uniqueness validation
#'
#' @param data Dataframe for id look up.
#' @param search_name Value for the look up
#' @param name_col Column in which to search for search_name
#' @param id_col Column in which the id is found
#'
#' @returns The id value corresponding to search_name in column name_col
#' @export
unique_id_lookup <- function(data, search_name, name_col, id_col) {
  filtered_data <- dplyr::filter(data, .data[[name_col]] == search_name) # nolint
  if (nrow(filtered_data) >= 2) {
    stop(paste0('No unique match found for column "', name_col, '" and value "', search_name, '".'))
  }
  if (nrow(filtered_data) == 0) {
    stop(paste0('No match found for column "', name_col, '" and value "', search_name, '".'))
  }
  if (!(id_col %in% colnames(data))) {
    stop(paste0('Id column "', id_col, '" not present in data.'))
  }
  return(filtered_data[[id_col]][1])
}

#' Card creation based on names instead of IDs
#'
#' @param metabase_client A MetabaseClient instance
#' @param card_name Name of the card that will be created.
#' @param collection_name Name of the parent collection that the card is created for.
#' @param table_name Name of the table that will be used for card creation.
#'
#' @returns The id of the created card
#' @export
create_select_all_card <- function(metabase_client, card_name, collection_name, table_name) {
  tables <- metabase_client$get_tables()
  table_id <- unique_id_lookup(tables, table_name, "table_name", "table_id")
  database_id <- unique_id_lookup(tables, table_name, "table_name", "db_id")
  query <- create_select_all_columns(table_id, database_id) # nolint

  collections <- metabase_client$get_collections()
  collection_id <- unique_id_lookup(collections, collection_name, "name", "id")
  metabase_client$create_card(card_name, collection_id, query)
}
