# chinese number transfer
chinese_number_transfer <- function(origin){
  character_to_number <- c("3","0","0","0":"9","","00","","","","")
  names(character_to_number) <- c("卅","○","O","０","一","二","三","四","五","六","七","八","九","十","百","年","幾","約","餘")
  str_replace_all(origin,character_to_number)
}
