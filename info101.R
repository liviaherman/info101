library(ggplot2)
library(marinecs100b)




# Questionable organization choices ---------------------------------------

# P1 Call the function dir() at the console. This lists the files in your
# project's directory. Do you see woa.csv in the list? (If you don't, move it to
# the right place before proceeding.)
dir()
getwd()
# P2 Critique the organization of woa.csv according to the characteristics of
# tidy data.
#The data is not a rectangle and the titles are not constant with one another.
#Additionally, some of the title has numbers in it and this can confuse the
#computer

# Importing data ----------------------------------------------------------

# P3 P3 Call read.csv() on woa.csv. What error message do you get? What do you
# think that means?
read.csv("woa.csv")
read.csv
#I got an error saying woa.csv not found. This means that R cannot locate the
#woa.csv file.
?read.csv

# P4 Re-write the call to read.csv() to avoid the error in P3.
read.csv("woa.csv", header = FALSE, sep = ",", quote = "\"",
         dec = ".", numerals = "no.loss", fill = TRUE,
         comment.char = "", skip = 1)

# Fix the column names ----------------------------------------------------

# P5 Fill in the blanks below to create a vector of the depth values.

depths <- c(
  seq(0, 100, by = 5),
  seq(100, 500, by = 25),
  seq(500, 2000, by = 50),
  seq(2000, 5500, by = 100)
)


# P6 Create a vector called woa_colnames with clean names for all 104 columns.
# Make them the column names of your WOA data frame.
woa_colnames <- c("latitude","longitude", paste0("Depth", depths))
paste0("Depth", depths)
?paste


# Analyzing wide-format data ----------------------------------------------

# P7 What is the mean water temperature globally in the twilight zone (200-1000m
# depth)?

?mean
depths[25]
depths[49]
woa_wide <- read.csv("woa.csv", skip=1)
woa_twilight <- woa_wide[ , 27:49]
sum_woa_twilight <- sum(woa_twilight, na.rm = TRUE)
num_measurements <- (sum(!is.na(woa_wide[, 27:49])))
sum_woa_twilight/num_measurements
#mean is 6.57...

# Analyzing long-format data ----------------------------------------------

# P8 Using woa_long, find the mean water temperature globally in the twilight zone.



View(woa_long)
twilight_temps <- woa_long[woa_long$depth_m >= 200 & woa_long$depth_m <= 1000,4]
mean(twilight_temps)



# P9 Compare and contrast your solutions to P8 and P9.
#Long is easier to work with while wide is more challenging and takes a lot
#of indexing.In long you can use actual values.

# P10 Create a variable called mariana_temps. Filter woa_long to the rows in the
# location nearest to the coordinates listed in the in-class instructions.

install.packages("ggplot2")
library(ggplot2)

mariana_temps <- woa_long[woa_long$latitude == 11.5 & woa_long$longitude == 142.5, ]
ggplot(mariana_temps, aes(temp_c, depth_m)) +
  geom_path() +
  scale_y_reverse()
ggsave("mariana_temp_depth_png")

colnames(woa_long)

# P11 Interpret your temperature-depth profile. What's the temperature at the surface? How about in the deepest parts? Over what depth range does temperature change the most?
#The temp_depth profile at its deepest (5000m) reached the coldest temperatures
#Close to 1C. Temperatures closest to the surface (10-0m) are much warmer reaching around
# 20-30C

# ggplot is a tool for making figures, you'll learn its details in COMM101
ggplot(mariana_temps, aes(temp_c, depth_m)) +
  geom_path() +
  scale_y_reverse()
