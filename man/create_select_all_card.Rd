% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/card_creation.R
\name{create_select_all_card}
\alias{create_select_all_card}
\title{Card creation based on names instead of IDs}
\usage{
create_select_all_card(metabase_client, card_name, collection_name, table_name)
}
\arguments{
\item{metabase_client}{A MetabaseClient instance}

\item{card_name}{Name of the card that will be created.}

\item{collection_name}{Name of the parent collection that the card is created for.}

\item{table_name}{Name of the table that will be used for card creation.}
}
\value{
The id of the created card
}
\description{
Card creation based on names instead of IDs
}
