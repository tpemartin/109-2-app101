# 選擇城市後  -->  輸出選擇城市的古蹟 


heritage$show_county <- function(chosen_county){ 
  
  final_result <- list()
  
  for (i in seq_along(heritageData$belongCity)){
    
    if (str_detect(heritageData$belongCity[[i]],pattern=chosen_county)){
    
        heritageData$caseName[[i]] -> final_result[[i]]
      
      
        final_result <- unlist(final_result)
        
        final_result <- final_result[!is.na(final_result)]

        
    }
 
  }
  
  
   return (final_result)
}



---------------

# 再將 heritage$show_country("城市") 的 caseID 取出  --> 儲存至user$sessionData$filtered_data

heritage$filter$countyChosen<- function( data ){
  
      caseId <- list()
  
     for (i in seq_along(data)){
       
       caseId[[i]]<- heritageData$caseId[[i]]
       
     }
  
  return(caseId)
      
}



heritage$show_county(chosen_county ) -> user$sessionData$county_chosen


user$sessionData$filtered_data <-  
  
  append(user$sessionData$filtered_data,heritage$filter$countyChosen(user$sessionData$county_chosen))



# helper 1.1   caseName 

user$sessionData$county_chosen


# helper 1.2  caseId

user$sessionData$filtered_data





