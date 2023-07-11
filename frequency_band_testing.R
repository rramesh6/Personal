# LIBRARIES
library(readr)
library(readxl)
library(dplyr)
library(stringr)
library(car)

# READ IN DATA
rcs02_prestim_key0 <- read_csv('/Users/Rithvik/Documents/UCSF/Research/wang_lab/Data/RCS_02/PSD Analysis/RCS02_prestim_key0_band.csv')
rcs02_prestim_key0 <- rename(rcs02_prestim_key0, 'movestate'= 'Movement State','power'='Power/Frequency','freq'='Frequency Band')

kruskal.test(power[rcs02_prestim_key0$freq == 'delta'] ~ movestate[rcs02_prestim_key0$freq == 'delta'], data = rcs02_prestim_key0)
wilcox.test(rcs02_prestim_key0$power[rcs02_prestim_key0$freq == 'delta' & rcs02_prestim_key0$movestate == 1],rcs02_prestim_key0$power[rcs02_prestim_key0$freq == 'delta' & rcs02_prestim_key0$movestate == 2])
shapiro.test(rcs02_prestim_key0$power[rcs02_prestim_key0$freq == 'delta' & rcs02_prestim_key0$movestate == 1])
shapiro.test(rcs02_prestim_key0$power[rcs02_prestim_key0$freq == 'delta' & rcs02_prestim_key0$movestate == 2])

# READ IN DATA
feature_table <- read_csv('/Users/Rithvik/Documents/UCSF/Research/wang_lab/Data/RCS_02/PSD Analysis/prepoststim/RCS02_prepoststim_key1_feature_table.csv')

model <- glm(feature_table$gait ~ + feature_table$theta + feature_table$alpha + feature_table$beta + feature_table$low_gamma + feature_table$high_gamma, family = binomial)