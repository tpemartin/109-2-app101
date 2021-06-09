library(dplyr)
library(ggplot2)
library(plotly)
library(leaflet)
.root <- rprojroot::is_rstudio_project$make_fix_file()
destfile <- 
  file.path(
    .root(), "weekly_progress/martin/heritageDataRevised.Rdata"
  )
if(!file.exists(destfile)){
  xfun::download_file("https://www.dropbox.com/s/2rryka3cprtgfok/heritageDataRevised.Rdata?dl=1", mode="wb",
    output=destfile)
}

load(destfile)

# define user, heritage structure

## define complete structure

# structure: heritage -----------------------------------------------------
# heritage$show_county()
# heritage$filter$countyChosen()
# heritage$game$puzzle_guess() 
# heritage$validate_checkIn()
# heritage$track()

  
heritage <-
  list(
    data = heritageData,
    show_county = function(){},
    filter = list(
      countyChosen = function(){}
    ),
    game = list(
      puzzle_guess = function(){}
    ),
    track = function(){}
  )


heritage$data <- heritageData

heritage$data$county <- stringr::str_extract(
  heritage$data$belongCity, "^.{2}[縣市]"
)
heritage$data[c("longitude","latitude")] -> heritageGPS
whichAreNotNA <- 
  which(!is.na(heritageGPS$longitude) & !is.na(heritageGPS$latitude))
heritage$GPS <-  
  list(
    caseId = heritage$data$caseId[whichAreNotNA],
    gps = as.matrix(heritageGPS[whichAreNotNA,])
  )
# structure: user ---------------------------------------------------------

# ##
# user$sessionData$county_chosen
# user$sessionData$filtered_data
# user$sessionData$game$puzzle_guess
# user$sessionData$game$puzzle_guess
# user$visits

user <- list(
  sessionData = list(
    county_chosen=list(),
    filtered_data=list(),
    game=list(
      puzzle_guess=list()
    )
  ),
  visits = list()
)


# Source functions --------------------------------------------------------

source(
  file.path(
    .root(), 
    "weekly_progress/martin/heritage_martin.R"
  )
)

# attach functions
heritage$show_county <- show_county
heritage$filter$countyChosen <- countyChosen
heritage$validate_checkIn <- validate_checkIn
heritage$track <- track

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
returnedGPS = c(lon=24.94, lat=121.37)
heritage$validate_checkIn(returnedGPS) -> checkInResult
# which check if the returnGPS is within 100 meters of any heritage site, 
# If not, checkInResult = NULL;
# If yes, 
# checkInResult = list(
#   timestamp= a string of ISO8601 time when the user checks in,
#   caseId= the closest site's caseId
# )
# sp::spDistsN1 can calculate km distance for you


if(!is.null(checkInResult))
user$checkIns <- append(
  user$checkIns, list(checkInResult)
)


# track -------------------------------------------------------------------
# when user turn on tracking in the frontend, user's phone will track his GPX 
# source(
#   file.path(.root(),"R/field_trips_all.R")
# )
load(
  file.path(.root(),"weekly_progress/martin/list_tracks.Rdata")
)
# return user's list_tracks
heritage$track(list_tracks) -> 
  newTraces


user$visits <- append(
  user$visits, newTraces
)
