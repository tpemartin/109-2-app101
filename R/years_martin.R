#' 找出時間點或時間區間有交集的古蹟
#'
#' @param list_heritageYears_converted a list of strings.
#' @param start a character of starting year
#' @param end a character of ending year. if NA, means until now
#'
#' @return integers showing the indices of heritage that fit the criterion
#' @export
#'
#' @examples
filter_heritage <- function(list_heritageYears_converted, .start, .end=NA){
  
  list_heritageYears_converted %>%
    convertListYears2YearsWithHeritageIndexName() -> 
    heritageYears_indexed
  
  start_date = convert2_yyyy0101(.start)
  flag_endNA = is.na(.end)
  end_date = ifelse(
    flag_endNA, Inf, convert2_yyyy0101(.end)
  )  
  
  flag_covertJpnRuling <- is.japanRulingPeriod(start_date, end_date)
  
  .end = ifelse(is.na(.end), Inf, .end)
  whichFitsCriterion <- 
    which(heritageYears_indexed$NotJp_ruled_years_indexed >= .start &
        heritageYears_indexed$NotJp_ruled_years_indexed <= .end)
  names(heritageYears_indexed$NotJp_ruled_years_indexed)[whichFitsCriterion] %>%
    as.integer() ->
    index_heritage
  index_fits <- 
    unique(
      c(
        if(flag_covertJpnRuling) heritageYears_indexed$JP_ruled else NULL,
        if(length(index_heritage)!=0) heritageData$caseId[index_heritage] else NULL
      ))
  
  return(index_fits)
}


generate_filter_heritage <- function(list_heritageYears_converted){
  list_heritageYears_converted %>%
    convertListYears2YearsWithHeritageIndexName() -> 
    heritageYears_indexed
  
  filterFunction <- function(.start, .end=NA){
    start_date = convert2_yyyy0101(.start)
    flag_endNA = is.na(.end)
    end_date = ifelse(
      flag_endNA, Inf, convert2_yyyy0101(.end)
    )  
    
    flag_covertJpnRuling <- is.japanRulingPeriod(start_date, end_date)
    
    .end = ifelse(is.na(.end), Inf, .end)
    whichFitsCriterion <- 
      which(heritageYears_indexed$NotJp_ruled_years_indexed >= .start &
          heritageYears_indexed$NotJp_ruled_years_indexed <= .end)
    names(heritageYears_indexed$NotJp_ruled_years_indexed)[whichFitsCriterion] %>%
      as.integer() ->
      index_heritage
    index_fits <- 
      unique(
        c(
          if(flag_jpnperiod) heritageYears_indexed$JP_ruled else NULL,
          if(length(index_heritage)!=0) heritageData$caseId[index_heritage] else NULL
        ))
    
    return(index_fits)
  }
  return(filterFunction)
}

# helpers -----------------------------------------------------------------



#' Unlist a list with source indices as element names in the unlisted vector
#'
#' @description Unlist a list as a vector with each element named according to the index of the source list where the element value comes from
#' @param source_list
#' @return
#' @export
#'
#' @examples none
unlist_withSourceIndexAsElementName <- function(source_list){
  seq_along(source_list) %>%
    purrr::map(
      ~{
        yearsX <- 
          unique(source_list[[.x]])
        names(yearsX)=rep(as.character(.x), length(yearsX))
        yearsX
      }
    ) -> named_list
  
  unlist(named_list) -> named_vector
  
  return(named_vector)
}
convertListYears2YearsWithHeritageIndexName <-
  function(list_heritageYears_converted){
    # Give years value corresponding heritage index name 
    list_heritageYears_converted %>%
      unlist_withSourceIndexAsElementName() -> named_years
    
    whichAreJpnPeriod <- which(named_years == "1895-1945")
    whichAreNotJpnPeriod <- which(named_years != "1895-1945")
    
    # 日據時期heritage index 
    index_jpnHeritages <- 
      names(named_years[whichAreJpnPeriod])
    
    # 非日據時期書寫方式之年份
    years_notJpn <- 
      named_years[whichAreNotJpnPeriod] 
    integer_years_notJpn <-  as.integer(years_notJpn)  
    names(integer_years_notJpn) <- names(years_notJpn)
    
    heritageYears_indexed <- 
      list(
        JP_ruled = index_jpnHeritages,
        NotJp_ruled_years_indexed = sort(integer_years_notJpn)
      )
    return(heritageYears_indexed)
  }
convert2_yyyy0101 <- function(x) ymd(paste(x,"01-01", sep = "-"))
is.japanRulingPeriod <- function(start_date, end_date){
  jpn_start <- ymd("1895-01-01")
  jpn_end <- ymd("1945-01-01")
  jpn_period <-  jpn_start %--% jpn_end
  flag_jpnperiod <- 
    jpn_period %within% (start_date %--% end_date)

  return(flag_jpnperiod)
}
get_minYears <- function(list_heritageYears_converted){
  minYears <- vector("integer", length(list_heritageYears_converted))
  for(.i in seq_along(list_heritageYears_converted)){
    .x <- list_heritageYears_converted[[.i]]
    .x_nonJpn <- as.integer(.x[which(.x!="1895-1945")])
    minYears[[.i]] <- 
      ifelse(
        length(.x_nonJpn)==0, NA,
        min(na.omit(.x_nonJpn), na.rm=T)
      )
  }
  return(minYears)
}
