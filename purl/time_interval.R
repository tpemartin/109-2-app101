## ----------------------------------------------------------------
xfun::download_file("https://www.dropbox.com/s/vt10xxig64levmj/list_heritageYears.json?dl=1", mode="wb")
list_heritageYears <- jsonlite::fromJSON("list_heritageYears.json")


## ----------------------------------------------------------------
.root <- rprojroot::is_rstudio_project$make_fix_file()
source( 
  file.path(.root(),"weekly_progress/Simmons/chinese_martin.R"),
  encoding="UTF-8"
  )
chinese$convert_minguo2western("民國卅七年")



## ----------------------------------------------------------------

length(list_heritageYears[[1]])


list_heritageYears[[1]]

View(list_heritageYears)




## ----------------------------------------------------------------

purrr::map(
  list_heritageYears,
  ~{
    chinese$convert_minguo2western(.x)
browser()
    
  }
) -> list_heritageYears_abnormal






## ----------------------------------------------------------------

chinese$convert_minguo2western(list_heritageYears[[60]][1])




## ----------------------------------------------------------------
purrr::map(
  list_heritageYears,
  ~{
    chinese$convert2westernYears(.x)
 

    
  }
) -> list_heritageYears_converted






## ----------------------------------------------------------------
debug(chinese$convert_minguo2western)
chinese$convert_minguo2western("民國卅七年")



## ----------------------------------------------------------------
chinese$convert2westernYears(list_heritageYears[[1]])

ans <- str_which(list_heritageYears[[9]], pattern_mingou)

ans


## ----------------------------------------------------------------

pattern_mingou <- "民國"
pattern_chnWestern <- "一[○Ｏ０O0一二三四五六七八九十]{3}"   #更改這行
pattern_jpn <- "日[治據]時[期代]"

library(stringr)

for (i in 1:length(list_heritageYears)){
  
  if (length(list_heritageYears[[i]])>0){
    
  
    list_heritageYears[[i]][str_detect(list_heritageYears[[i]],pattern_mingou)]<-chinese$convert2westernYears(list_heritageYears[[i]][str_which(list_heritageYears[[i]], pattern_mingou)]) 
    
    
    list_heritageYears[[i]][str_detect(list_heritageYears[[i]],pattern_chnWestern)]<-chinese$convert2westernYears(list_heritageYears[[i]][str_which(list_heritageYears[[i]], pattern_chnWestern)]) 
    
    list_heritageYears[[i]][str_detect(list_heritageYears[[i]],pattern_jpn )]<-chinese$convert2westernYears(list_heritageYears[[i]][str_which(list_heritageYears[[i]],pattern_jpn)]) 
    
    
  }
  
}


View(list_heritageYears)





## ----------------------------------------------------------------

for (i in seq_along(list_heritageYears)){
  
  if (length(list_heritageYears[[i]])!=0){
    
  
  list_heritageYears_changed <-chinese$convert2westernYears (list_heritageYears[[i]][seq_along(list_heritageYears[[i]])])}
  
}







## ----------------------------------------------------------------

library(knitr)

purl("time_interval.Rmd")





## ----------------------------------------------------------------
#' 找出時間點或時間區間有交集的古蹟
#'
#' @param list_heritageYears_converted a list of strings.
#' @param start a character of starting year
#' @param end a character of ending year. if NA, means until now
#'
#' @return integers showing the indices of heritage that fit the criterion
#' @export
#'
#' @examples
filter_heritage <- function(list_heritageYears_converted, start, end=NA){
  
  return(index_fits)
}




## ----------------------------------------------------------------
convert_minguo2western("民國五十八年")


## ----------------------------------------------------------------
#' 列出自何時以後存在的古蹟index
#'
#' @param list_heritageYears_converted 
#' @param since an integer of year
#'
#' @return
#' @export
#'
#' @examples
exist_since <- function(list_heritageYears_converted, since){
  
  return(index_fits)
}
#' 列出在何時之前就存在的古蹟index
#'
#' @param list_heritageYears_converted 
#' @param before an integer of year
#'
#' @return
#' @export
#'
#' @examples
exist_before <- function(list_heritageYears_converted, before){
  
  return(index_fits)
}


## ----------------------------------------------------------------

purrr::map(c(2,3,4,5,6),~{3+.x})-> ans 

ans



## ----------------------------------------------------------------


View(list_heritageYears)


## ----------------------------------------------------------------
help(plot)


