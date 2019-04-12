## install rtweet from CRAN
# install.packages("rtweet")

## load rtweet package
library(rtweet)
library(lubridate)
library(magrittr)
library(dplyr)
# tweets_osam=search_tweets("drees santé",include_rts = F,n = 1000)
# tweets_osol=search_tweets("drees solidarité",include_rts = F,n = 1000)

# my_token=get_token()
# save(my_token,file="my_token.RData")
if(!interactive()){
  setwd("C:/Users/phileas.condemine/Documents/dataviz.drees_consultations_GAnalytics/")
}
load("my_token.RData")
tweets_drees=search_tweets("drees",include_rts = F,n = 10000,token = my_token)
tweets_drees%<>%filter(lang=="fr")
tweets_drees%<>%filter(grepl(pattern = "drees",ignore.case = T,x = text))


save(tweets_drees,file = sprintf("tweet_history/tweets_drees%s.RData",Sys.Date()))

# https://stackoverflow.com/questions/2793389/scheduling-r-script
# planificateur de tâches > créer une tâche > C:\Users\phileas.condemine\Documents\R\R-3.5.3\bin\Rscript.exe C:\Users\phileas.condemine\Documents\dataviz.drees_consultations_GAnalytics\get_tweets.R