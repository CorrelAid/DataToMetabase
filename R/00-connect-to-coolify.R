library(DBI)
library(RPostgres)
library(readr)

# PREREQUISITE: content from secret link (see notion infrastructure part)
# open your user Renviron file by using
#usethis::edit_r_environ(scope = "project")
# OR: if you want to have a local Renviron file in your project folder
# readRenviron(".Renviron")

# extract environment variables
db_name <- Sys.getenv("COOLIFY_DB")
db_host <- Sys.getenv("COOLIFY_HOST")
db_port <- Sys.getenv("COOLIFY_PORT")
db_user <- Sys.getenv("COOLIFY_USER")
db_password <- Sys.getenv("COOLIFY_PASSWORD")

# create connection
con <- DBI::dbConnect(drv = RPostgres::Postgres(),
                      host = db_host,
                      port = db_port,
                      dbname = db_name,
                      user = db_user,
                      password = db_password)

# DBI::dbListTables(con) # shows tables and views :)

# example to read the metadata and values about the diversity profile questions
# diversity_responses <- DBI::dbReadTable(con, "diversity_responses")
# diversity_items <- DBI::dbReadTable(con, "diversity_items")
# diversity_answer_options <- DBI::dbReadTable(con, "diversity_answer_dict")
# diversity_groups <-   DBI::dbReadTable(con, "diversity_groups")
# readr::write_rds(diversity_responses, here::here("data", "raw", "diversity_responses.rds"))
# # code to show how to reimport data file - copy to your code if needed
# diversity_responses <- readr::read_rds(here::here("data", "raw", "diversity_responses.rds"))

# DBI::dbDisconnect(con)
