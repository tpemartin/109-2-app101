read_csv3 <- function(list_farawaySchools, elementNames=NULL) {
  list_dataframes <- vector("list", length(list_farawaySchools))
  for(.x in seq_along(list_farawaySchools)){
    list_dataframes[[.x]] <- readr::read_csv(list_farawaySchools[[.x]])
  }
  if(!is.null(elementNames)) names(list_dataframes) <- elementNames
  return(list_dataframes)
}
find_class <- function(dfX) {
  purrr::map_chr(
    dfX,
    class
  ) -> class_types
  .GlobalEnv$.summariseDF$class = class_types
}
na_count <- function(dfX){
  purrr::map_int(
    dfX,
    ~sum(is.na(.x))
  ) -> na_count
  .GlobalEnv$.summariseDF$`NA.數目`=na_count
}
row_bind <- function(list_df){
  add_dfID(list_df) -> list_df2
  do.call(dplyr::bind_rows, list_df2) -> binded_df
  return(binded_df)
}
list_seperate <- function(binded_df, vname){
  factor(binded_df[[vname]])-> .fct
  purrr::map(
    levels(.fct),
    ~{
      targetIndices <- which(.fct ==.x)
      binded_df[targetIndices, ]
    }
  ) -> list_dfs
  names(list_dfs) <- paste0(vname,":",levels(.fct))
  return(list_dfs)
}
add_dfID <- function(list_df, sep=NULL){
  names(list_df) -> list_names
  if(!is.null(sep)){
    idName = stringr::str_extract(list_names, ".*(?=:)")
  } else {
    idName = "df_ID"
  }
  purrr::map(
    seq_along(list_df),
    ~{
      if(length(list_names) != length(list_df)){
      # if no list names
        list_df[[.x]][[idName]] <- .x
        list_df[[.x]]
      } else {
        if(!is.null)
        list_df[[.x]][[idName]] <- list_names[[.x]]
        list_df[[.x]]
      }
    }
    
  ) -> list_df2
  return(list_df2)
}