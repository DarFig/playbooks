load.lib<-c("tidyr","tidymodels","tidyverse","vip","visNetwork","writexl","xtable","yardstick", "summarytools","AdhereR","MLmetrics","ISLR","skimr","frequency","ggpubr","themis")
install.lib <- load.lib[!load.lib %in% installed.packages()]
for(lib in install.lib) install.packages(lib,dependencies=TRUE)
sapply(load.lib,require,character=TRUE)
