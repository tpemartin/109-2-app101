# setwd("/Users/frankchao/Desktop/109-2-app101/weekly_progress/frank")
xfun::download_file("https://www.dropbox.com/s/ouurt80t6ailbif/PR0101A2Mc.csv?dl=1", mode="wb")
library(readr)
library(dplyr)
data <- list(
            all = list(),
            select = list(
                        categories = list()
                     )
        )
data$all <- read_csv("PR0101A2Mc.csv",
                locale = locale(encoding = "CP950"),
                skip = 3)

#留下總指數與大類
data$all %>% select(matches("^[一二三四五六七總]")) ->
    data$select$categories$data
data$select$categories$data[1] %>% {which(!is.na(.))} -> rows
data$select$categories$data[rows,] -> data$select$categories$data
#年上漲率
data$select$categories$data %>% 
    mutate_all(
              function(x) {
                  for(rows in seq_along(x)){
                     if(rows<=length(x)-12){
                        (x[rows+12] - x[rows]) / x[rows]*100 -> x[rows]
                     }
                  }
                  x
              }
    )  -> data$select$categories$年上漲率

names(data$all)[1] <- "Y/M"
data$select$categories$年上漲率 <- data$all[-c(1:12,486:494),1] %>% bind_cols(
                                       data$select$categories$年上漲率[c(1:473),]
                                   )
#與總指數變化率的相關係數
data$select$categories$correlation <- data$select$categories$年上漲率 %>% View()
                                         summarise_at(
                                           .vars = c(3:9),
                                           .funs = cor,
                                           y = data$select$categories$年上漲率$總指數
                                         )

data$select$categories$correlation

