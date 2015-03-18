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


