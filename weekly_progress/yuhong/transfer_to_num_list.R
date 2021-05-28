## 處理非正規書寫西元年份

### 前言

library(purrr)
library(lubridate)
library(stringr)
library(glue)

# chinese number transfer
chinese_number_transfer <- function(origin){
  character_to_number <- c("3","0","0","0":"9","","00","","","","")
  names(character_to_number) <- c("卅","○","O","０","一","二","三","四","五","六","七","八","九","十","百","年","幾","約","餘")
  str_replace_all(origin,character_to_number)
}

  
  # "民國四十九年" 至　"民國49"
  
  ming_pattern <- "民國[卅０一二三四五六七八九十百O○]+年"
  
  for (x in seq_along(input_list) ){
    
    ming <- str_subset(input_list[[x]], pattern = ming_pattern)
    input_list[[x]][str_detect(input_list[[x]],pattern=ming_pattern)] <-
      chinese_number_transfer(ming)
  }
  
  # "民國49" 至 "1950"
  
  ming_pattern21 <- "民國[0-9]{1,3}"
  ming_pattern22 <- "(?<=民國)[0-9]{1,3}"
  
  for (x in seq_along(input_list) ){
    ming_num <- unlist(str_extract_all(input_list[[x]], ming_pattern22))
    
    input_list[[x]][str_detect(input_list[[x]],pattern=ming_pattern21)] <-
      as.character(as.numeric(ming_num) + 1911)
  }
  
  ### 中文西元年份
  
  xxxx_year <- "一[０O○一二三四五六七八九十]{3}"
  
  for (x in seq_along(input_list) ){
    
    xxxx <- str_subset(input_list[[x]], pattern = xxxx_year)
    
    input_list[[x]][str_detect(input_list[[x]],pattern=xxxx_year)] <-
      chinese_number_transfer(xxxx)
  }
  
  ### 日治時代
  
  jp_period <- "日[治據]時[代期]"
  
  for (x in seq_along(input_list) ){
    
    input_list[[x]][str_detect(input_list[[x]],pattern=jp_period)] <-
      "1895-1945"
  }
