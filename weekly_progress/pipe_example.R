minguo_number <- unlist(stringr::str_extract_all(minguo,pattern2))
minguo_number <- convert_chn2arabics(minguo_number)
minguo_number <- convert_chnten(minguo_number,"^[十][:graph:]","1")
minguo_number <- convert_chnten(minguo_number,"[:graph:][０十]$","0")
minguo_number <- convert_chnten(minguo_number,"[:graph:][０十][:graph:]","")
minguo_number <- convert_chnten(minguo_number,"\\b[十]\\b","10")

# %>% pipe
library(dplyr)

unlist(stringr::str_extract_all(minguo,pattern2)) %>%
  convert_chn2arabics() %>%
  convert_chnten("^[十][:graph:]","1") %>%
  convert_chnten("[:graph:][０十]$","0") %>%
  convert_chnten("[:graph:][０十][:graph:]","") %>%
  convert_chnten("\\b[十]\\b","10")