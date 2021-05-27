## ----setup, include=FALSE------------------------------------------------
knitr::opts_chunk$set(echo = TRUE)


## ------------------------------------------------------------------------
chinese <- list()
minguo_string  =  list_heritageYears[[872]]
chinese$convert_minguo2western <- convert_minguo2western <- function(minguo_string){
      pattern <- "(?<=民國)[0-9○０O一二三四五六七八九十]+"
      minguo  <- stringr::str_subset(minguo_string,pattern)
      pattern2 <- "[0-9○０O一二三四五六七八九十]+"
      minguo_number <- unlist(stringr::str_extract_all(minguo,pattern2))
      minguo_number <- convert_chn2arabics(minguo_number)
      minguo_number <- convert_chnten(minguo_number,"^[十][:graph:]","1")
      minguo_number <- convert_chnten(minguo_number,"[:graph:][０十]$","0")
      minguo_number <- convert_chnten(minguo_number,"[:graph:][０十][:graph:]","")
      minguo_number <- convert_chnten(minguo_number,"\\b[十]\\b","10")
      return(as.character(as.numeric(minguo_number)+1911))
}

chinese$convert_chnWesternYears <- convert_chnWesternYears <- function(chnWestYears){
       pattern <- "[一二][O0○０一二三四五六七八九十]{3}"
       chn_west <- unlist(stringr::str_extract_all(chnWestYears,pattern))
       return(convert_chn2arabics(chn_west))
}


# helpers
is_interger0 <- function(origin){
  return(is.integer(origin) && length(origin)==0)
}

convert_chnten <- function(str,pattern,replacement){
       if(!is_interger0(stringr::str_which(str,pattern=pattern))){
            str[stringr::str_which(str,pattern=pattern)] <-
            str_replace_all(str[stringr::str_which(str,pattern=pattern)],c("十"=replacement))
       }      
       return(str)
}

convert_chn2arabics <- function(origin, naIs0 = T){
  chineseNumber1 <- "０0一二三四五六七八九"
  chineseNumber2 <- "○O壹貳參肆伍陸柒捌玖"
  chineseNumber1_char <- unlist(stringr::str_split(chineseNumber1,""))
  chineseNumber2_char <- unlist(stringr::str_split(chineseNumber2,""))
  
  replacement <- c(rep(c(0,0,as.character(1:9)),2), "1")
  names(replacement) <- c(chineseNumber1_char, chineseNumber2_char, "元")
  
  stringr::str_replace_all(origin, replacement) -> revised
  if(naIs0){
    na_is_0(revised) -> revised
  }
  return(revised)
}
na_is_0 <- function(origin){
  whichIsNA = which(is.na(origin))
  origin[whichIsNA] = "0"
  return(origin)
}

