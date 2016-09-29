# title: "Data Wrangling 1"
# author: "Leigh Fonseca"
# date: "September 24, 2016"


library(tidyr)
library(dplyr)

# Load CSV file and create a data frame
refine_original <- read.csv("refine_original.csv")
refine_df <- tbl_df(refine_original)

# Clean up brand names
refine_df <- refine_df %>%
  mutate(first_letter = substr(tolower(company),1,1)) %>%
  
  # refine_df$first_letter
  
  # refine_co <- refine_df %>%
  mutate(company = ifelse(first_letter == "p", "philips",
                          ifelse(first_letter == "f", "philips",
                          ifelse(first_letter == "a", "akzo",
                                 ifelse(first_letter == "v", "van houten",
                                        ifelse(first_letter == "u", "unilever","unknown"))))))

# Separate product code and number
refine_df <- refine_df %>%
  separate(Product.code...number, into = c("product_code","product_number"), sep = "-")

# Transform Product Codes to Product Categories
refine_df <- refine_df %>%
  mutate(product_category = ifelse(product_code == "p", "Smartphone",
                                   ifelse(product_code == "v", "TV",
                                          ifelse(product_code == "x", "Laptop",
                                                 ifelse(product_code == "q", "Tablet", "Unknown")))))

# refine_df$product_category

# Add full address for geocoding
refine_df <- refine_df %>%
  mutate(full_address = paste(address, city, country, sep = ", "))

# Create dummy variables for company and product category
refine_df <- refine_df %>%
mutate(company_philips = ifelse(company == "philips",1,0 )) %>%
mutate(company_akzo = ifelse(company == "akzo",1,0 )) %>%
mutate(company_van_houten = ifelse(company == "van houten",1,0 )) %>%
mutate(company_unilever = ifelse(company == "unilever",1,0 )) %>%
mutate(product_smartphone = ifelse(product_category == "Smartphone",1,0)) %>%
mutate(product_tv = ifelse(product_category == "TV",1,0)) %>%
mutate(product_laptop = ifelse(product_category == "Laptop",1,0)) %>%
mutate(product_tablet = ifelse(product_category == "Tablet",1,0))

# Output cleaned up file

write.csv(refine_df, file="refine_clean.csv")



