library(lubridate)
library(spData)
library(ggsn)
library(sf)
library(raster)
library(kableExtra)
library(cowplot)        
library(reshape)
data("world")
require(rerddap)
require(tidyverse)
library(geosphere)
library(openxlsx)
library(ggrepel)
library(akima)  
library(MBA)
library(ggrepel)
library(ggpubr)
library(metR)
library(ncdf4)

setwd("C:/Users/aalvarado/OneDrive - PESQUERA DIAMANTE S.A/Escritorio/argos manuales/")### cambia esta ruta, usa una ruta local



var_0m=nc_open("septiembre.nc")

temp=ncvar_get(var_0m,"thetao")
depth=ncvar_get(var_0m,"depth")
lat=ncvar_get(var_0m,"latitude")
lon=ncvar_get(var_0m,"longitude")
time=ncvar_get(var_0m,"time")
time=(time/24)+as.Date("1950-01-01")

theta= melt(temp)

atarashi_df=theta
atarashi_df$X1=as.factor(atarashi_df$X1)
atarashi_df$X2=as.factor(atarashi_df$X2)
atarashi_df$X3=as.factor(atarashi_df$X3)
atarashi_df$X4=as.factor(atarashi_df$X4)
levels(atarashi_df$X1)=as.numeric(lon)
levels(atarashi_df$X2)=as.numeric(lat)
levels(atarashi_df$X3)=depth
levels(atarashi_df$X4)=time
atarashi_df=as_tibble(atarashi_df)
colnames(atarashi_df)=c("Longitud","Latitud","Depth", "Fecha" ,"Temp")
atarashi_df$Latitud=as.numeric(as.character(atarashi_df$Latitud))
atarashi_df$Longitud=as.numeric(as.character(atarashi_df$Longitud))
atarashi_df$Depth=as.numeric(as.character(atarashi_df$Depth))
atarashi_df$Fecha=as.Date(atarashi_df$Fecha)
atarashi_df=na.omit(atarashi_df)

library(akima)
library(oce)
library(ymd)


atarashi_df1=atarashi_df%>%mutate(day=day(Fecha))

#define los dias a tomar
df_7days=atarashi_df1%>%filter(day>=16 & day<=30)


atarashi_df1_mensual=df_7days%>%dplyr::select(Temp)%>%
  dplyr::group_by(Longitud=df_7days$Longitud, Latitud=df_7days$Latitud, Depth=df_7days$Depth)%>%
  summarise_if(is.numeric,mean,na.rm=T)


criterion=0.5

res=1/12
depthlim<-c(10,200)
x0<-seq(from=depthlim[1],to=depthlim[2],by=res)
lista_mld=list()

rang_lat=seq(-20,0, res)
rang_lon=seq(-85,-69, res)


grilla= expand.grid(unique(rang_lat), unique(rang_lon))
grilla=as.data.frame(grilla)

df_mld=NULL

for(i in 1:dim(grilla)[1]) {
  
  parte=atarashi_df1_mensual%>%filter(Latitud==grilla$Var1[i] & Longitud==grilla$Var2[i] & Depth>=10)
  inMLD =  abs(parte$Temp[1] - parte$Temp) < criterion
  isotherm=which.min(abs(parte$Temp- 15))
  MLDindex = which.min(inMLD)
  MLDpressure = parte$Depth[MLDindex]
  isotherm_15=parte$Depth[isotherm]
  
  vector_mld=data.frame(unique(parte$Longitud), unique(parte$Latitud), MLDpressure, isotherm_15)
  df_mld<-rbind(df_mld,vector_mld)
  
}


colnames(df_mld)=c("lon","lat","MLD", "Isoterma_15")

#df_mld1 es 1-15 dias
df_mld2=df_mld

write.csv(df_mld2, "df_mld2.csv", row.names=F)

mba <- mba.surf(df_mld2[,c('lon', 'lat', 'MLD')], 1000, 1000)
dimnames(mba$xyz.est$z) <- list(mba$xyz.est$x, mba$xyz.est$y) 
df2 <- melt(mba$xyz.est$z, varnames = c('lon', 'lat'), value.name = 'MLD')
df2=na.omit(df2)

------------------------------------
  
  
  
  puertos10=read.xlsx("puertos10.xlsx", 1)


aoi = spData::world %>% 
  sf::st_crop(xmin = -69, xmax=-86,
              ymin = 0, ymax=-21)

scale=c("violet", "blue","cyan","cyan3","yellow","orange", "red","red2")

#mapa MLD 
p=ggplot(data = df2, aes(x = lon, y = lat))+ 
  geom_raster(aes(fill = value), 
              interpolate= T, na.rm = T)+
  geom_contour(aes(z=value),breaks=seq(20,160,20) , check_overlap = T)  +
  geom_text_contour(aes(z=value), breaks=seq(20,160,20), stroke=0.1, check_overlap = TRUE)+
  scale_fill_gradientn(name= "Profundidad (m)", colours = scale, breaks=seq(0,200,10), limits=c(0,200))+
  scale_y_continuous(breaks=seq(-20,0,2))+
  ggspatial::layer_spatial(data = aoi) +
  coord_sf(xlim = c(-84,-70), 
           ylim = c(-19.1,-0.9))+
  #geom_point(data = puertos10 ,aes(x = X,y = Y,label = Puerto), size = 4, color = 'red', alpha = .15) +
  geom_text_repel(data = puertos10 ,aes(x = X,y = Y,label = Puerto),
                  nudge_x=0.4, nudge_y=0.5 ,size=4) +
  theme_bw() +
  theme(axis.title = element_blank(),panel.background = element_rect(fill = "lightblue"),
        plot.title = element_text(hjust = 0.5, vjust=2), legend.key.height  = unit(2.5, "cm"), legend.title =element_text(vjust=3.5))


m2= p+annotate(geom="text",x = -76, y = -4.8, size = 4,label="MLD 30-Set-2022",  colour = "red", parse = F)

"MLD\n30-Set-2022"

#"Isoterma 15°C\n15-Set-2022"
p2 

ggarrange(i1,i2,common.legend = TRUE,legend = "right")
ggarrange(m1,m2,common.legend = TRUE,legend = "right")


par(mfrow=c(2,2))



--------------------------------------------------------------------------
  
  
  
  
  
  
  