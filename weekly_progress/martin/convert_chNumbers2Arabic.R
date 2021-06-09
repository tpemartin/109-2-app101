chineseNumber1 <- "零一二三四五六七八九十"
chineseNumber2 <- "零壹貳參肆伍陸柒捌玖拾"
chineseNumber1_char <- unlist(stringr::str_split(chineseNumber1,""))
chineseNumber2_char <- unlist(stringr::str_split(chineseNumber2,""))
oldLevels <- c("一", "七", "五", "五十七", "參拾參", "拾壹", "陸拾", "參拾")

split_oldLevels <- {
  stringr::str_split(oldLevels,"")
  stringr::str_extract(oldLevels, "[一二三四五六七八九壹貳參肆伍陸柒捌玖拾][十拾]")
}

.x = 5
split_oldLevelX <- split_oldLevels[[.x]]
split_oldLevelX
