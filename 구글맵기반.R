library(ggmap)
register_google(key ='AIzaSyBi0lR3YtXhXwHd6BkXdcF1ZxkBxxdmFgE')

ggmap(get_map(location='south korea',zoom = 7, maptype = 'roadmap'))

# 흑백 지도
map <- get_map(location='south korea', zoom=7, maptype='roadmap', color='bw')
ggmap(map)

#좌표반환
gc <- geocode(enc2utf8(c("서울특별시","부산광역시","대구광역시","인천광역시","광주광역시","대전광역시","울산광역시","경기도","강원도","충청남도","충청북도","경상남도","경상북도","전라북도","전라남도","제주시 제주시"))) #위도,경도

ggmap(map) + geom_point(data=merge_result, aes(x=lon, y=lat, color=name))

ggmap(map) + stat_density_2d(data=merge_result, aes(x=lon, y=lat))

map_gangg <- get_map(loctaion = '강원도')
ggmap(map_gangg)

##
행정구역별 좌표를 반환 해서 거기에만 동그라미를 치는게 낫겠다.
범죄 발생 장소에 찍는게 아니ㅣ니까.