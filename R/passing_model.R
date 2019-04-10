library(tidyverse)
library(FC.rSTATS)
library(StatsBombR)

#ligue_one_files <- list.files("../data/ligue_1")
statsbomb_data <- StatsBombFreeEvents()

world_cup_events <- statsbomb_data %>% filter(competition_id == 43)
wsl_events <- statsbomb_data %>% filter(competition_id == 37)
nwsl <- statsbomb_data %>% filter(competition_id == 49)

passes <- wsl_events %>% 
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
           pass.no_touch) %>%
    separate(location, into = c("z", "pass.start.x", "pass.start.y")) %>%
    separate(pass.end_location, into = c("y", "pass.end.x", "pass.end.y")) %>%
    select(-z, -y)

receptions <- wsl_events %>% 
    filter(type.name == "Ball Receipt*") %>%
    select(related_events,
           under_pressure)

names(receptions) <- c("related_events", "receiver_pressured")

passes$receiver_under_pressure <- FALSE
passes$received <- FALSE
for(i in nrow(passes)) {
    rel_events <- unlist(passes$related_events[i])
    for(event in rel_events) {
        event_info <- wsl_events %>% 
            filter(id == event) %>%
            select(type.name, under_pressure)
        under_press <- event_info$under_pressure
        if(event_info$type.name == 'Ball Receipt*') {
            passes$received[i] <- TRUE
        } else if(event_info$type.name == "Dispossessed") {
            passes$received[i] <- FALSE
        } else if(event_info$type.name == "Ball Recovery") {
            passes$received[i] <- FALSE
        } else if(event_info$type.name == "Interception") {
            passes$received[i] <- FALSE
        } else if(event_info$type.name == "Block") {
            passes$received[i] <- FALSE
        } else {
            passes$received[i] <- FALSE
        }
    }
    
}
