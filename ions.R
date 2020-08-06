library(tidyverse)
library(lubridate)
library(patchwork)
library(ggpmisc)
source("Functions/ion_plot.R")
source("Functions/L_theme.R")

#LTER ions data through 2020
LTER <- read.csv("Data/chemphys.csv") %>%
  mutate(sampledate = as.Date(sampledate, format = "%m/%d/%Y"))



cl <- ion(LTER, LTER$cl, "Chloride Concentration"~(mg~L^-1)) + L_theme()
ca <- ion(LTER, LTER$ca, "Calcium Concentration"~(mg~L^-1)) + L_theme()
mg <- ion(LTER, LTER$mg, "Magnesium Concentration"~(mg~L^-1)) + L_theme()
na <- ion(LTER, LTER$na, "Sodium Concentration"~(mg~L^-1)) + L_theme()
k <- ion(LTER, LTER$k, "Potassium Concentration"~(mg~L^-1)) + L_theme()
fe <- ion(LTER, LTER$fe, "Iron Concentration"~(mg~L^-1)) + L_theme()
mn <- ion(LTER, LTER$mn, "Manganese Concentration"~(mg~L^-1)) + L_theme()
cond <- ion(LTER, LTER$cond, "Specific Conductivity"~(mu~S~cm^-1)~"@ 25"*~degree*C) + L_theme()

all_ions <- (fe | k | mn) /
  (na | mg) /
  (cl | ca)

all_ions #This does not include the specific conductivity plot

ggsave("Plots/all_ions.png", height = 8, width = 10, units = "in")

cl + geom_smooth(method = lm, se = FALSE)

#Plot of ratio of Na:Cl over time 
ratio <- LTER %>%
  select(sampledate, depth, na, cl) %>%
  mutate(Ratio = na / cl) %>%
  na.omit(cl) %>%
  filter(Ratio < 1)

ggplot(ratio, aes(sampledate, Ratio, color = depth)) + 
  geom_point() +
  L_theme() +
  labs(x = "", y = "Na:Cl Concentration Ratio", color = "Depth (m)") +
  scale_color_viridis_c(trans = "reverse") +
  theme(legend.title = element_text())

ggsave("Plots/nacl_ratio.png", height = 4, width = 6, units = 'in')
