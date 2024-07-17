library(ggplot2)
library(dplyr)
library(knitr)
library(baseballr)

stats <- read.csv('C:\\Users\\brkea\\OneDrive\\Baseball Projects\\catcher stats - 7172024.csv')

#filter the csv of the players who aren't catchers and those who have only throw 10 or less throws to seccond
stats <- stats %>% filter(pop_2b_sba != '', pop_2b_sba_count > 10)

#drop the number of throws to 2nd because I don't need it anymore
stats <- stats %>% select(-pop_2b_sba_count)
stats <- stats %>% rename(full_name = "last_name..first_name")

pop_avg <- mean(stats$pop_2b_sba)
exchange_avg <- mean(stats$exchange_2b_3b_sba)
velo_avg <- mean(stats$maxeff_arm_2b_3b_sba)

#group by catcher and create plus stats for the 3 stats 
pre_catcher <- stats %>% group_by(full_name) %>% summarise(Pop = (1-(pop_2b_sba/pop_avg))*100 + 100, Exchange =  (1-(exchange_2b_3b_sba/exchange_avg))*100 + 100, Velo = (maxeff_arm_2b_3b_sba/velo_avg)*100)

#create catcher+
catcher <- pre_catcher %>% group_by(full_name) %>% summarise('Catcher+' = (Pop + Exchange + Velo)/3)



