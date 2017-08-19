#DSE Module 4 - data visualization
clean.auto = function(auto.price){
  numcols <- c('price', 'bore', 'stroke', 'horsepower', 'peak.rpm')
  auto.price[, numcols] <- lapply(auto.price[, numcols], as.numeric)
  auto.price[complete.cases(auto.price),]
}

auto.price = clean.auto(auto.price)
# ggplot bar chart (categorial)
require(ggplot2)
require(repr)
options(repr.plat.width=7, repr.plot.height=5)
ggplot(auto.price, aes(fuel.type)) + geom_bar()

ggplot(auto.price, aes(x=reorder(fuel.type,fuel.type, function(x)-length(x)))) + geom_bar() + theme(axis.text.x = element_text(angle = 90, hjust =1))
## ggplot histogram (continuous)
ggplot(auto.price, aes(price)) + geom_histogram()

## ggplot2 box diagram
ggplot(auto.price, aes(x = factor(0), y = price)) + geom_boxplot()

ggplot(auto.price, aes(x = factor(fuel.type), y = price)) + geom_boxplot() + xlab('Fuel type') + ggtitle('Price by Fuel Type')

##ggplot kernel density (smoothe histogram)
ggplot(auto.price, aes(price)) + geom_density()

ggplot(auto.price, aes(price)) + geom_density(adjust = 1/5)

#ggplot2 Violin plot
ggplot(auto.price, aes(x = factor(fuel.type), y = price)) + geom_violin(trim = TRUE, draw_quantiles = c(0.25, 0.5, 0.75)) + xlab('Fuel type') + ggtitle('Price by Fuel Type')

#ggplot scatter plot with two variables
options(repr.plot.width=5, repr.plot.height=5)
ggplot(auto.price, aes(city.mpg, price)) + geom_point() + xlab('City MPG') + ylab('Price') + ggtitle('Relationship between City MPG and Price')

#ggplot kernel density plat with two variables
ggplot(auto.price, aes(city.mpg, price)) + geom_point() + geom_density2d() xlab('City MPG') + ylab('Price') + ggtitle('Relationship between City MPG and Price')

#ggplot Line graph
x = seq(1,100, length.out = 100)
df = data.frame(x = x, y = x^2)
ggplot(df, aes(x,y)) + geom_line() + ggtitle('Line plot of x vs. y')

#Using Color
options(repr.plot.width=6.5, repr.plot.height=5)
ggplot(auto.price, aes(city.mpg, price)) + geom_point(aes(color = factor(fuel.type))) + xlab('City MPG') + ylab('Price') + ggtitle('Relationship between City MPG and Price, \n with gas and diesel fule shown')

#Using transparency
options(repr.plot.width=6.5, repr.plot.height=5)
ggplot(auto.price, aes(city.mpg, price)) + geom_point(aes(color = factor(fuel.type)), alpha = 0.3) + xlab('City MPG') + ylab('Price') + ggtitle('Relationship between City MPG and Price, \n with gas and diesel fule shown')

#Marker Size
options(repr.plot.width=6.5, repr.plot.height=5)
ggplot(auto.price, aes(city.mpg, price)) + geom_point(aes(color = factor(fuel.type), size = engine.size), alpha = 0.3) + xlab('City MPG') + ylab('Price') + ggtitle('Relationship between City MPG and Price, \n with gas and diesel fule shown')

#Marker Size with custom column
auto.price$engine.size2 = auto.price$engine.size^2
ggplot(auto.auto.price$engine.size2 = auto.price$engine.size^2
ggplot(auto.price, aes(city.mpg, price)) + geom_point(aes(color = factor(fuel.type), size = engine.size2), shape = factor(aspiration)), alpha = 0.3) + xlab('City MPG') + ylab('Price') + ggtitle('Relationship between City MPG and Price, \n with gas and diesel fule shown')
price, aes(city.mpg, price)) + geom_point(aes(color = factor(fuel.type), size = engine.size2), alpha = 0.3) + xlab('City MPG') + ylab('Price') + ggtitle('Relationship between City MPG and Price, \n with gas and diesel fule shown')

#Marker Shape
ggplot(auto.price, aes(city.mpg, price)) + geom_point(aes(color = factor(fuel.type), size = engine.size2, shape = factor(aspiration)), alpha = 0.3) + xlab('City MPG') + ylab('Price') + ggtitle('Relationship between City MPG and Price, \n with gas and diesel fule shown')

