.root <- rprojroot::is_rstudio_project$make_fix_file()

destfolder <- 
  file.path(.root(),"gpx")
if(length(list.files(destfolder)) ==0){
  destfile = 
    file.path(.root(), "userGPX.zip")
  xfun::download_file(
    "https://www.dropbox.com/s/hrcaa0cqdr2fzk0/GPX-20210526T044452Z-001.zip?dl=1",
    output = destfile,
    mode="wb"
  )
  if(!dir.exists(destfolder)) dir.create(destfolder)
  unzip(destfile, junkpaths = TRUE, exdir=destfolder)
}

list_files <- 
  list.files(path=destfolder, full.names = T)
gpxFiles <- 
  stringr::str_subset(
    list_files, "\\.gpx$"
  )

purrr::map(
  gpxFiles,
  ~{
    plotKML::readGPX(
     .x 
    ) -> dataX
    
    dataX$tracks[[1]][[1]]
  }
) -> list_tracks


