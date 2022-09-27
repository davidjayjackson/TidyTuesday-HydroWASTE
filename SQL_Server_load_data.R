library(DBI)
library(odbc)
library(ggplot2)
library(scales)
library(tidyverse)
library(janitor)

rm(list=ls())

hydro_waste <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2022/2022-09-20/HydroWASTE_v10.csv')
hydro_waste <- clean_names(hydro_waste)

hydro_waste$country <- ifelse(hydro_waste$cntry_iso =="CIV","Ivory Coast",hydro_waste$country) 
hydro_waste$country <- ifelse(hydro_waste$cntry_iso =="CUW","Curaçao",hydro_waste$country)  

## https://db.rstudio.com/databases/microsoft-sql-server/
con <- DBI::dbConnect(odbc::odbc(), 
                      Driver = "SQL Server", 
                      Server = "localhost\\SQLEXPRESS", 
                      Database = "TidyTuesday", 
                      Trusted_Connection = "True")

# dbListTables(con)


# USA <- read.csv("../COVID-19-NYTimes-data//us.csv")
# USA$date <- as.Date(USA$date)

dbWriteTable(con, "hydrowaste",hydro_waste ,overwrite=TRUE)
dbListFields(con,"hydrowaste")
