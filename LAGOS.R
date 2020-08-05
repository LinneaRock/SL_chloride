library(tidyverse)
library(LAGOSNE)



lagos <- lagosne_load()
names(lagos)

info_SL <- lake_info(name = "Sparkling", state = "Wisconsin")

locus <- lagos$locus %>%
  filter(lagoslakeid == 906)

iws <- lagos$iws %>%
  filter(lagoslakeid == 906)

geo <- lagos$lakes.geo %>%
  filter(lagoslakeid == 906)

lulc <- lagos$iws.lulc %>%
  filter(lagoslakeid == 906)

conn <- lagos$iws.conn %>%
  filter(lagoslakeid == 906)


limno <- lagos$lakes_limno %>%
  filter(lagoslakeid == 906)

iws.lulc = lagos$iws.lulc %>% dplyr::select(lagoslakeid,iws_nlcd2011_ha_0:iws_roaddensity_density_mperha)  %>% 
  select(-contains('_ha_')) %>%
  filter(lagoslakeid == 906) 
         
