plot_inflations <- function(list_dfInflations, totalName = "總項目"){
  require(plotly)
  plotly::plot_ly() %>%
    plotly::add_lines(
      data=list_dfInflations$df_inflation_long_subcategories,
      x=~年, y=~上漲率, split=~項目, line = list(width=1, dash="dot"), #, color=I("grey")
    ) %>%
    plotly::add_lines(
      data=list_dfInflations$df_inflation_long_total,
      x=~年, y=~上漲率, color=I("dodgerblue3"), line = list(width=3), name="總項目"
    ) %>%
    plotly::rangeslider()
}

extractInflationDataFrame <- function(sheet_price2, totalName="總指數"){
  names(sheet_price2)[[1]] <- "年"
  numberOfRows <- nrow(sheet_price2)
  # browser()
  sheet_price2 %>%
    mutate(
      across(
        .cols=everything(),
        .fns=unlist
      )
    ) %>%
    mutate(
      across(
        .fns=as.numeric
      )
    ) %>% 
    na.omit() -> sheet_price2
  df_inflation0 <- (sheet_price2[2:numberOfRows, -1] - sheet_price2[1:(numberOfRows-1),-1])/ sheet_price2[1:(numberOfRows-1),-1] *100
  df_inflation0$年=sheet_price2$`年`[2:numberOfRows]
  df_inflation0 <- dplyr::relocate(df_inflation0, 年) 
  df_inflation_long <- tidyr::pivot_longer(
    df_inflation0,
    cols=-年,
    names_to="項目", values_to = "上漲率"
  )
  levelSeq <- unique(df_inflation_long$項目)
  df_inflation_long$項目 <- factor(df_inflation_long$項目, levels= levelSeq)
  pick_total <- stringr::str_detect(df_inflation_long$項目,totalName)
  df_inflation_long_subcategories <- df_inflation_long[!pick_total,]
  df_inflation_long_total <- df_inflation_long[pick_total,]
  return(
    list(
      df_inflation_long_total=df_inflation_long_total,
      df_inflation_long_subcategories=df_inflation_long_subcategories
    )
  )
}
generate_inflationPlot <- function(df_inflation_long_subcategories, df_inflation_long_total){
  require(plotly)
  plotly::plot_ly() %>%
    plotly::add_lines(
      data=df_inflation_long_subcategories,
      x=~年, y=~上漲率, split=~項目, line = list(width=1, dash="dot"), 
    ) %>%
    plotly::add_lines(
      data=df_inflation_long_total,
      x=~年, y=~上漲率, color=I("dodgerblue3"), line = list(width=3), name="總項目"
    ) %>%
    plotly::rangeslider()
}
