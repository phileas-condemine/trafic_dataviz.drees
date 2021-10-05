library(shiny)
library(shinydashboard)
library(data.table)
library(readxl)
library(magrittr)
library(dplyr)
library(bsplus)
library(shinycssloaders)
library(dygraphs)


download.file(url = "https://docs.google.com/spreadsheets/d/e/2PACX-1vT-JU2d1E3NmlDZWGXvoPfnNhn_fpRWRcIvBi7okWC6uUuZIP6ijXrhDXv2VUMI5cQw52fOHz65cs1M/pub?output=xlsx",
              destfile="data/rapports.xlsx", mode = 'wb')
sheets=readxl::excel_sheets("data/rapports.xlsx")
sheets=setdiff(sheets,c("Report Configuration","APL"))


sheet_example=sample(sheets,1)
data=data.table(Date=seq.Date(as.Date("2018-01-01"),Sys.Date(),1))
for (sheet in sheets){
  rapport=readxl::read_xlsx("data/rapports.xlsx",sheet=sheet)
  rapport=rapport[-c(1:13),]
  names(rapport) <- rapport[1,]
  rapport=rapport[-c(1),]
  rapport %<>% mutate(Date=as.Date(as.numeric(Date),origin = "1899-12-30"),Users=as.numeric(Users),app=sheet)
  rapport=rapport[cumsum(rapport$Users)>0,]
  rapport=data.table(rapport)
  setnames(rapport,"Users",rapport$app[1])
  rapport$app=NULL
  data=merge(data,rapport,by="Date",all.x=T,all.y=T)
  }


