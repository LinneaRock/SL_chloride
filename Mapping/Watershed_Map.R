library(tidyverse)
library(sf)
library(ggspatial)

#Retrieving and saving interlake watershed shapefile for Sparkling Lake
#iws.sf <- st_read("C:/Users/linne/Downloads/IWS/IWS.shp")
#iws.sf.SL <- iws.sf %>%
#  filter(ZoneID == "IWS_29670")

#write_rds(iws.sf.SL, "Data/shapefiles/IWS.rds")

iws.sf.SL <- read_rds("Data/shapefiles/IWS.rds")

#esri_land <-  paste0('https://services.arcgisonline.com/arcgis/rest/services/NatGeo_World_Map/MapServer/tile/${z}/${y}/${x}.jpeg')
world_gray <- paste0('https://services.arcgisonline.com/arcgis/rest/services/Canvas/World_Light_Gray_Base/MapServer/tile/${z}/${y}/${x}.jpeg')


ggplot(gw_wells.sf) + 
  annotation_map_tile(type = world_gray, zoom = 15) + # Esri Basemap (zoom sets level of detail, higher = higherRes)
  geom_sf(data = iws.sf.SL, fill = NA) + 
  theme_bw() + # Hilary's default theme
  theme(legend.position = c(0.9,0.85)) +
  annotation_scale(location = "br", width_hint = 0.5,height = unit(0.05,'in')) + # Scale bar
  annotation_north_arrow(location = "bl", which_north = "true", 
                         # pad_x = unit(0.2, "in"), pad_y = unit(0.2, "in"),
                         height = unit(0.5,'in'), width = unit(0.5,'in'),
                         style = north_arrow_nautical) + # North Arrow
  coord_sf(datum = NA, ylim = c(45.99, 46.02), xlim = c(-89.72, -89.68), expand = FALSE) # limit axes

ggsave("Plots/WatershedMap.png", width = 6, height = 6, units = "in")
