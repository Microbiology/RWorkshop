# GTV & Dermatology R Workshop
# Geoffrey Hannigan
# Elizabeth Grice Lab
# University of Pennsylvania

####################
# Part 1: R Basics #
####################

### Intro to RStudio ###

# R studio is a great tool for easily using R
# You can download R studio by visiting the following link:
# http://www.rstudio.com/
# RStudio sections allow for scripting, running scripts, and visualizing plots, variables, and packages (more on these later).

### The Basic R Functions ###

# You can perform functions in R by entering commands into the R command prompt
# Examples are basic addition and multiplication
2 + 2
3 * 3

# Comments are sections of code that are not used by R
# This allows you to type whatever you want after the pound symbol
2 + 2 #Y ou can use a comment to mention the answer is 4

# Variables are letters or words that represent a value
# These can be assigned using the equal symbol (=) or an arrow (<-)
x = 5
y <- 4*4 # This will assign the result of the equation as y

# Variables can be used just like the values they represent
# An example is adding the two values we assigned above
x + y # The answer is 21, which is the same as 16+5

### R Functions ###
# R functions are specialized commands that perform a more complicated task. These are called by typing the name, followed by parenthesis and often some arguments.
# See the help menu for more details on the specific arguments to include with your function of interest
# An example of a function is c, which combines values into a vector (we will discuss vectors below).
c(1,2,3,4,5)
c(1:5) # The colon causes R to go through the digits between the first and second number
# Next we will use functions to install R packages

### R Packages ###
# R packages are sets of scripts that can be easily added to the working R environment, and often serve specific specialized functions
# R packages are often stored in CRAN (the Comprehensive R Archive Network; http://cran.r-project.org/)
# CRAN R packages can be easily installed through the command line
install.packages("ggplot2")
# Once the package is installed, you need to load it into the active R session
library("ggplot2") # We will be using this package later

### R Vectors ###
# A vector is one-dimensional data structure containing a set of values (of the same type)
# Above we made a vector of numbers using the c function
c(1:10)
# A specific value can be extracted from a vector using square brackets
c(1:10)[3] # Returns the third value of the vector (counting starts at one)
# Calculations can also be performed on the values of a vector
c(1:10) * 5 # The result is a vector with each value multiplied by five
# There are a lot of other useful functions for R vectors, which you should explore in greater depth
z <- c(1:10)
length(z) # Get the number of values in the vector z
mean(z) # Calulate the mean of the vector z

### Data Frames ###
# A data frame is basically a list of vectors of equal length.
# It is a tool for storing data tables, and is similar to a spreadsheet in MS Excel
# As an example, we can look at the "iris" plant dataset, which is already included in R
# To see the data frame, simply type its name, or use the View function in RStudio
iris
View(iris)
# The column names can be listed as a vector
colnames(iris)
# A row or column can be extracted using square brackets
iris[2,] # Show the second row of the data frame
iris[,2] # Show the second column of the data frame as a vector
iris[,-2] # Show everything except the second column
iris[,"Sepal.Width"] # Names can also be used to specify a column
iris[2,2] # Combine the two to the the second field of the second column
iris$Sepal.Width # Another way of specifying the second column of the data frame, using the column name
# Calculations can also be performed on columns (or rows) of the data frame
mean(iris$Sepal.Width) # Calculate the mean of the sepal width column values
median(iris$Sepal.Width) # Calculate median
100 * iris$Sepal.Width # Multiply every value of the column by 100, and save the values into a vector

### Plotting with ggplot ###
# There are multiple options for generating plots in R
# One of the best options is using the ggplot2 package. This is a little difficult to get used to, but offer a wide range of abilities.
# Before use, the package needs to be installed and loaded, as described above.
# As an example, we will generate a box plot of sepal widths, grouped by the species
# Here the function is first specified, followed by the data frame (iris), the column names used for the x and y axes, and an added section (using plus symbol) to specify generation of a box plot.
ggplot(iris, aes(x=Species, y=Sepal.Width)) + geom_boxplot()
ggplot(iris, aes(x=Species, y=Sepal.Width)) + theme_classic() + geom_boxplot() # Add the classic theme
ggplot(iris, aes(x=Species, y=Sepal.Width)) + theme_classic() + geom_boxplot(color="blue") # Add color to the plot
ggplot(iris, aes(x=Species, y=Sepal.Width, fill=Species)) + theme_classic() + geom_boxplot() + scale_fill_brewer(palette="Set2") # Add color by group
ggplot(iris, aes(x=Species, y=Sepal.Width, fill=Species)) + theme_classic() + geom_boxplot() + scale_fill_brewer(palette="Set2") + ggtitle("Iris Sepal Length by Species") # Add a title to the plot


