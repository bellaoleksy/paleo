# Age Depth Model from Paleolimbot
library(tidyverse)
SFLake_Core <- read_csv("~/Desktop/Masters Thesis /Data /Dating/Paleolimbot_CRS_Dating/SFLake_210Pb_ages.csv")
tibble(SFLake_Core)
SFclean <- na.omit(SFLake_Core) 
library(tidypaleo)
SF_age_depth <- age_depth_model(SFclean, depth = SFclean$top_depth_cm, age = SFclean$avg_year_ad, age_max = SFclean$max_year_ad, age_min =  SFclean$min_year_ad)

#Basic age-depth plot for Santa Fe Lake 
plot(SF_age_depth)

#Predicitve ages of SF Lake from 0 to 49cm 
SF_premodel_1 <- predict(SF_age_depth, depth = seq(0, 39, 0.25))
SF_premodel_2 <- predict(SF_age_depth, depth = seq(40, 49, 0.5))


# Interpolation Plot 
SF_model_2 <- age_depth_model(SFclean, depth = SFclean$mean_depth_cm, age = SFclean$avg_year_ad, age_max = SFclean$max_year_ad, age_min =  SFclean$min_year_ad, 
interpolate_age = age_depth_interpolate,
  extrapolate_age_below = ~age_depth_extrapolate(.x, .y, x0 = last, y0 = last),
  extrapolate_age_above = ~age_depth_extrapolate(.x, .y, x0 = first, y0 = first))

plot(SF_model_2)

#Export for Interpolation Data Table 
tibble::as_tibble(SF_premodel_1)
tibble::as_tibble(SF_premodel_2)
write_csv(SF_premodel_1, file = ("~/Desktop/Masters Thesis /Data /Dating/Paleolimbot_CRS_Dating/SF_AGE_MODELTOP.csv"))
write_csv(SF_premodel_2, file = ("~/Desktop/Masters Thesis /Data /Dating/Paleolimbot_CRS_Dating/SF_AGE_MODELBOTTOM.csv"))

#lnPb210 
library("SciViews")

  
