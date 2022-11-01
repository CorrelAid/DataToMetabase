source("R/metabaseR.R")
library(glue)

mb_session <- metabase_init('https://metabase.citizensforeurope.org', 'tuhin.mllk@gmail.com')

data <- metabase_fetch_item_info(mb_session,"collection",NULL)
data_1 <- metabase_create_collection(mb_session,"nested_collection",21)

query <- "SELECT public.penguins.species AS species, count(*) AS count FROM public.penguins GROUP BY public.penguins.species ORDER BY public.penguins.species ASC"
database <- "CorrelAid CFE PostgreSQL Synthetic"
name <-"Demo_m_api"
data_2 <- metabase_create_card(mb_session,name,database,query)

