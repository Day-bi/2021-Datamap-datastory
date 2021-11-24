# 체감 안전도
setwd("C:/Users/daybi/Documents/Titano/competi/DataMapstory(211119)/체감안전도")

# 불러들이기
library(XML)
list.files()
file_list <- list.files()

safe <- NULL
for (i in 1:length(file_list)){
  file <- read.csv(file_list[i],header = F,fileEncoding = "utf-8")
  safe <- rbind(safe,file)
  cat("\n", i)
}

# 정제
library(dplyr)
library(stringr)
library(tidyr)

#컬럼 정리
safe = safe[,-c(4,5,6)] 

#labeling
names(safe) <- c("TRGET_YM","POLC_NM","SURVEY_TARGET_CNT_TOTAL","SURVEY_TARGET_CNT_MALE","SURVEY_TARGET_CNT_FEMALE","SURVEY_TARGET_CNT_AGE_20_LESS","SURVEY_TARGET_CNT_AGE_30","SURVEY_TARGET_CNT_AGE_40","SURVEY_TARGET_CNT_AGE_50","SURVEY_TARGET_CNT_AGE_60_OVER","GNRLZ_SENS_SAFECHK_SCORE","GNRL_SENS_SAFECHK_SCORE","FIELD_SAFECHK_SCORE","CRIME_SAFECHK_SCORE","TRNSPORT_INCI_SAFECHK_SCORE","LAW_ORDER_COMP_SCORE","THEFT_VIOLENCE_SAFECHK_SCORE","ROBBER_KILL_SAFECHK_SCORE","GNRL_POLC_EFFORT_SCORE")
names(safe) <- c("년도","경찰서","설문대상인원_전체","설문대상인원_남","설문대상인원_여","설문대상인원_20대이하","설문대상인원_30대","설문대상인원_40","설문대상인원_50대","설문대상인원_60대","종합체감안전도_점수","전반적안전도_점수","분야별안전도_점수","범죄안전도_점수","교통사고안전도_점수","법질서준수도_점수","절도폭력안전도_점수","강도살인안전도_점수","전반적경찰노력도_점수")

#년도별 정리
safe$년도 <- substr(safe$년도,1,4) 

# 지역별 정리
safe$경찰서 <- substr(safe$경찰서,1,2) 
