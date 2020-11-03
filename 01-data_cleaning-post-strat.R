#### Preamble ####
# Purpose: Prepare and clean the survey data downloaded from [...UPDATE ME!!!!!]
# Author: Rohan Alexander and Sam Caetano [CHANGE THIS TO YOUR NAME!!!!]
# Data: 22 October 2020
# Contact: rohan.alexander@utoronto.ca [PROBABLY CHANGE THIS ALSO!!!!]
# License: MIT
# Pre-requisites: 
# - Need to have downloaded the ACS data and saved it to inputs/data
# - Don't forget to gitignore it!


#### Workspace setup ####
library(haven)
library(tidyverse)
# Read in the raw data. 
raw_data <- read_dta("usa_00001.dta")
# Add the labels
raw_data <- labelled::to_factor(raw_data)

# Just keep some variables that may be of interest (change 
# this depending on your interests)
names(raw_data)

reduced_data <- 
  raw_data %>% 
  select(region,
         stateicp,
         sex, 
         age, 
         race, 
         hispan,
         marst, 
         bpl,
         citizen,
         educd,
         labforce,
         inctot)
rm(raw_data)
         

#### What's next? ####
new_data <- 
  reduced_data %>%
  count(age, sex,race,labforce,educd,inctot) %>%
  group_by(age, sex,race,labforce,educd,inctot)

new_data <-
  new_data %>%
  filter(age !="less than 1 year old") %>%
  filter(age !="90 (90+ in 1980 and 1990)") %>%
  filter(as.numeric(age) > 17) %>%
  filter(as.numeric(inctot)>0) %>%
  filter(race !="two major races") %>%
filter(race !="three or more major races")

new_data$age <- as.integer(new_data$age)
new_data$inctot <- as.integer(new_data$inctot)

write_csv(new_data,"census_data.csv")  



         