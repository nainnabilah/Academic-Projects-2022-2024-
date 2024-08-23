#QUESTION A

suicides = read.csv(file.choose(),header=T)
View(suicides)

#glimpse into the first and last few observations of the data
head(suicides)
tail(suicides)

#list of variables and types in the data
str(suicides)

#fixing the format of non-numeric data and wrongly assigned categorical data
suicides$year <- as.factor(suicides$year) #year into factor
suicides$gdp_for_year.... <- as.numeric(gsub(",", "", suicides$gdp_for_year....)) #gdp into num without ew commas
suicides[sapply(suicides,is.character)] <- lapply(suicides[sapply(suicides,is.character)], as.factor)

#checking the properties of the fixed data
summary(suicides)
str(suicides)

#descriptive summary rundown

#for numerical data
library(psych)
numerical_suvar <- suicides[sapply(suicides, function(x) is.integer(x) | is.numeric(x))]
describe(numerical_suvar)

#for categorical data
#frequency/prop table
library(SmartEDA)
factor_suvar <- suicides[sapply(suicides, is.factor)]
View(ExpCTable(factor_suvar,Target=NULL,margin=1,clim=3000,round=2,bin=NULL,per=T))

#mode table
varmode <- function(x){
  a = table(x)
  return(a[which.max(a)])
}
sapply(factor_suvar,varmode)

#QUESTION B

#OVERALL DISTRIBUTION OF THE DATA

#shape and feel of the data
library(DataExplorer)
introduce(suicides)
plot_intro(suicides)

library(Hmisc)
datadensity(suicides)

attach(suicide)
library(ggplot2)
library(dplyr)

#CATEGORICAL DATA
#barcharts

facvarcols <- names(select(factor_suvar,-matches("country")))
barchart <- function(var) {
  ggplot(suicides, aes_string(x = var)) + 
    geom_bar(aes_string(fill=var), stat = "count") +
    ggtitle(paste("Bar chart for",var))+
    theme(legend.position = "none")
}

lapply(facvarcols, barchart)

#boxplots
boxplots2 <- function(var) {
  ggplot(suicides, aes_string(x = var, y= "suicides.100k.pop")) +
    geom_boxplot(aes_string(color=var)) +
    ggtitle(paste("Boxplot for",var,"by suicide rate per 100k population")) +
    theme(legend.position = "none")
}

lapply(c("sex","age","generation"), boxplots2)

boxplots <- function(var) {
  ggplot(suicides, aes_string(x = var)) +
    geom_boxplot(aes_string(color=var)) +
    ggtitle(paste("Boxplot for",var)) +
    theme(legend.position = "none")
}

lapply(c("sex","age","generation"), boxplots)

#brief exploration of the categorical data
#suicide rates per 100k population, year by year
totalyr <- suicides %>% 
  group_by(year) %>% 
  summarise(yearly = mean(suicides.100k.pop))

ggplot(totalyr, aes(x=as.numeric(as.character(year)), y=yearly)) + 
  geom_line(color="seagreen") +
  geom_point(color="seagreen") +
  ggtitle("Global Suicide Rate/100k Population by Year") +
  xlab("Year") + ylab("Suicide Rate/100k Population")

#Yearly Suicide Rate/100k Population Trend Per Gender
sexyr <- suicides %>% 
  group_by(year, sex) %>% 
  summarise(yearly = mean(suicides.100k.pop))

ggplot(sexyr, aes(x=as.numeric(as.character(year)), y=yearly, group=sex, color=sex)) + 
  geom_line() +
  geom_point() +
  ggtitle("Yearly Suicide Rate/100k Population Trend for Each Gender") +
  xlab("Year") + ylab("Suicide Rate/100k Population")


#Yearly Suicide Rate/100k Population Trend Per Age Group
ageyr <- suicides %>% 
  group_by(year, age) %>% 
  summarise(yearly = mean(suicides.100k.pop))

ggplot(ageyr, aes(x=as.numeric(as.character(year)), y=yearly, group=age, color=age)) + 
  geom_line() +
  geom_point() +
  ggtitle("Yearly Suicide Rate/100k Population Trend for Each Age Group") +
  xlab("Year") + ylab("Suicide Rate/100k Population")

#top 10 countries with the highest yearly suicide rates
countrycide <- suicides %>% 
  group_by(country) %>% 
  summarise(mean_suic100k = mean(suicides.100k.pop)) %>%
  arrange(desc(mean_suic100k)) %>%
  top_n(10)

