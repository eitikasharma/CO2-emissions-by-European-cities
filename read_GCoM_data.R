
# Loading the tidyverse package
require(tidyverse)

# Reading data from 'GCoM_emissions.csv'
DFbE = read_csv("C:/Users/LENOVO/Documents/R Assignment/GCoM_emissions.csv") %>%
  rename(Id = 'GCoM_ID',
         City = 'signatory name',
         Country_Code = 'country code',
         HDD = 'Heating Degree-Days (HDD)',
         GDP = 'GDP per capita at NUTS3 [Euro per inhabitant]',
         Emission = 'GHG emissions per capita in GCoM sectors_EDGAR [tCO2-eq/year]',
         Population = 'population in 2018') %>%
  select(Id, City, Country_Code, HDD, GDP, Emission, Population)

# Reading data from 'GCoM_emissions_by_sector.csv'
DFbS = read_csv("C:/Users/LENOVO/Documents/R Assignment/GCoM_emissions_by_sector.csv") %>% 
  rename(Id = 'GCoM_ID',
         Emission_Sector = 'emission_inventory_sector',
         EmissionbS='emissions') %>%
  select(Id, Emission_Sector,EmissionbS)


# Element 1

##Data Filter 
# Filter rows with missing 'Population'
Pop_filter <- DFbE %>% filter(is.na(Population))

#Missing value count for Emission
print(sum(is.na(DFbE$Emission)))

#Missing value count for Population
print(sum(is.na(DFbE$Population)))

#NA values dropped for Emission and Population
Cleaned_DFbE <- DFbE %>% filter(!is.na(Emission) & !is.na(Population))


##Country Count
CountryDF <- Cleaned_DFbE$Country_Code
Country_Count <- as.data.frame(table(CountryDF))
print(Country_Count)


## City Count
CityDF <- DFbE$City
City_Count <- as.data.frame(table(CityDF))
print(City_Count)


##Ordering the Cleaned_DFbE
Ordering_Cleaned_DFbE<- Cleaned_DFbE %>% group_by(Country_Code) %>% summarize(City_Count = n()) %>% arrange(desc(City_Count))

#Country with maximum cities
Max_Cities <- Ordering_Cleaned_DFbE %>% slice(1)

#Country with minimum cities
Min_Cities <- Ordering_Cleaned_DFbE %>% arrange(City_Count) %>% slice(1)


# Element 2

Cleaned_DFbE %>% select(Country_Code, City , Population) -> Country_Population

# Histogram
hist(Cleaned_DFbE$Population, breaks = 20, col = "red", border = "black",
     main = "Histogram of City Population", xlab = "Population", ylab = "Count")

##Maximum populated cities
print(Max_Popluated_City <- Country_Population %>% arrange(Population) %>% slice(n()))

##Minimum populated cities
print(Min_Popluated_City <- Country_Population %>% arrange(Population) %>% slice(1))

##median 
print(Median_Popluation <- median(Cleaned_DFbE$Population))



## Element 3

Cleaned_DFbE %>% arrange(Country_Code) %>% group_by(Country_Code, 
                                              Emission) %>% ggplot(aes(x = Country_Code, y = Emission)) + geom_boxplot(fill = 'light pink') + 
  labs(title = "Emissions per Capita by Country", x = "Country", y = "Emissions per Capita") +
  theme(plot.title = element_text(color = "purple", hjust = 0.5))+
  scale_y_continuous(breaks = seq(0, 20, by = 1))



# Median emissions per capita and arranging in ascending order
Median_Emissions <- Cleaned_DFbE %>%
  group_by(Country_Code) %>%
  summarize(Median_Emissions = median(Emission)) %>%
  arrange(Median_Emissions)  

# Top 3 countries by median emissions per capita
print(Top3Countries <- tail(Median_Emissions, 3))

# Bottom 3 countries by median emissions per capita
print(Bottom3Countries <- head(Median_Emissions, 3))



##Element 4

ggplot(DFbS, aes(x = Emission_Sector, y = EmissionbS, fill = Emission_Sector))+
  geom_bar(stat = "identity") +
  labs(title = "Total Emissions by Sector",
       x = "Sectors",
       y = "Emission") +
  theme_minimal()+
  theme(axis.text.x = element_blank(),
        axis.line = element_line(size = 0.7),
        plot.title = element_text(color = "darkgreen", hjust = 1),
        plot.background = element_rect(fill = "lightgray"))


#Element 5

Joined_DF <- DFbE %>% left_join(DFbS, by = "Id")

ggplot(Joined_DF, aes(x = EmissionbS, y = reorder(Country_Code, EmissionbS), fill = Emission_Sector)) +
  geom_bar(position = position_fill(reverse = TRUE), stat = "identity", width = 0.7) +
  labs(title = "Emissions by Sector and Country",
       x = "Emission",
       y = "Country") +
  theme_minimal() +
  scale_fill_brewer(palette = "Set1")+
  theme(plot.title = element_text(color = "darkgreen"),
        axis.text.y = element_text(size = 6),  
        axis.text.x = element_text(hjust = 1, size = 8))+
  scale_x_continuous(breaks = seq(0, 1, by = 0.1))


#Element 6


scandinavian_colors <- c('se' = 'blue', 'fi' = 'brown', 'dk' = 'orange', 'no' = 'darkgreen')

ggplot(Joined_DF, aes(x = HDD, y = Emission, color = Country_Code)) +
  geom_point(size = 2, alpha = 0.5) +  
  labs(x = 'Heating Degree-Days (HDD)', y = 'Emissions') +
  scale_color_manual(values = scandinavian_colors) +  
  guides(color = guide_legend(title = 'Scandinavian Countries')) +
  theme_minimal() +
  theme(
    legend.position = 'top',  
    legend.title = element_text(size = 10),  
    legend.text = element_text(size = 8),  
    axis.text = element_text(size = 8),  
    axis.title = element_text(size = 10)
  )+
  scale_x_continuous(breaks = seq(0, 7000, by = 500))+
  scale_y_continuous(breaks = seq(0, 20, by = 1))


##Element 7

DFbE7 <- na.omit(Joined_DF)

CityMaxGDP <- DFbE7 %>% filter(GDP == max(GDP))
NewDF<- DFbE7 %>% filter(City != CityMaxGDP$City)
print(CityMaxGDP)
ggplot(data = NewDF, aes(x = GDP, y = Emission)) +
  geom_point(color = "orange", size = 2, alpha = 0.2) +  
  labs(
    x = "GDP",
    y = "Emissions",
  ) +
  theme_minimal() +
  theme(
    axis.text = element_text(size = 8),
    axis.title = element_text(size = 10)
  ) +
  scale_x_continuous(breaks = seq(0, 140000, by = 10000)) +
  scale_y_continuous(breaks = seq(0, 15, by = 1))


