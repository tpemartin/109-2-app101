---
title: "Untitled"
output: html_document
---

```{r setup, include=FALSE}
knitr::opts_chunk$set(echo = TRUE)
```

```{r cars}
summary(cars)
```

```{r}
# 中文西元年 --> 數字西元年 

chinese_to_ad <- function(chinese_year){
  
num_year <- c(0,0,0,0,1,2,3,4,5,6,7,8,9," ")

names(num_year) <- c("O","0","○","０","一","二","三","四","五","六","七","八","九","年")

 return(str_replace_all(chinese_year,pattern=num_year))  
  
}


chinese_to_ad("一八九五")


```


```{r}


library(stringr)

# function  民國年  --> 西元年

minguo_chinese_function <- function(input_minguo){

minguo_chinese_year <- c(1,2,3,4,5,6,7,8,9,"","年")

names(minguo_chinese_year) <- c("一","二","三","四","五","六","七","八","九","十","年")

minguo_number_year <- str_replace_all(input_minguo,pattern=minguo_chinese_year)

only_number_year <- str_extract_all(minguo_number_year,pattern="[0-9]+")


if (str_detect(input_minguo,pattern="民國[一二三四五六七八九]十年")){
  
  ad_num_year <- as.character((as.numeric(only_number_year)*10)+1911)
  
  } 

  else if (str_detect(input_minguo,pattern="民國十[一二三四五六七八九]年")){
  
  ad_num_year <- as.character((as.numeric(only_number_year)+1921))
                              
  } else{

ad_num_year <- as.character(as.numeric(only_number_year)+1911)

 }
  
return(ad_num_year)
  
}


minguo_chinese_function("民國十六年")


```




```{r}

library (stringr)

japan_year <- function(japans_colony) {
  
  japan_era <- "日[治據]時[期代]"
  
  if (str_detect(japans_colony,pattern=japan_era)){
    
   japans_colony <- "1895 - 1945"
   
   return(japans_colony)
}
  
}


japan_year("日據時代")



```

