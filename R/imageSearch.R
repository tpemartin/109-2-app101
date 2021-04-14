library(httr)
response <- GET("https://memory.culture.tw/Home/Result?Keyword=%E9%BE%8D%E5%B1%B1%E5%AF%BA")
response$status_code
httr::content(response) -> response_content
library(xml2)
class(response_content)
library(dplyr)
response_content %>%
  xml2::xml_child(2) -> x
xlist <- xml2::as_list(x)

i = 1
x %>%
  xml2::xml_child(1) %>%
  xml2::xml_text()

x %>%
  xml2::xml_find_all(xpath = 
                       '//*[contains(concat( " ", @class, " " ), concat( " ", "listTit", " " ))]')
x %>%
  XML::
  xml2::xml_find_all(xpath='//li[(((count(preceding-sibling::*) + 1) = 1) and parent::*)]//a | //*[contains(concat( " ", @class, " " ), concat( " ", "photo", " " ))]//>//img')

selectr::querySelectorAll(
  x, "li:nth-child(1) a , .photo > img"
) -> all_imgs

all_imgs[[19]] %>% xml2::xml_attr("src") %>% browseURL()