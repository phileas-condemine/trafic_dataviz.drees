library(shinydashboard)
library(data.table)
library(readxl)
library(magrittr)
library(dplyr)
library(ggplot2)
library(plotly)
download.file(url = "https://docs.google.com/spreadsheets/d/e/2PACX-1vT-JU2d1E3NmlDZWGXvoPfnNhn_fpRWRcIvBi7okWC6uUuZIP6ijXrhDXv2VUMI5cQw52fOHz65cs1M/pub?output=xlsx",
              destfile="rapports.xlsx", mode = 'wb')
sheets=readxl::excel_sheets("rapports.xlsx")