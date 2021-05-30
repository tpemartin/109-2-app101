
# 05-27 backend

library(dplyr)
library(ggplot2)
library(plotly)
library(leaflet)
.root <- rprojroot::is_rstudio_project$make_fix_file()
xfun::download_file("https://www.dropbox.com/s/2rryka3cprtgfok/heritageDataRevised.Rdata?dl=1", mode="wb")
load("heritageDataRevised.Rdata")


# define user, heritage structure

## define complete structure
user <- list()
heritage <-
  list(
    data = heritageData,
    show_county = function(){},
    filter = list(
      countyChosen = function(){}
    ),
    game = list(
      puzzle_guess = function(){}
    )
  )

##
heritage$show_county <-
  heritage$filter$countyChosen <- 
  heritage$game$puzzle_guess <- 
  
  
  # show by county --------------------------------------------
# App function: user wants to zoom into map that shows only the point of interests belong to certain county
# when select choose by county on APP, it calls
heritage$show_county() -> user$sessionData$county_chosen
# which returns a character vector of counties on screen
#  1. prompt names of counties that he can choose on screen
#  2. once chosen, return user's choice and save in the according object element

# Then program continues
heritage$filter$countyChosen(user$sessionData$county_chosen) -> 
  user$sessionData$filtered_data

# countyChosen returns caseIds that fit the chosen criterion.
# The backend return user$sessionData$filtered_data to the frontend which will redraw the map

# play puzzle -------------------------------------------------------------
# when user selects play puzzle guess, it calls
heritage$game$puzzle_guess() -> game_result
# the return is a list of elements: 
#  timestamp=a character of ISO8601 time when the user starts to play
#  answer=a caseId of correct answer
#  options=a character vector of caseIds of heritage options
#  and user_choice=a caseId of user's choice among options
# game_result$timestamp
# game_result$answer
# game_result$options
# game_result$user_choice

# record result
user$sessionData$game$puzzle_guess <- 
  append(
    user$session$game$puzzle_guess,
    list(game_result)
  )


# check in ----------------------------------------------------------------
# user check in in the webapp UI, 
browseURL("https://tpemartin.github.io/109-2-app101/checkin")
# the frontend returns a numeric vector of GPS
# c(latitude=..., longitude=...)
returnedGPS = c(lon=24.8, lat=121)
heritage$validate_checkIn(returnedGPS) -> checkInResult
# which check if the returnGPS is within 100 meters of any heritage site, 
# If not, checkInResult = NULL;
# If yes, 
# checkInResult = list(
#   timestamp= a string of ISO8601 time when the user checks in,
#   caseId= the closest site's caseId
# )
# sp::spDistsN1 can calculate km distance for you

## 目標
heritage$validate_checkIn(returnedGPS) -> checkInResult

# 資料引入
returnedGPS = c(lon=24.8, lat=121)
xfun::download_file("https://www.dropbox.com/s/2rryka3cprtgfok/heritageDataRevised.Rdata?dl=1", mode="wb")
load("heritageDataRevised.Rdata")


# function 上

heritage$validate_checkIn <- function(returnedGPS){

  ## 整理資料

  library(sp)
  library(lubridate)
  library(purrr)
  checkInResult <- list()

  ### 1 returnedGPS 經緯互換
  c(returnedGPS[2],returnedGPS[1]) -> returnedGPS

  # for 上
  
  for (.x in seq_along(heritageData$caseId)) {
    
    # 拒絕處理 NA
    if(!is.na(heritageData$longitude[.x]) && !is.na(heritageData$latitude[.x])){
    
      ### 2 作成計算用矩陣
    
      matrix(
        c(heritageData$longitude[.x], returnedGPS[1], heritageData$latitude[.x], returnedGPS[2]),
        2
      ) -> test_matrix
      
    }
    
    ## 計算與判斷
    spDistsN1(pts = test_matrix, pt = test_matrix[1,] , TRUE)[2] -> distance
    
    if(distance <= 0.1){
      checkInResult <- append(
        checkInResult,
        list(
        timestamp = now(),
        caseId = heritage$data$caseId[.x]
      ) 
           )
    }
  # for 下
  }
  
  if(length(checkInResult) == 0){
    checkInResult <- NULL
  }

return(checkInResult)
# function 下
}

heritage$validate_checkIn(c(23.4815,120.4508))
heritage$validate_checkIn(c(23.4815,120.4508)) -> checkInResult

# 不確定要不要放
# if(!is.null(checkInResult)){
#   user$checkIns <- append(
#     user$checkIns,
#     list(checkInResult)
#   )
# }

# track -------------------------------------------------------------------
# when user turn on tracking in the frontend, user's phone will track his GPX 
source(
  file.path(.root(),"R/field_trips_all2.R"), 
  encoding = "UTF-8"
)
# return user's list_tracks


heritage$track(list_tracks) -> 
  newTraces
# where newTraces is a list of length(list_tracks) for element 1, it transform list_trackes[[1]]

heritage$track <- function(list_tracks){
  
  newTraces <- list()
  
  for (.x in seq_along(list_tracks)) {
    
    list_tracks[[.x]][c("lon","lat")] -> trace1
    list_tracks[[.x]]["time"][1,] -> start_time
    list_tracks[[.x]]["time"][nrow(list_tracks[[.x]]["time"]),] -> end_time
    
    newTraces[[.x]] <- 
      list(
        timestamp=c(start_time,end_time),
        trace=trace1,
        caseId=
          heritage$validate_checkIn(
            c(
              as.numeric(trace1[1,]["lat"]), 
              as.numeric(trace1[1,]["lon"])
            )
          )$caseId
      )
       
    
  }
  return(newTraces)
}




user$visits <- append(
  urser$visits, newTraces
)
