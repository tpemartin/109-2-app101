library(dplyr)
library(lubridate)
library(stringr)

create_interval <- function(start,end){
      flag = F
      if("1895-1945" %in% start){
          start <- start[start!="1895-1945"] 
          end <- end[end!="1895-1945"] 
          flag = T
      }    
      # 判斷是否只有"1895-1945"
      if(!is.na(start[1])){
          convert_yerar_to_ymd(start) -> start
          if(is.na(end[1])){
                end <- "2021"
                convert_yerar_to_ymd(end) -> end
          }else{
                convert_yerar_to_ymd(end) -> end
          }
          interv <- interval(start,end)
          if(flag) interv[length(interv)+1] <- interval("1895:01:01","1945:01:01")
          return(interv)
      }else{
          return(interval("1895:01:01","1945:01:01"))
      }
}


find_ListObject_within_interval <- function(list,.interval){
      purrr::map(
          seq_along(list),
          ~{
            if(length(list[[.x]])!=0){
                  int_overlaps(create_interval(list[[.x]],list[[.x]]),.interval) %>% 
                  which %>% is_integer0(TRUE)
            }else{
                  FALSE
            }
          }
      )   %>% unlist -> position
      return(position)
}

# helpers

is_integer0 <- function(origin,reversed = FALSE){
     if(reversed){
        return(!(is.integer(origin) && length(origin)==0))
     }
     return(is.integer(origin) && length(origin)==0)
}

convert_yerar_to_ymd <- function(year){
  paste0(year,":01:01") %>% ymd -> .ymd
  return(.ymd)
}
