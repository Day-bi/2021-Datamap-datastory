#최종 코드
setwd("C:/Users/daybi/Documents/Titano/competi/DataMapstory(211119)")
# 한글 에러 "euc-kr", "utf-8","ucs-2le"
#데이터 불러오기
library(XML)
data = read.csv('cctv.csv')

# 데이터 정제
library(dplyr)
data = data[,-c(2,6,7,8,10,13:15)] # 필요하지 않은 컬럼 삭제
names(data) <- c("name","addr","purpose","cctvNum","install","latitude","longitude") # 컬럼명 변경
data = subset(data, install>="2014-01" & install <= "2018-12") # 14년부터 18년까지 추출

# 지역별로 나누기
#서울
seoul_addr = data[grep("서울특별시",data$addr),]
seoul_name = data[grep("서울특별시",data$name),]
seoul = merge(seoul_addr,seoul_name, by=c("name","addr","purpose","cctvNum","install","latitude","longitude"), all =TRUE)

#부산
busan_addr = data[grep("부산광역시",data$name),]
busan_name = data[grep("부산광역시",data$name),]
busan = merge(busan_addr,busan_name, by=c("name","addr","purpose","cctvNum","install","latitude","longitude"), all =TRUE)

#대구 
daegu_addr = data[grep("대구광역시",data$addr),]
daegu_name = data[grep("대구광역시",data$name),]
daegu = merge(daegu_addr,daegu_name, by=c("name","addr","purpose","cctvNum","install","latitude","longitude"), all =TRUE)

#인천
Incheon_addr = data[grep("인천광역시",data$addr),]
Incheon_name = data[grep("인천광역시",data$name),]
Incheon = merge(Incheon_addr,Incheon_name, by=c("name","addr","purpose","cctvNum","install","latitude","longitude"), all =TRUE)

#광주
Gwangju_addr = data[grep("광주광역시",data$addr),]
Gwangju_name = data[grep("광주광역시",data$name),]
Gwangju = merge(Gwangju_addr,Gwangju_name, by=c("name","addr","purpose","cctvNum","install","latitude","longitude"), all =TRUE)

#대전
Daejeon_addr = data[grep("대전광역시",data$addr),]
Daejeon_name = data[grep("대전광역시",data$name),]
Daejeon = merge(Daejeon_addr,Daejeon_name, by=c("name","addr","purpose","cctvNum","install","latitude","longitude"), all =TRUE)

#경기도
gyeonggi_addr = data[grep("경기도",data$addr),]
gyeonggi_name = data[grep("경기도",data$name),]
gyeonggi = merge(gyeonggi_addr,gyeonggi_name, by=c("name","addr","purpose","cctvNum","install","latitude","longitude"), all =TRUE)
#강원도
gangwon_addr = data[grep("강원도",data$addr),]
gangwon_name = data[grep("강원도",data$name),]
gangwon = merge(gangwon_addr,gangwon_name, by=c("name","addr","purpose","cctvNum","install","latitude","longitude"), all =TRUE)

#충청남도
Chungnam_addr = data[grep("충청남도",data$addr),]
Chungnam_name = data[grep("충청남도",data$name),]
Chungnam = merge(Chungnam_addr,Chungnam_name, by=c("name","addr","purpose","cctvNum","install","latitude","longitude"), all =TRUE)

#충청북도
Chungbuk_addr = data[grep("충청북도",data$addr),]
Chungbuk_name = data[grep("충청북도",data$name),]
Chungbuk = merge(Chungbuk_addr,Chungbuk_name, by=c("name","addr","purpose","cctvNum","install","latitude","longitude"), all =TRUE)

#경상남도
Gyeongnam_addr = data[grep("경상남도",data$addr),]
Gyeongnam_name = data[grep("경상남도",data$name),]
Gyeongnam = merge(Gyeongnam_addr,Gyeongnam_name, by=c("name","addr","purpose","cctvNum","install","latitude","longitude"), all =TRUE)

#경상북도
Gyeongbuk_addr = data[grep("경상북도",data$addr),]
Gyeongbuk_name = data[grep("경상북도",data$name),]
Gyeongbuk = merge(Gyeongbuk_addr,Gyeongbuk_name, by=c("name","addr","purpose","cctvNum","install","latitude","longitude"), all =TRUE)

#전라북도
Jeonbuk_addr = data[grep("전라북도",data$addr),]
Jeonbuk_name = data[grep("전라북도",data$name),]
Jeonbuk = merge(Jeonbuk_addr,Jeonbuk_name, by=c("name","addr","purpose","cctvNum","install","latitude","longitude"), all =TRUE)

#전라남도
Jeonnam_addr = data[grep("전라남도",data$addr),]
Jeonnam_name = data[grep("전라남도",data$name),]
Jeonnam = merge(Jeonnam_addr,Jeonnam_name, by=c("name","addr","purpose","cctvNum","install","latitude","longitude"), all =TRUE)

#제주도
jeju_addr = data[grep("제주",data$addr),]
jeju_name = data[grep("제주",data$name),]
jeju = merge(jeju_addr,jeju_name, by=c("name","addr","purpose","cctvNum","install","latitude","longitude"), all =TRUE)

#지역별 데이터 한 곳으로 합치기
library(plyr)
df = join_all(list(seoul,busan,daegu,Incheon,Gwangju,Daejeon,sejong,goyang,suwon,gangleung,wonju,cheonan,cheongju,gyeongju,sangju,jeonju,naju,jeju))

inner_join(seoul,busan,daegu,Incheon,Gwangju,Daejeon,sejong,goyang,suwon,gangleung,wonju,cheonan,cheongju,gyeongju,sangju,jeonju,naju,jeju,by=c("name","addr","purpose","cctvNum","install","latitude","longitude"))

joined_df <- seoul %>% 
  full_join(busan) %>% 
  full_join(daegu) %>% 
  full_join(Incheon) %>% 
  full_join(Gwangju) %>% 
  full_join(Daejeon) %>% 
  full_join(gyeonggi) %>% 
  full_join(gangwon) %>% 
  full_join(Chungnam) %>% 
  full_join(Chungbuk) %>% 
  full_join(Gyeongnam) %>% 
  full_join(Gyeongbuk) %>% 
  full_join(Jeonnam) %>% 
  full_join(Jeonbuk) %>% 
  full_join(jeju)
  
# 시각화
# 나라 지도
library('ggmap')
register_google(key = 'your key')
gc <- geocode(enc2utf8("서울")) #서울 위도 경도
cen <- as.numeric(gc) # gc를 숫자로 변환
map <- get_googlemap(center = cen,
                     zoom = 7,
                     size = c(1000,1000),
                     maptype = 'terrain') #terrain,satellite,roadmap, hybrid
ggmap(map)
# cctv 위치 찍기



#데이터 저장
write.csv(joined_df,file = "data_full.csv")

