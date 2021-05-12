convert_minguo2western <- function(minguo_string){
  
  # return(westernYearIntegers)
}

convert_chnWesternYears <- function(chnWestYears){
  
  # return(westernYearInteger) 
}

# helpers

convert_chn2arabics <- function(origin, naIs0 = T){
  chineseNumber1 <- "一二三四五六七八九"
  chineseNumber2 <- "壹貳參肆伍陸柒捌玖"
  chineseNumber1_char <- unlist(stringr::str_split(chineseNumber1,""))
  chineseNumber2_char <- unlist(stringr::str_split(chineseNumber2,""))
  
  replacement <- c(rep(as.character(1:9),2), "1")
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