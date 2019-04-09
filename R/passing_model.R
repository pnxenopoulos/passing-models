library(tidyverse)
library(FC.rSTATS)
library(StatsBombR)

#ligue_one_files <- list.files("../data/ligue_1")
statsbomb_data <- StatsBombFreeEvents()

world_cup_events <- statsbomb_data %>% filter(competition_id == 43)
wsl_events <- statsbomb_data %>% filter(competition_id == 37)
nwsl <- statsbomb_data %>% filter(competition_id == 49)

test <- wsl_events %>% 
    filter(type.name == "Pass") %>%
    select(id, 
           related_events,
           period,
           minute,
           duration,
           location,
           under_pressure,
           play_pattern.name,
           player.name,
           position.name,
           pass.length,
           pass.angle,
           pass.cross,
           pass.end_location,
           pass.switch,
           pass.cut_back,
           pass.shot_assist,
           pass.through_ball,
           pass.aerial_won,
           pass.height.name,
           pass.type.name,
           pass.body_part.name,
           pass.outcome.name,
           pass.straight,
           pass.out,
           pass.inswinging,
           pass.backheel,
           pass.outswinging,
           pass.deflected,
           pass.miscommunication,
           pass.no_touch)
    