library(DBI)

con <- dbConnect(RSQLite::SQLite(), ":memory:")

dbListTables(con)

geo <- readr::read_csv(here::here("Data/cx_geo.csv"))
zip <- readr::read_csv(here::here("Data/cx_zip.csv"))

dbWriteTable(conn = con,
             name = "cx_geo",
             geo)

dbWriteTable(conn = con,
             name = "cx_zip",
             zip)


dbListTables(con)

dbGetQuery(con,"SELECT * from cx_zip LIMIT 10")
dbGetQuery(con,"SELECT * from cx_geo LIMIT 10")







dbDisconnect(con)
