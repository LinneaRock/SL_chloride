library(sf)
library(tidyverse)
library(ggspatial)
library(raster)


## Esri basemap URLs ####
esri_land <-    paste0('https://services.arcgisonline.com/arcgis/rest/services/NatGeo_World_Map/MapServer/tile/${z}/${y}/${x}.jpeg')
world_gray <-   paste0('https://services.arcgisonline.com/arcgis/rest/services/Canvas/World_Light_Gray_Base/MapServer/tile/${z}/${y}/${x}.jpeg')

#Manually ubild dataframes with coordinates of sampling locations
gw_wells <- data.frame(site = c("Well 5", "Well 7a/b", "Well 8"), lat = c(46.0030612, 46.0036897, 46.0065147), lon = c(-89.6967096, -89.6958901, -89.6962271))
gw_wells.sf <- st_as_sf(gw_wells, coords = c("lon", "lat"),
                        crs = 4326)


# Map ####
ggplot(gw_wells.sf) +
  annotation_map_tile(type = world_gray, zoom = 15) + # Esri Basemap (zoom sets level of detail, higher = higherRes)
  geom_sf(aes(shape = site), color = "black", size = 1.6) +
  theme_bw() +
  annotation_scale(location = "br", width_hint = 0.5,height = unit(0.05,'in')) + # Scale bar
  annotation_north_arrow(location = "bl", which_north = "true", 
                         # pad_x = unit(0.2, "in"), pad_y = unit(0.2, "in"),
                         height = unit(0.5,'in'), width = unit(0.5,'in'),
                         style = north_arrow_nautical) + # North Arrow
  coord_sf(datum = NA, ylim = c(46.00, 46.016), xlim = c(-89.705, -89.69), expand = FALSE)  #limit axes

 ggsave("Plots/WellMap.png", width = 6, height = 6, units = "in")
 