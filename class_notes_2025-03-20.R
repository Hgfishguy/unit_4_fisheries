# class notes 3/20/25

# see Help bar for data transformation cheat sheet

#### Joining data

# mutate adds observations
# filter removes observations
library(dplyr)
library(tidyverse)

data1 = data.frame(ID = c(1,2), X1 = c("a1", "a2"))

data1
data2 = data.frame(ID = c(2,3), X1 = c("b1", "b2"))

data2
# notice how both dataframes have a column in common

# left join (use this most often)
# uses left data frame as a base, adds right data frame based on "by = " command
# all data from left data frame kept, only matching from right kept
# Mismatched cells generate NAs 
data12_left = left_join(data1, data2, by = "ID")
data12_left
data12_left = data1 %>%
  left_join(data2, by = "ID")

# right join 
# same as left, but joins using right data frame as the base
data12_right = right_join(data1, data2, by = "ID")
data12_right

# inner join
# joins both together using only parameters that they have in common 
data12_inner = inner_join(data1, data2, by = "ID")
data12_inner

# full join 
# keeps ALL data
data12_full = full_join(data1, data2)
data12_full

#### ALWAYS CHECK DIMENSIONS OF DATA BEFORE AND AFTER JOINING

# filtering joins

# semi join acts as a filter on data1 without adding rowns, removing cells that don't match with data2
data12_semi = data1 %>%
  semi_join(data2, by = "ID")

data12_semi

# anti join
# does the opposite of semi join, retains only data that doesn't match
data12_anti = anti_join(data1, data2, by = "ID")

data12_anti

#### Switching between long and wide data frames
## turning row to columns and columns to rows

survey = data.frame(quadrat_ID = c(101, 102, 103, 104), 
                    barnacle = c(2, 11 ,8, 27), 
                    chiton = c(1, 0, 0, 2), 
                    mussel = c(0, 1, 1 ,4))
survey

# pivot longer turns columns into rows
long = survey %>%
  pivot_longer(cols = c("barnacle", "chiton", "mussel"), 
               names_to = "beastie", 
               values_to = "counts")
long

# pivot wider turns rows into columns 
wide = long %>%
  pivot_wider(names_from = beastie, values_from = counts)
wide

#### Moral of the story is that long datasets are better for plotting, but wide are better for modelling

# exercise 1.2
ggplot() +
  geom_point(aes(x = quadrat_ID, y = barnacle), data = wide)
