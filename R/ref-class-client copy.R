source("R/ref-class-client.R")
source(".Renviron")
mc <- MetabaseClient(user='tuhin.mllk@gmail.com',password='11Feb1996$$$', metabase_url='https://metabase.citizensforeurope.org')
mc
mc$get_collections()
mc$create_collection("nested_collectionmc",21)
mc$get_tables()
mc$get_table_items(241)
mc$get_items(21)

