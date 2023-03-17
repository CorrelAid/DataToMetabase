\name{MetabaseClient-class}
\Rdversion{1.1}
\docType{class}
\alias{MetabaseClient-class}
\alias{MetabaseClient}


\title{Class \code{"MetabaseClient"}}
\description{
Client for Metabase using its REST API.

}
\section{Extends}{

All reference classes extend and inherit methods from \code{"\linkS4class{envRefClass}"}.

}
\examples{
showClass("MetabaseClient")
}
\keyword{classes}
\section{Fields}{
  \describe{
    \item{\code{user}:}{Object of class \code{character} Metabase username }
    \item{\code{password}:}{Object of class \code{character} Metabase password }
    \item{\code{metabase_url}:}{Object of class \code{character} URL of the Metabase instance that the client should connect to.}
    \item{\code{session}:}{Object of class \code{character} Session token, which is obtained automatically. }
    \item{\code{api_uri_prefix}:}{Object of class \code{character} URI of the API relateive to the Metabase URL. Defaults to /api
        and is only included in case Metabase ever changes that.
    }
  }
}
\section{Methods}{
  \describe{
    \item{\code{create_card(name, collection_id, query)}:}{ Create a card of name "name" as part of collection with "collection_id" using query "query". }
    \item{\code{run_card(card_id)}:}{Executes (runs) the query associated with the card of the given id. The result is returned as a tiblle.  }
    \item{\code{get_tables()}:}{ Get tibble containing abailable tables for queries. }
    \item{\code{create_collection(collection_name, parent_collection_id)}:}{ Create a collection.}
    \item{\code{get_card(card_id)}:}{ Get a json representation of a card. }
    \item{\code{get_items(collection_id)}:}{ Get a tibble listing all items in a collection and their type. }
    \item{\code{get_collections()}:}{ Get a tibble listing all collections. }
    \item{\code{get_databases()}:}{ Get a tibble listing all databases. }
    \item{\code{authenticated_post(endpoint, payload)}:}{ Internal method for post requests. }
    \item{\code{authenticated_get(endpoint)}:}{ Internal method for get requests. }
    \item{\code{authenticate()}:}{ Gets a session token. }
    \item{\code{initialize(..., user = NULL, password = NULL, metabase_url = NULL)}:}{ Initilizes the client. Tries to retrieve arguments that are not passed through the environment. }
  }
}
