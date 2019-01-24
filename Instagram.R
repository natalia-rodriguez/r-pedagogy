# Loading libraries
# install.packages("dplyr")
# install.packages("ggplot2")
# install.packages("tidyr")
# install.packages("tidyverse")
library(dplyr)
library(ggplot2)
library(tidyr)

# Loading data into data frame and formatting
insta <- read.csv("Instagram.csv", header=TRUE, sep=",", as.is=TRUE)
insta[1:10,]	# First ten rows
colnames(insta) <- c("user", "posts", "followers", "following", "likes10", "likes11", "likes12", "self_posts","sex","date")


summary(insta)

## Setting up fonts
quartzFonts(avenir = c("Avenir Book", "Avenir Black", "Avenir Book Oblique", 
                       "Avenir Black Oblique"))
par(family = 'avenir')


# Plotting in Base R
plot(insta$following, insta$followers , las=1, xlab="Following",
     ylab="Followers", main="Instagram Users Followers by Gender", col=sex)

# fi_df %>%
#   group_by(phone,type)%>%
#   subset(type %in% c("Received text","Sent text")) %>%
#   subset(name="Natalia")%>%
#   summarize(count=n())%>%
#   mutate(total=sum(count),pct=count/total)

#Formatting Data
str(insta)
insta$followers <- as.numeric(gsub(",", "", insta$followers))
insta$following <- as.numeric(gsub(",", "",insta$following))
insta$posts <- as.numeric(gsub(",", "",insta$posts))
str(insta)

# Settings ggplot 
options(scipen=999)  # turn-off scientific notation like 1e+48
theme_set(theme_bw())  # pre-set the bw theme.
data("insta", package = "ggplot2")

# Scatterplot
gg <- ggplot(insta, aes(x=followers, y=likes10)) +
  geom_point(aes(col=sex,size=posts)) +
  geom_smooth(method="loess", se=F) +
  labs(subtitle="Followers vs Likes",
       y="Likes on 10th post",
       x="Followers",
       title="Instagram Engagement",
       caption = "Source: instagram")

plot(gg)


## Getting gender average
by_gender <- group_by(insta,insta$sex)
by_gender[1:10,]
str(by_gender)
summary(insta)

avg_likes <- insta %>% 
  group_by(sex) %>% 
  summarise(mean = mean(likes10))
head(avg_likes)


## Barplot
ggplot(avg_likes, aes(x=sex, y=mean)) + 
  geom_bar(stat="identity", width=.5, fill="tomato3") + 
  labs(title="Followers by Gender", 
       subtitle="Who has more followers on Average", 
       caption="source: insta") + 
  theme(axis.text.x = element_text(angle=65, vjust=0.6))


## Instagram Influencers analysis
insta$influence_ratio <- insta$followers / insta$following
#head(insta)
median(insta$influence_ratio)
mean(insta$influence_ratio)
influencers <- subset(insta, insta$influence_ratio > mean(insta$influence_ratio))
influencers

## Adding columns w mutate
insta <- mutate(insta, p2f=posts/followers)
head(insta)