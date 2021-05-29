
# 05-27 backend

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

if(!is.null(checkInResult))
  user$checkIns <- append(
    user$checkIns, list(checkInResult)
  )
library(sp)
spDistsN1(pts = ma, pt = ma2 , TRUE)



matrix(
  c(24.94,returnedGPS[1],121.37,returnedGPS[2]),
  nrow=2
) -> ma

matrix(
  c(10,120),
  nrow=2
) -> ma1

matrix(
  c(24.94,121.37),
  nrow=2
) -> ma2


matrix(1:9, nrow = 3, ncol = 3)

matrix()
as.matrix(returnedGPS) -> matrix_gps2
spDistsN1(pts = (24.94 : 121.37), pt = (24.95 , 122.38) , )
spDistsN1(pts = matrix_gps1 , pt= (24,120), TRUE)

# track -------------------------------------------------------------------
# when user turn on tracking in the frontend, user's phone will track his GPX 
source(
  file.path(.root(),"R/field_trips_all.R"), 
)
# return user's list_tracks


heritage$track(list_tracks) -> 
  newTraces
# where newTraces is a list of length(list_tracks) for element 1, it transform list_trackes[[1]]
list_tracks[[1]][c("lon","lat")] -> trace1
newTraces <- list()
# newTraces[[1]] <- 
#   list(
#     timestamp=date of visit
#     trace=trace1,
#     caseId=
#   )

user$visits <- append(
  urser$visits, newTraces
)