ggplot(countrycide, aes(x = reorder(country, -mean_suic100k), y = mean_suic100k)) +
  geom_bar(stat = "identity", fill = rainbow(10)) +
  labs(title ="Suicide rate per 100k population by country", x = "Country", y = "Suicide Rate/100k Population")

#NUMERICAL DATA
#histograms
numvarcols <- names(numerical_suvar)
histogramm <- function(var) {
  ggplot(suicides, aes_string(x = var)) + 
    geom_histogram(color = "black", fill = "purple") +
    ggtitle(paste("Histogram of",var))
}

lapply(numvarcols, histogramm)

#scatterplot
scnvc <- names(subset(numerical_suvar, select = -c(suicides_no, suicides.100k.pop)))
scatterplots <- function(var) {
  ggplot(suicides, aes_string(x = var[1], y = "suicides.100k.pop")) + 
    geom_point(aes(colour = country)) +
    ggtitle(paste(var[1], "vs", "Suicides per 100k Population", "Scatterplot")) +
    theme(legend.position = "none")
}
lapply(scnvc, scatterplots)

#Distribution of Yearly Suicide Rate/100k Population by Country
library(viridis) 
library(rworldmap)

countrycidemap <- suicides %>% 
  group_by(country) %>% 
  summarise(mean_suic100k = mean(suicides.100k.pop))
            
worldmapsketch <- joinCountryData2Map(countrycidemap, joinCode = "NAME", nameJoinColumn = "country")
worldmap <- mapCountryData(worldmapsketch, 
               nameColumnToPlot="mean_suic100k", 
               colourPalette = plasma(10), 
               oceanCol="skyblue", 
               missingCountryCol="darkgrey", 
               catMethod = "pretty"); worldmap

#QUESTION C

#missing values of the data
profile_missing(suicides)
plot_missing(suicides)
#suicides_no and hdi.for.year have noticeable amounts of missing values

#QUESTION D

#more than half of hdi.for.year consists of missing values, hence the variable will be dropped
#the missing values of suicides_no, however, will be removed

suicides_new <- suicides %>%
                select(-HDI.for.year) %>%
                na.omit(); suicides_new

#recheck
introduce(suicides_new)
plot_missing(suicides_new)

#QUESTION E

#sometimes, statistical methods for a dataset are selected based on
#the data's type and distribution. according to the article titled
#"Selection of Appropriate Statistical Methods for Data Analysis",
#if the data follows a normal distribution and the sample size is 
#large, parametric methods are generally preferred while if the
#data does not follow a normal distribution or the sample size is 
#small, nonparametric methods should be used.

#in order to move onto choosing the right statistical methods to
#be used for the case study in the next question, some tests
#have to be performed to see whether the variables of the data are
#normally distributed or not.

#There are several ways to check if a dataset follows a normal distribution:

#CREATING A QQ-PLOT
plot_qq(suicides_new) #most of the numerical variables are not normally distributed

#DENSITY PLOT (+SKEW AND KURTOSIS)
densityplot <- ExpNumViz(suicides_new[sapply(suicides_new, function(x) is.integer(x) | is.numeric(x))],target=NULL,nlim=10,Page=c(2,2),sample=5); densityplot
#the density of all the numerical variables don't follow the normal bell curve shape
#and almost all of them have very high skew and kurtosis values

#NORMALITY TESTS
library(nortest)

#shapiro test
lapply(suicides_new[sapply(suicides_new, function(x) is.integer(x) | is.numeric(x))],shapiro.test) 
#can't be done since the number of observations must only be between 3 and 3000.

#Lilliefors (Kolmogorov-Smirnov) test 
lapply(suicides_new[sapply(suicides_new, function(x) is.integer(x) | is.numeric(x))],lillie.test)
#p-value of the test for all numerical variables is less than 0.05
#thus we have sufficient evidence to reject the null hypothesis 
#and conclude that all numerical variables in Suicides does not follow a normal distribution.
#(however it is known that a-d test is better than smirnov, hence:)

#anderson-darling test
lapply(suicides_new[sapply(suicides_new, function(x) is.integer(x) | is.numeric(x))],ad.test)
#p-value of the test for all numerical variables is less than 0.05
#thus we have sufficient evidence to reject the null hypothesis 
#and conclude that all numerical variables in Suicides does not follow a normal distribution.

