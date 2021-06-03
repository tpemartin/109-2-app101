
show_county = function(){
  counties <- 
    stringr::str_extract(unique(heritage[["data"]][["belongCity"]]), "^.{2}[縣市]")
  countyList <- unique(counties[which(counties != "")])
  county_enumerates <- paste(
    paste(seq_along(countyList), countyList, sep = ": "), collapse = "\n")
  county_enumerates
  rstudioapi::showPrompt(
    title ="select",
    message=
      paste0("選擇縣市數字:\n",county_enumerates)
  ) -> countyNumberChosen
  as.integer(stringr::str_extract(countyNumberChosen, "[0-9]+")) -> 
    whichCounty
  countyList[[whichCounty]] -> .countyChosen
  return(.countyChosen)
}
countyChosen <- function(countyChosen){
  whichBelong2Chosen <- which(heritage$data$county == countyChosen)
  heritage$data$caseId[whichBelong2Chosen]
}

#' Validate check-in GPS 
#'
#' @param returnedGPS 
#'
#' @return
#' @export
#'
#' @examples 
#'   returnedGPS <- heritage$data$GPS$gps[3,]
#'   validate_checkIn(returnedGPS)
validate_checkIn <- function(returnedGPS){
  meters <-
    sp::spDistsN1(
      heritage$GPS$gps, returnedGPS
    ) * 1000
  whichLess100m <- which(
    meters <= 100 )  
  if(length(whichLess100m)==0){
    return(NULL)
  } else {
    return(
      list(
        timestamp = lubridate::format_ISO8601(
          lubridate::now()),
        caseId = heritage$GPS$caseId[whichLess100m]
        ))
  }
}
#' Process list_tracks
#'
#' @param list_tracks 
#'
#' @return
#' @export
#'
#' @examples
#' trackX <- list_tracks[[1]]
#' process_oneTrack(trackX) -> outputX
#' track(list_tracks) -> output
track <- function(list_tracks){
  purrr::map(
    list_tracks,
    process_oneTrack
  )
}
process_oneTrack <- function(trackX){
  returnedList <- list(
    timestamp = lubridate::Date(0),
    trace = matrix(),
    caseId = character(0)
  )
  
  returnedList$trace <- as.matrix(trackX[c("lon","lat")])
  returnedList$timestamp <- 
    lubridate::date(
      min(lubridate::ymd_hms(trackX$time))
    )
  
  returnedList$caseId <- {
    purrr::map(
      seq_along(trackX$lon),
      ~{
        validate_checkIn(
          as.numeric(trackX[.x, c("lon","lat")])
        )
      }
    ) -> list_checkIns
    purrr::map(
      list_checkIns,
      purrr::pluck, "caseId"
    ) -> list_caseIds    
    unique(unlist(list_caseIds))
  }
  
  return(returnedList)
}
