
# 產生list_tracks[[1]]的 lon=  lat =  串列

gpx_track_lon <- list_tracks[[1]][["lon"]]


gpx_track_lat <- list_tracks[[1]][["lat"]]


returnedGPS_tracks <- list()

for (i in seq_along (gps_tracks_lon)){
  
  returnedGPS_tracks[[i]] <- c(lon=gps_tracks_lon[[i]],lat=gps_tracks_lat[[i]])
  
}

 print(returnedGPS_tracks)
 
 
 
 
 # 跑出caseID，可能是RETURN有錯
 
detect_spot <- function(returnedGPS_tracks ){
  
  for (i in seq_along(returnedGPS_tracks)){
 
if(T %in% (sp::spDistsN1(location,returnedGPS_tracks[[i]],longlat=T) <= 0.05)){
                return(
                      list(
                          caseId = {
                                     which.min(sp::spDistsN1(location,returnedGPS_tracks[[i]],longlat=T)) -> index
                                     heritageData$caseId[index]
                                   }
                      )
                )
         }else{
                return(NULL)
         }
  
  
}
  
}

detect_spot(returnedGPS_tracks)
 
 

 