#CONCLUSION

#since the variables in the suicides_new dataset are not normally distributed,
#in case of further analysis, parametric statistical methods such as t-tests,
#anova and pearson correlation analysis cannot be done.

#suggestions for further steps are either transforming the variables of the dataset
#via methods such as log, min-max scaling and standard scaling transformations
#or pursue non-parametric alternatives for the parametric statistical methods instead.

#QUESTION F

#(storytime)

#Spearman's rank correlation coefficient
cor.test(suicides_new$gdp_per_capita....,suicides_new$suicides.100k.pop, method="spearman")

#h0: there is no significant relationship between gdp per capita and suicide per 100k pop
#h1: there's a significant relationship between gdp per capita  and suicide per 100k pop

#since p-value is less than 0.05, there's enough evidence to reject h0 and prove
#that there is a statistically significant relationship between these two variables.
#the rho of 0.04038109 shows that there is a low but positive relationship between gdp per
#capita, meaning that while richer countries are associated with higher suicide rates,
#this relationship is very weak.

ggplot(suicides_new, aes_string(x = suicides_new$gdp_per_capita...., y = "suicides.100k.pop")) + 
  geom_point(color="powderblue") + geom_smooth(method = lm) +
  labs(title ="Relationship Between GDP per Capita and Suicide rate per 100k population", x = "GDP per Capita", y = "Suicide Rate/100k Population")

#QUESTION G 

#mean number of suicides in japan
JPSN <- (suicides_new %>%
  filter(country %in% "Japan") %>%
  select(country, suicides_no))$suicides_no; mean(JPSN)

#mean number of suicides in Mexico
MXSN <-(suicides_new %>%
      filter(country %in% "Mexico") %>%
      select(country, suicides_no))$suicides_no; mean(MXSN)

#QUESTION H

#mean ratio of number of suicides for Japan and Mexico
#(mean(number of suicides for Japan/number of suicides for Mexico))
meanratio <- mean(JPSN/MXSN); meanratio

#visualisation of ratio
library(waffle)
propor = c(Japan=meanratio,Mexico=1)
waffle(propor,rows=4,size=0.5,colors = c("deeppink3", "darkgoldenrod"),
      title = "Ratio of Mean Number of Suicides for Japan and Mexico",
      xlab = "1 square = approx. 1 number of suicide(s)")

#this means that on average, the number of suicides in Japan
#outnumbers that of Mexico by 15 to 1.

#QUESTION I

dt1 <- (suicides_new %>%
  filter(country %in% "Japan") %>%
  select(country, suicides_no))[, 2]

dt2 <- (suicides_new %>%
  filter(country %in% "Mexico") %>%
  select(country, suicides_no))[, 2]

dtb <- cbind(dt1,dt2)

library(boot)
sampler <- function(x,n){
  set.seed(100)
  results <- boot(data=x, statistic=function(d,i) mean(d[i,1]/d[i,2]), R=n)
return(results$t[,1])}

sampler(dtb,50)
hist(sampler(dtb,50), main="Histogram of 50 Bootstrap Mean Ratio Samples", xlab="Bootstrap Mean Ratio Samples", freq=FALSE)
curve(dnorm(x,mean=mean(sampler(dtb,50)),sd=sd(sampler(dtb,50))), add=TRUE,col="violetred")

sampler(dtb,500)
hist(sampler(dtb,500), main="Histogram of 500 Bootstrap Mean Ratio Samples", xlab="Bootstrap Mean Ratio Samples", freq=FALSE)
curve(dnorm(x,mean=mean(sampler(dtb,500)),sd=sd(sampler(dtb,500))), add=TRUE,col="violetred")

sampler(dtb,2000)
hist(sampler(dtb,2000), main="Histogram of 2000 Bootstrap Mean Ratio Samples", xlab="Bootstrap Mean Ratio Samples", freq=FALSE)
curve(dnorm(x,mean=mean(sampler(dtb,2000)),sd=sd(sampler(dtb,2000))), add=TRUE,col="violetred")

sampler(dtb,5000)
hist(sampler(dtb,5000), main="Histogram of 5000 Bootstrap Mean Ratio Samples", xlab="Bootstrap Mean Ratio Samples", freq=FALSE)
curve(dnorm(x,mean=mean(sampler(dtb,5000)),sd=sd(sampler(dtb,5000))), add=TRUE,col="violetred")
