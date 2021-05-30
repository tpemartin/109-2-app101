install.packages(
  c("googledrive")
)
remotes::install_github("tpemartin/econR", force=TRUE)

.root <- rprojroot::is_rstudio_project$make_fix_file()
destfolder <- 
  file.path(.root(),"gpx")
googleSharedLink <- "https://drive.google.com/drive/folders/1eAE2V023moMhWqnelGRSRTUsub5mYDKZ?usp=sharing"

econR::googleLink_download(
  googleSharedLink = googleSharedLink,
  destfolder = destfolder
)

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