########################################
# Part 2: Going Through A Real Example #
########################################
# Here we will go through a real example of comparing two group means and plotting the results
# We are going to use the iris example dataset, which has been saved as a .csv file (means the values are seperated by "," symbol).
# Before we start working in R, we can open the file in Excel to see what it looks like in an environment we are more used to.
# In the future we can save a file as a csv for input into R by simply clicking "Save As" and choosing the csv file type.
# It can be important the the new line symbols are Unix and not Mac or Windows. We can easily fix newlines in an Excel saved csv by opening it in "TextWrangler" and saving the file again, and selecting the Unix newline characters (we will talk a bit more about this in the workshop).

# First we can load the file using the read.delim function
# To work with the file later, we will assign it to a variable
# This will be saved as a data frame
SepalDF <- read.delim("~/git/UPennRWorkshop/IrisRExampleDataset.csv", sep=",", header=TRUE)
# In RStudio we can now visualize the data frame in an easy spreadsheet format
View(SepalDF)
# Note the spaces are replaced by dots. We do not want spaces in our dataset.

# We can use a histogram to see if the data is normally distributed around a mean.
ggplot(SepalDF, aes(x=Sepal.Width)) + theme_classic() + geom_histogram(binwidth = 0.1)
# We can also look at it by group using the facet funciton. We can also add color.
ggplot(SepalDF, aes(x=Sepal.Width)) + theme_classic() + geom_histogram(binwidth = 0.1) + facet_grid(~Species)

# Next we are going to calculate the mean sepal widths for each species.
# Performing the mean over all is very easy
mean(SepalDF$Sepal.Width)
# Getting the mean for every group is slightly more complicated because we have to use the dplyr function
# First we need to load the plyr package
install.packages("plyr")
# Load it into the active R session
library("plyr")
# Here we are only going to look at only the Setosa and Virginica species, so let's also remove the Versicolor species using the data frame techniques we mentioned above (this is a little more complicated but we will go through it).
# We are again saving the new data frame result as a variable
SepalDfTwoSpecies <- SepalDF[-which(SepalDF$Species %in% "versicolor"),]
# To understand what is going on, we can run the different parts of the function
SepalDF$Species # This specifies only the Species column of the data frame, which is what we want to work with. The output is a vector
which(SepalDF$Species %in% "versicolor") # Ever row in the data frame has a row number like the row numbers in an Excel spreadsheet. We use which to tell us the row numbers where the Sepal Species value matches (%in%) "versicolor".
-which(SepalDF$Species %in% "versicolor") # This adds a minus sign to each row name
SepalDF[-which(SepalDF$Species %in% "versicolor"),] # As mentioned above, we can provide row or column numbers in square brackets for extraction. A minus sign tells it to give all rows or columns except the one specified. Here we are getting all of the rows except the ones which had the Species column value of "versicolor".
# View the new data frame
View(SepalDfTwoSpecies)

# Now we can easily calculate the mean and std error of the two groups using the plyr package we loaded above.
SepalStats <- ddply(SepalDfTwoSpecies, # The dataframe that we wanted to use
                    c("Species"), # A vector containing the grouping for summary stats
                    summarise, # Tell it we want to summarize the data
                    mean=mean(Sepal.Width), # Calculate the mean Sepal Width for each group we specified
                    std_deviation = sd(Sepal.Width), # Calculate standard deviation
                    std_error = sd(Sepal.Width)/sqrt(length(Sepal.Width))) # Calculate standard error
# We can view the stats in the variable
View(SepalStats)

# We can now use this data to graph the results as a bar plot using ggplot
# Use geom_bar to create a bar plot
# Use geom_errorbar to set the error bars using the column names in our sepal stats data frame
ggplot(SepalStats, aes(x=Species, y=mean, fill=Species)) + theme_classic() + geom_bar(position=position_dodge(), stat="identity", width=0.5) + geom_errorbar(aes(ymin=mean-std_error, ymax=mean+std_error), width=.2) + scale_fill_brewer(palette="Set2") + ggtitle("Species Difference in Sepal Width")

# This data looks pretty significantly different, but we want to actually run the stats.
# A very basic statistical test is a t-test for differences between two means.
# This assumes normally distributed data, which we supported above with the histograms.
# We can perform this test easily using the most basic t.test function.
# Here we are telling it the values are in the column before the "~", the column for grouping is in the column specified after the "~", and the data frame containing the columns is specified after the column
SepalTTest <- t.test(Sepal.Width ~ Species, SepalDfTwoSpecies)
# See the statistics results
SepalTTest
# An example if you just want to see the p-value
SepalTTest$p.value
# This is a low p-value, so we would say that this difference is significantly different.






