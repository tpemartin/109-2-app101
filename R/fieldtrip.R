fieldtrip <- new.env()
fieldtrip$create_map <- function(heritageData){
  leaflet() %>% addTiles() %>%
    addMarkers(data = heritageData, lng=~longitude, lat=~latitude, popup = ~caseName,
               clusterOptions = markerClusterOptions()) %>%
    addEasyButton(easyButton(
      icon="fa-globe", title="Zoom to Level 1",
      onClick=JS("function(btn, map){ map.setZoom(9); }"))) %>%
    addEasyButton(easyButton(
      icon="fa-crosshairs", title="Locate Me",
      onClick=JS("function(btn, map){ map.locate({setView: true}); }"))) -> fieldtrip$baseMap
  fieldtrip$baseMap
}
fieldtrip$show_path <- function(df_gpx){
  leaflet::addPolylines(
    fieldtrip$baseMap,
    lng=df_gpx$lon,
    lat=df_gpx$lat
  ) %>%
    setView(
      lng=df_gpx$lon[[1]],
      lat=df_gpx$lat[[1]],
      zoom=16
    )
}