library(plyr)
library(ggmap)
library(XML)
library(rgdal)
library(ggplot2)
library(gridExtra)
library(ggsci)
library(scales)
setwd("C:/Users/daybi/Documents/Titano/competi/DataMapstory(211119)")

# 좌표반환
register_google(key ='AIzaSyBi0lR3YtXhXwHd6BkXdcF1ZxkBxxdmFgE')
gc <- geocode(enc2utf8(c("강원도","경기도","경상남도","경상북도","광주광역시","대구광역시","대전광역시","부산광역시","서울특별시","울산광역시","인천광역시","전라남도","전라북도","제주시 제주시","충청남도","충청북도"
)))
gc[, "id"] = (1:nrow(gc)) - 1

#
sensus <- read.csv("인구총조사_인구_시도_시_군_구__20211128164134.csv")
names(sensus) = c("name","2018인구","2019인구","2015인구")
sensus_ratio <- read.csv("2015년_외국인,1인가구비율.csv")
sensus_ratio <- data.frame(sensus_ratio$지역,sensus_ratio$X1인가구 * sensus$`2015인구`
                           ,sensus_ratio$외국인 * sensus$`2015인구`)
names(sensus_ratio) <- c("name","1인가구수","외국인수")
# 
crime <- read.csv("범죄.csv", encoding = 'utf-8')
crime <- data.frame(crime)
names(crime) = c("name","2018범죄","2019범죄","2015범죄")
#
area <- read.csv("도시지역면적_시도_시_군_구__20211128164348.csv")
names(area) = c("name","2018면적","2019면적","2015면적")
#
density = data.frame(sensus$name, sensus$`2018인구`/area$`2018면적`, sensus$`2019인구`/area$`2019면적`,sensus$`2015인구`/area$`2015면적`)
names(density) = c("name","2018밀도","2019밀도","2015밀도")
crime_ratio = data.frame(sensus$name, crime$`2018범죄`/sensus$`2018인구`, crime$`2019범죄`/sensus$`2019인구`,crime$`2015범죄`/sensus$`2015인구`)
names(crime_ratio) = c("name","2018범죄율","2019범죄율","2015범죄율")

#
t = join_all(list(sensus,crime,area,density, crime_ratio,sensus_ratio), by="name")
t = t[c(order(t$name)),]
row.names(t) <-NULL
t[, "id"] = (1:nrow(t)) - 1
t = merge(t, gc)

#
register_google(key ='AIzaSyBi0lR3YtXhXwHd6BkXdcF1ZxkBxxdmFgE')
map <- get_map(location='south korea', zoom=7, maptype='roadmap', color='bw')
ggmap(map)

# 중심 점 찍기
ggmap(map) + geom_point(data=t, aes(x=lon, y=lat, color = 'red', size = t$`2018범죄`))
ggmap(map) + geom_point(data=t, aes(x=lon, y=lat, color = 'red', size = `2015범죄율`)) #+
  ggtitle(" ") + theme(plot.title = element_text(face = "bold", hjust = 0.95)) +
  coord_flip()+ labs(x = "",y = "인구수 대비 범죄건수 (범죄율)") +
  theme(legend.title = element_blank()) + theme(legend.position = "none")

#bar
#밀도
density15 <- ggplot(t, aes(x=name,y=t$`2015밀도`, fill=name)) +
  geom_bar(stat = "identity") +  ggtitle(" ") + theme(plot.title = element_text(face = "bold", hjust = 0.95)) +
  coord_flip()+ labs(x = "",y = "면적 대비 인구수 (인구밀도)") + theme_classic() +
  theme(legend.title = element_blank()) + theme(legend.position = "none")

density18 <- ggplot(t, aes(x=name,y=t$`2018밀도`, fill=name)) +
  geom_bar(stat = "identity") + ggtitle(" ") + theme(plot.title = element_text(face = "bold", hjust = 0.95)) +
  coord_flip()+ labs(x = "",y = "면적 대비 인구수 (인구밀도)") + theme_classic() +
  theme(legend.title = element_blank()) + theme(legend.position = "none")

density19 <- ggplot(t, aes(x=name,y=t$`2019밀도`, fill=name)) +
  geom_bar(stat = "identity") + ggtitle(" ") + theme(plot.title = element_text(face = "bold", hjust = 0.95)) +
  coord_flip()+ labs(x = "",y = "면적 대비 인구수 (인구밀도)") + theme_classic() +
  theme(legend.title = element_blank()) + theme(legend.position = "none")


#범죄율
crime19 <- ggplot(t, aes(x=name,y=t$`2019범죄율`, fill=name)) +
  geom_bar(stat = "identity") + coord_flip() + 
  labs(x = "",y = "인구수 대비 범죄건수 (범죄율)") + theme_classic() +
  theme(legend.title = element_blank())+ theme(legend.position = "none") + 
  ggtitle("2019년") + theme(plot.title = element_text(face = "bold", hjust = 1, size = 18))

crime18 <- ggplot(t, aes(x=name,y=t$`2018범죄율`, fill=name)) +
  geom_bar(stat = "identity")+
coord_flip()+ theme_classic() +
  labs(x = "",y = "인구수 대비 범죄건수 (범죄율)") + theme(legend.position = "none") +
  theme(legend.title = element_blank()) +
  ggtitle("2018년") + theme(plot.title = element_text(face = "bold", hjust = 1, size = 18))

