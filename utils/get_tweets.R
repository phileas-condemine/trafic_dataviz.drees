# options(encoding="UTF-8")

## install rtweet from CRAN
# install.packages("rtweet")

## load rtweet package
library(rtweet)
library(lubridate)
library(magrittr)
library(dplyr)


# my_token=get_token()
# save(my_token,file="my_token.RData")
if(!interactive()){
  setwd("C:/Users/phileas.condemine/Documents/dataviz.drees_consultations_GAnalytics/")
}
load("my_token.RData")
keywords = readLines("tweets_keywords.txt",encoding="UTF-8")

tweets = lapply(keywords,function(keyword){
  tweets_ = search_tweets(keyword,include_rts = F,n = 10000,token = my_token)
  print(keyword);print(dim(tweets_))
  Sys.sleep(1)
  return(tweets_)
})
tweets_drees = do.call("rbind",tweets)
tweets_drees%<>%filter(lang=="fr")
# tweets_drees%<>%filter(grepl(pattern = "drees",ignore.case = T,x = text))


save(tweets_drees,file = sprintf("tweet_history/tweets_drees%s.RData",Sys.Date()))
print("DONE !")
print("dim : ")
print(dim(tweets_drees))
Sys.sleep(5)
# https://stackoverflow.com/questions/2793389/scheduling-r-script
# planificateur de tâches > créer une tâche > C:\Users\phileas.condemine\Documents\R\R-3.5.3\bin\Rscript.exe C:\Users\phileas.condemine\Documents\dataviz.drees_consultations_GAnalytics\get_tweets.R


