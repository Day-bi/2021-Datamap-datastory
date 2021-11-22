#최종 코드
setwd("C:/Users/daybi/Documents/Titano/competi/DataMapstory(211119)")

#데이터 불러오기
library(XML)
data = read.csv('cctv.csv')

# 데이터 정제
library(dplyr)
data = data[,-c(2,6,7,8,10,13:15)] # 필요하지 않은 컬럼 삭제
names(data) <- c("name","addr","purpose","cctvNum","install","latitude","longitude") # 컬럼명 변경
data = subset(data, install>="2014-01" & install <= "2018-12") # 14년부터 18년까지 추출