#Custom bin sizes
install.packages("gridExtra")
require(gridExtra)
bw1 = (max(auto.price$price) - min(auto.price$price))/20
bw1 = (max(auto.price$price) - min(auto.price$price))/50
require(gridExtra)
p1 = ggplot(auto.price, aes(price)) + geom_histogram(binwidth = bw1) + ggtitle('Histogram of auto price with 20 bins')
p2 = ggplot(auto.price, aes(price)) + geom_histogram(binwidth = bw2) + ggtitle('Histogram of auto price with 50 bins')

grid.arrange(p1, p2, nrow = 2)

#ScatterPlot in R
options(repr.plot.width=8, repr.plot.height=8)
require(car)
scatterplotMatrix(~ wheel.base + curb.weight + engine.size + horsepower + city.mpg + price, data = auto.price)

#Facet Plot in R
options(repr.plot.width=8, repr.plot.height=3)
bw1 = (max(auto.price$price) - min(auto.price$price))/30
ggplot(auto.price, aes(price)) + geom_histogram(binwidth = bw1) + facet_grid(. ~ drive.wheels) + ggtitle('Histogram of auto price conditioned on drive wheels')

#Multi variable Facet plot
options(repr.plot.width=8, repr.plot.height=3)
bw1 = (max(auto.price$price) - min(auto.price$price))/30
ggplot(auto.price, aes(price)) + geom_histogram(binwidth = bw1) + facet_grid(fuel.type ~ aspiration) + ggtitle('Histogram of auto price conditioned on drive wheels')

#FINAL
options(repr.plot.width=8, repr.plot.height=3)
ggplot(dat, aes(DepDelay)) + geom_histogram() + facet_grid( ~ ArrDel15) + ggtitle('Histogram of flight delays conditioned by ArrDel15')
ggplot(dat, aes(CRSArrTime)) + geom_histogram() + facet_grid( ~ ArrDel15) + ggtitle('Histogram of flight delays conditioned by ArrDel15')
ggplot(dat, aes(CRSDepTime)) + geom_histogram() + facet_grid( ~ ArrDel15) + ggtitle('Histogram of flight delays conditioned by ArrDel15')
ggplot(dat, aes(DayofMonth)) + geom_histogram() + facet_grid( ~ ArrDel15) + ggtitle('Histogram of flight delays conditioned by ArrDel15')
ggplot(dat, aes(DayOfWeek)) + geom_histogram() + facet_grid( ~ ArrDel15) + ggtitle('Histogram of flight delays conditioned by ArrDel15')
ggplot(dat, aes(Month)) + geom_histogram() + facet_grid( ~ ArrDel15) + ggtitle('Histogram of flight delays conditioned by ArrDel15')

#Test multi-row
options(repr.plot.width=8, repr.plot.height=3)
ggplot(dat, aes(ArrDelay15)) + geom_histogram(binwidth = bw1) + facet_grid( DepDelay ~ .) + ggtitle('Histogram Test')

options(repr.plot.width=8, repr.plot.height=3)
ggplot(dat, aes(DepDelay, CRSArrTime, CRSDepTime, DayofMonth, DayOfWeek, Month )) + geom_histogram() + facet_grid( ArrDelay15 ~ .) + ggtitle('Histogram Test')

#Import data set into R (Azure)
library("AzureML")
ws <- workspace()
dat <- download.datasets(ws, "master.task.data.2017")

#Drop the .csv extension when the data set is created from an experiment?
library("AzureML")
ws <- workspace()
dat <- download.datasets(ws, "flightdata")

#Scatterplot using facet_grid
options(repr.plot.width=8, repr.plot.height=11)
ggplot(auto.price, aes(city.mpg, price)) + geom_point(aes(color = factor(fuel.type), size = engine.size2, shape = factor(aspiration)), alpha = 0.3) +
facet_grid(body.style ~ drive.wheels) + xlab('City MPG') + ylab('Price') + ggtitle('Relationship between City MPG and Price, \n with gas and diesel fule shown,
\n with marker radius indicating engine seize \n and shape showing aspiration')

options(repr.plot.width=8, repr.plot.height=11)
ggplot(dat, aes(DepDelay)) + geom_point(aes(color = factor(ArrDel15))) + facet_grid(~ ArrDel15) + ggtitle ('Test Scatterplot')
