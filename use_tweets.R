library(data.table)
library(stringi)
library(stringr)
load("tweet_history/tweets_drees2019-04-11.RData")




mots_clefs=c("dépendance","domicile","santé","âgées","ehpad","solidarité","ehpa","hôpital","hôpitaux","hospitalier")
mots_clefs=stri_trans_general(mots_clefs, "Latin-ASCII")



texte=tweets_drees$text
texte=gsub('[[:punct:] ]+',' ',texte)
texte=gsub('(^ )|( $)','',texte)
texte=gsub('\n',' ',texte)


fwrite(x = list(paste(texte,collapse = " azerty ")),"tweets.txt")
readLines("tweets.txt",n = 3,encoding = "UTF-8")
system.time(system("tag-french tweets.txt > tweets_treed.txt")) 
tweets_parsed=fread("tweets_treed.txt",fill=T,header=F,encoding = "UTF-8")
names(tweets_parsed) <- c("mot_original","type_de_mot","mot_lemme")
head(tweets_parsed,10)
tail(tweets_parsed,10)
tweets_parsed=tweets_parsed[-nrow(tweets_parsed),]# on supprime la dernière ligne, pas besoin du dernier séparateur.
tweets_parsed%>%filter(mot_lemme=="@card@")%>%head
tweets_parsed%>%filter(type_de_mot=="SENT")%>%head
ajustement_text=tweets_parsed%>%
  filter(!type_de_mot%in%c("PUN","SENT"))%>%
  mutate(text_ajuste=ifelse(type_de_mot=="NUM",mot_original,mot_lemme))
big_txt=paste(ajustement_text$text_ajuste,collapse=" ")
split_txt=strsplit(big_txt,split = "azerty")
# split_txt=iconv(unlist(split_txt),'UTF-8','latin1')
split_txt=stri_trans_general(unlist(split_txt), "Latin-ASCII")
head(sample(split_txt))
tweets_drees$text=tolower(split_txt)

# ...
# modélisation du nombre de fav ou retweet ? puis du nombre de connection shinyapps.io ! pour cela il faudra du recul.

summary(tweets_drees$created_at)

