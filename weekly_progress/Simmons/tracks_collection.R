
# organize five tracks in list_tracks，then output list_tracks[[1]]  (lon,lat)

heritage$track <- function(list_tracks){
  
gpx_data <- list()
  
for (i in seq_along(list_tracks)){
  
  gpx_data$timestamp[[i]] <- list_tracks[[i]]["time"]
  
  gpx_data$tracks[[i]] <- list_tracks[[i]][c("lon","lat")]
  
}
  
return(gpx_data$tracks[[1]])

}

#    ------------- check (heritage$track)


# caseName

user$sessionData$county_chosen


#caseId

user$sessionData$filtered_data


-----------------------


# collect new Traces from one of five tracks in list_tracks randomly


newTraces<- function( list_tracks ){
  
  library(stringr)

  
gpx_data_visit <- list()
  
random <- sample(c(1:5),1)

for (i in seq_along(list_tracks[[random]][["lon"]])){
  
  gpx_data_visit$timestamp<- append(gpx_data_visit$timestamp,list_tracks[[random]]["time"][i,])
  
  gpx_data_visit$tracks<- append(gpx_data_visit$tracks,list_tracks[[random]][c("lon","lat")][i,])
  
}


gpx_track_lon <- list_tracks[[random]][["lon"]]


gpx_track_lat <- list_tracks[[random]][["lat"]]



returnedGPS_tracks <- list()


for ( i in seq_along(gpx_track_lon)){
  
  returnedGPS_tracks[[i]] <- c(lon=gpx_track_lon[[i]],lat=gpx_track_lat[[i]])

}



record_index <- list()


for ( i in seq_along(returnedGPS_tracks)){

ans_5 <- which.min(sp::spDistsN1(location,returnedGPS_tracks[[i]],longlat=T))

record_index <- append(record_index,ans_5)

}



for (i in seq_along(record_index)){
  
  
 caseId <- heritageData$caseId[[record_index[[i]]]]
 
  gpx_data_visit$caseId <- append(gpx_data_visit$caseId,caseId)
 
  
}


return(gpx_data_visit)


}  
  

newTraces(list_tracks)



# save data to user$visit

user$visits <- append(user$visits,newTraces(list_tracks))

user$visits




# -----------  helper ( user$visits) 

# helper_1 

gps_tracks_random <- function(list_tracks){


random <- sample(1:5,1)


gpx_track_lon <- list_tracks[[random]][["lon"]]


gpx_track_lat <- list_tracks[[random]][["lat"]]


returnedGPS_tracks <- list()



for (i in seq_along (gpx_track_lon)){
  
  returnedGPS_tracks[[i]] <- c(lon=gpx_track_lon[[i]],lat=gpx_track_lat[[i]])
  
}


return(returnedGPS_tracks)


}


# check _ 1
gps_tracks_random(list_tracks)





# helper 2



show_record_index <- function(){

record_index <- list()

for ( i in seq_along(returnedGPS_tracks)){

ans_5 <- which.min(sp::spDistsN1(location,returnedGPS_tracks[[i]],longlat=T))

record_index <- append(record_index,ans_5)

}

return(record_index)

}

# check_2

show_record_index()




# helper 3


record_caseId <- function(){

heritage$caseId <- list()

for (i in seq_along(record_index)){
  
  
 caseId <-  heritageData$caseId[[record_index[[i]]]]
 
  heritage$caseId <- append(heritage$caseId,caseId)
  
}

return(heritage$caseId)


}

# check_3

record_caseId()






