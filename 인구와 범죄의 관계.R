
# 경로
setwd("C:/Users/daybi/Documents/Titano/competi/DataMapstory(211119)")
library(XML)
library(rgdal)
library(ggplot2)

# 전국 인구 데이터 처리
sensus <- read.csv("인구총조사_인구_시도_시_군_구__20211126131137.csv")
sensus <- sensus[-8,-c(2,3,4)]
names(sensus) = c("name","2018인구","2019인구")
sensus = sensus[c(order(sensus$name)),]
row.names(sensus) <-NULL

# 범죄 건수
crime <- read.csv("범죄.csv", encoding = 'utf-8')
crime <- data.frame(crime)
names(crime) = c("name","2018범죄","2019범죄")
t = merge(sensus, crime, by = 'name')

#면적
area <- read.csv("도시지역면적_시도_시_군_구__20211126131713.csv")
area <-area[-8,-4]
names(area) = c("name","2018면적","2019면적")
#area = area[c(order(area$name)),]
#area[,"CTPRVN_CD"] =c(42,41,48,47,29,27,30,26,11,36,31,28,46,45,50,44,43)
#row.names(area) <-NULL
t = merge(t, area, by = 'name')

# 인구밀도 계산
density = data.frame(t$name, t$`2018인구`/t$`2018면적`, t$`2019인구`/t$`2019면적`)
names(density) = c("name","2018밀도","2019밀도")
t = merge(t, density, bt = 'name')

# 범죄율 계산
crime_ratio = data.frame(t$name, t$`2018범죄`/t$`2018인구`, t$`2019범죄`/t$`2019인구`)
names(crime_ratio) = c("name","2018범죄율","2019범죄율")
t = merge(t, crime_ratio, by = 'name')

# 통합 데이터
t[, "id"] = (1:nrow(t)) - 1

#지도
map = readOGR("TL_SCCO_CTPRVN.shp")
df_map = fortify(map)

merge_result <- merge(df_map, t , by = 'id') # 통합데이터+지도위치 

plot <- ggplot() + geom_polygon(data = merge_result,
                                aes(x=long, y= lat, group=group,
                                    fill = `2019범죄율`)) +
  geom_point(data = merge_result,aes(x=long, y=lat, color = id))

