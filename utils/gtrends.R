
devtools::install_github("PMassicotte/gtrendsR")

install.packages("drat")       # easier repo access + creation
drat:::add("ghrr")             # make it known
install.packages("gtrendsR")   # install it

library(gtrendsR)
library(curl)

h <- new_handle()
req <- curl_fetch_memory("http://apis.google.com/Cookies/OTZ", handle = h)
handle_cookies(h)


setHandleParameters()

gtrends("drees",geo="FR",hl="fr")
gtrends("NHL")
