#packages
install.packages("janitor") #

#libraries
library(readxl)
library(readxl)
library(tidyverse)
library(janitor)

#-------------------DATA IMPORTING PROCESS
setwd("~/Desktop/Rdirectory") # setting up the working directory

Time<- read_excel("bicycle theft.xlsx", sheet = 4, range ="A9:L24" )
Where<- read_excel("bicycle theft.xlsx", sheet =5, range ="A9:L19" )
Cost<- read_excel("bicycle theft.xlsx", sheet =6, range ="A9:L20" )

#__explore data
str(Time)

#__renaming variables
Time<-Time %>% 
  rename("time"="...1")

Cost<-Cost %>% 
  rename("cost"="...1")

Where<-Where %>% 
  rename("where"="...1")
view(Time)

str(Time)

Time<-Time %>% 
  rename("2012"="Apr 2012 to Mar 2013",
         "2013"="Apr 2013 to Mar 2014",
         "2014"="Apr 2014 to Mar 2015",
         "2015"="Apr 2015 to Mar 2016",
         "2016"="Apr 2016 to Mar 2017",
         "2017"="Apr 2017 to Mar 2018",
         "2018"="Apr 2018 to Mar 2019",
         "2019"="Apr 2019 to Mar 2020",
         "2022"="Apr 2022 to Mar 2023 [note 2]")
Time<-Time[,1:10] #selecting column 1-10 from time variable

Time<-Time %>%
  mutate(across(where(is.numeric), ~ round(.x, digits = 2))) %>% 
  mutate(time = gsub("\\[.*?\\]", "", time)) %>% 
  filter(time!="Unweighted base - number of incidents")

Cost<-Cost %>% 
  rename("2012"="Apr 2012 to Mar 2013",
         "2013"="Apr 2013 to Mar 2014",
         "2014"="Apr 2014 to Mar 2015",
         "2015"="Apr 2015 to Mar 2016",
         "2016"="Apr 2016 to Mar 2017",
         "2017"="Apr 2017 to Mar 2018",
         "2018"="Apr 2018 to Mar 2019",
         "2019"="Apr 2019 to Mar 2020",
         "2022"="Apr 2022 to Mar 2023[note 2]")
Cost<-Cost[,1:10] #selecting column 1-10 from cost variable

Cost<-Cost %>%
  mutate(across(where(is.numeric), ~ round(.x, digits = 2))) %>% 
  mutate(cost = gsub("\\[.*?\\]", "", cost)) %>% 
  filter(cost!="Unweighted base - number of incidents")
Where<-Where %>% 
  rename("2012"="Apr 2012 to Mar 2013",
         "2013"="Apr 2013 to Mar 2014",
         "2014"="Apr 2014 to Mar 2015",
         "2015"="Apr 2015 to Mar 2016",
         "2016"="Apr 2016 to Mar 2017",
         "2017"="Apr 2017 to Mar 2018",
         "2018"="Apr 2018 to Mar 2019",
         "2019"="Apr 2019 to Mar 2020",
         "2022"="Apr 2022 to Mar 2023 [note 2]")
 
Where<-Where[,1:10] #selecting column 1-10 from where variable


Where<-Where %>%
  mutate(across(where(is.numeric), ~ round(.x, digits = 2))) %>% 
  mutate(where = gsub("\\[.*?\\]", "", where)) %>% 
  filter(where!="Unweighted base - number of incidents")

# Reshape datasets to long format (for visualisation purposes)
cost_long <- Cost %>%
  pivot_longer(cols = 2:10, names_to = "Year", values_to = "value") %>% 
  filter(cost!="No cost")

time_long <- Time %>%
  pivot_longer(cols = starts_with("20"), names_to = "Year", values_to = "value")

where_long <- Where %>%
  pivot_longer(cols = starts_with("20"), names_to = "Year", values_to = "value")


# View the combined dataset
print(combined_data)

  
  # Saving the data as csv
write.csv(Time,"time.csv", row.names = FALSE)
write.csv(Where,"where.csv", row.names = FALSE)
write.csv(Cost,"cost.csv", row.names = FALSE)

write.csv(time_long,"time_long.csv", row.names = FALSE)
write.csv(where_long,"where_long.csv", row.names = FALSE)
write.csv(cost_long,"cost_long.csv", row.names = FALSE)