crime15 <- ggplot(t, aes(x=name,y=t$`2015범죄율`, fill=name)) +
  geom_bar(stat = "identity") +
  theme_classic() +theme(legend.title = element_blank()) +
  theme(legend.position = "none") +
  ggtitle("2015년")  + theme(plot.title = element_text(face = "bold", hjust = 1, size = 18)) +
  labs(x = "",y = "인구수 대비 범죄건수 (범죄율)") +
  coord_flip()


# 여러개 그리기
grid.arrange(density15,crime15, nrow=1,ncol=2)
grid.arrange(density18,crime18, nrow=1,ncol=2)
grid.arrange(density19,crime19, nrow=1,ncol=2)

#a <- data.frame(sum(t$`2018인구`),sum(t$`2019인구`),sum(t$`2015인구`),sum(t$`2018범죄`),sum(t$`2019범죄`),sum(t$`2015범죄`),sum(t$`2018면적`),sum(t$`2019면적`),sum(t$`2015면적`),sum(t$`2018밀도`),sum(t$`2019밀도`),sum(t$`2015밀도`),sum(t$`2018범죄율`),sum(t$`2019범죄율`),sum(t$`2015범죄율`),sum(t$`1인가구수`),t$외국인수)
#names(a) <- c("2018인구","2019인구","2015인구","2018범죄","2019범죄","2015범죄","2018면적","2019면적","2015면적","2018밀도","2019밀도","2015밀도","2018범죄율","2019범죄율","2015범죄율","1인가구수","외국인수")
#a<-a[1,]
#plot(a$`2015범죄`,a$`2019범죄`)                
#write.csv(a,"총합.csv")
#
z <- read.csv("총합.csv")
crime_ratio_graph <-
  ggplot(z,
         aes(x=year,y=crime_ratio,fill=crime_ratio)) +
  geom_bar(stat = "identity") +
  theme_classic() +
  scale_fill_continuous(name="범죄율") +
  scale_y_continuous(name ="  ")

density_graph <-
  ggplot(z,
         aes(x=year,y=density,fill=density)) +
  geom_bar(stat = "identity", colours(distinct = FALSE)) +
  theme_classic() +
  scale_fill_continuous(name="인구밀도") +
  scale_y_continuous(name ="  ")

#여러개 그리기
grid.arrange(density_graph,crime_ratio_graph, nrow=1,ncol=2)  

##
#1인 가구와 외국인 비교하기
alone<-
  ggplot(t, aes(x=name,y=t$`1인가구수`, fill=name)) +
  geom_bar(stat = "identity") +
  coord_flip()+
  geom_point(aes(x=name,y=t$`2015범죄`),data=t) +
  labs(x = "",y = "1인 가구수와 범죄건수") + theme_classic() +
  theme(legend.title = element_blank()) + theme(legend.position = "none") +
  ggtitle("2015년") + theme(plot.title = element_text(face = "bold", hjust = 1, size = 18))
  
fore<-
  ggplot(t, aes(x=name,y=t$외국인수, fill=name)) +
  geom_bar(stat = "identity") +
  coord_flip() + geom_point(aes(x=name,y=t$`2015범죄`),data=t) +
  labs(x = "",y = "1인 가구수와 범죄건수") + theme_classic() +
  theme(legend.title = element_blank()) + theme(legend.position = "none")+
  ggtitle("2015년") + theme(plot.title = element_text(face = "bold", hjust = 1, size = 18))
  
#
grid.arrange(alone,fore,nrow=1,ccol=2)
## 1인가구 비교하는거 시도~ 스택그래프로
aa <- read.csv("2015년 정리.csv")
ggplot(aa, aes(x=지역, y=값,fill=구분)) +
  geom_bar(stat = "identity") +
  coord_flip()
##
pop_crime <- read.csv("년도별 데이터(스택).csv")
pop_crime$년도 <- as.character(pop_crime$년도)


# 인구밀도, 범죄율
pop_crime1<-pop_crime[-c(1:6),]
pop_crime2<-pop_crime[-c(7:12),]

p1 <-
  ggplot(pop_crime1, aes(x=년도, y=값, fill = 구분)) +
  geom_bar(stat = "identity") + theme_classic() +
  labs(x="",y="")
p2 <-
  ggplot(pop_crime2, aes(x=년도, y=값,fill=구분)) +
  geom_bar(stat = "identity") + theme_classic() +
  labs(x="",y="")

grid.arrange(p1,p2,nrow=1,ncol=2)
##
p11 <-
  ggplot(pop_crime1, aes(x=년도, y=값, fill = 구분)) +
  geom_bar(stat = "identity") + theme_classic() +
  geom_text(aes(y=값,label=구분), position = position_stack(vjust = 0.5), size=5) +
  labs(x=" ",y=" ") +
  theme(legend.title = element_blank())+ theme(legend.position = "none")
p22 <-
  ggplot(pop_crime2, aes(x=년도, y=값,fill=구분)) +
  geom_bar(stat = "identity") + theme_classic() +
  geom_text(aes(y=값,label=구분), position = position_stack(vjust = 0.5), size=5) +
  labs(x=" ",y=" ") +
  theme(legend.title = element_blank())+ theme(legend.position = "none")

grid.arrange(p11,p22,nrow=1,ncol=2)

