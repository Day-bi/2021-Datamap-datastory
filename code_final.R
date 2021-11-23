#최종 코드

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

#광주
Daejeon_addr = data[grep("대전광역시",data$addr),]
Daejeon_name = data[grep("대전광역시",data$name),]
Daejeon = merge(Daejeon_addr,Daejeon_name, by=c("name","addr","purpose","cctvNum","install","latitude","longitude"), all =TRUE)

#세종
sejong_addr = data[grep("세종특별",data$addr),] 
sejong_name = data[grep("세종특별",data$name),]
sejong = merge(sejong_addr,sejong_name, by=c("name","addr","purpose","cctvNum","install","latitude","longitude"), all =TRUE)

#경기도
gyeonggi_addr = data[grep("경기도",data$addr),]
gyeonggi_name = data[grep("경기도",data$name),]
gyeonggi = merge(gyeonggi_addr,gyeonggi_name, by=c("name","addr","purpose","cctvNum","install","latitude","longitudse"), all =TRUE)

#경기도 수원시
suwon_addr = data[grep("경기도 이천시",data$addr),]
suwon_name = data[grep("경기도 이천시",data$name),]
suwon = merge(suwon_addr,suwon_name, by=c("name","addr","purpose","cctvNum","install","latitude","longitude"), all =TRUE)

#강원도 강릉
gangwon_addr = data[grep("강원도",data$addr),]
gangwon_name = data[grep("강원도",data$name),]
gangwon = merge(gangwon_addr,gangwon_name, by=c("name","addr","purpose","cctvNum","install","latitude","longitude"), all =TRUE)

#강원도 원주시
wonju_addr = data[grep("강원도 원주시",data$addr),]
wonju_name = data[grep("강원도 원주시",data$name),]
wonju = merge(wonju_addr,wonju_name, by=c("name","addr","purpose","cctvNum","install","latitude","longitude"), all =TRUE)

#충청남도 천안시
chungcheong_addr = data[grep("충청",data$addr),]
chungcheong_name = data[grep("충청",data$name),]
chungcheongn = merge(chungcheong_addr,chungcheong_name, by=c("name","addr","purpose","cctvNum","install","latitude","longitude"), all =TRUE)

#충청북도 충주시
cheongju_addr = data[grep("충청북도",data$addr),]
cheongju_name = data[grep("충청북도",data$name),]
cheongju = merge(cheongju_addr,cheongju_name, by=c("name","addr","purpose","cctvNum","install","latitude","longitude"), all =TRUE)

#경상남도 경주시
gyeongsang_addr = data[grep("경상",data$addr),]
gyeongsang_name = data[grep("경상",data$name),]
gyeongsang = merge(gyeongsang_addr,gyeongsang_name, by=c("name","addr","purpose","cctvNum","install","latitude","longitude"), all =TRUE)

#경상북도 상주시
sangju_addr = data[grep("경상북도 상주시",data$addr),]
sangju_name = data[grep("경상북도 상주시",data$name),]
sangju = merge(sangju_addr,sangju_name, by=c("name","addr","purpose","cctvNum","install","latitude","longitude"), all =TRUE)

#전라북도 전주시
jeonla_addr = data[grep("전라",data$addr),]
jeonla_name = data[grep("전라",data$name),]
jeonla = merge(jeonla_addr,jeonla_name, by=c("name","addr","purpose","cctvNum","install","latitude","longitude"), all =TRUE)

#전라남도 나주시
naju_addr = data[grep("전라남도 나주시",data$addr),]
naju_name = data[grep("전라남도 나주시",data$name),]
naju = merge(naju_addr,naju_name, by=c("name","addr","purpose","cctvNum","install","latitude","longitude"), all =TRUE)

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
  full_join(sejong) %>% 
  full_join(goyang) %>% 
  full_join(suwon) %>% 
  full_join(gangleung) %>% 
  full_join(wonju) %>% 
  full_join(cheonan) %>% 
  full_join(cheongju) %>% 
  full_join(gyeongju) %>% 
  full_join(sangju) %>% 
  full_join(jeonju) %>% 
  full_join(jeju) %>% 
  full_join(naju)