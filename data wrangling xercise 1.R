install.packages("dplyr")
install.packages("tidyr")

library(dplyr)
library(tidyr)

#1 tidy first column values
refine2 <- tbl_df(refine_original)
refine2[1:6,1]<-'philips'
refine2[7:13,1]<-'akzo'
refine2[14:16,1]<-'philips'
refine2[17:21,1]<-'van houten'
refine2[22:25,1]<-'unilever'

#2: Separate product code and number into separate columns (product_code and product_number)
# What is the way to do this whilst keeping the original column as well?
refine2<- 
refine2 %>%
separate(Product.code...number, into = c("product_code", "product_number"), sep = "\\-")
refine2 %>% View()

#3: Add a column with the product category for each record. p = Smartphone v = TV x = Laptop q = Tablet
refine2$product_category[refine2$product_code == "p"] <- "Smartphone"
refine2$product_category[refine2$product_code == "v"] <- "TV"
refine2$product_category[refine2$product_code == "x"] <- "Laptop"
refine2$product_category[refine2$product_code == "q"] <- "Tablet"
refine2 %>% View()
  
#4: Create a new column full_address that concatenates the three address fields (address, city, country), separated by commas.

refine2<- 
  refine2 %>%
    mutate(full_address = paste(address,city,country,sep=","))
refine2 %>% View()

#5: Create dummy variables for company and product category

    refine2<-
      refine2 %>%
       mutate(company_philips = ifelse(company=='philips',1,0)) %>%
       mutate(company_akzo = ifelse(company=='akzo',1,0)) %>%
       mutate(company_van_houten = ifelse(company=='van_houten',1,0)) %>%
       mutate(company_unilever = ifelse(company=='unilever',1,0)) %>%
       mutate(product_smartphone = ifelse(product_category=='Smartphone',1,0)) %>%
       mutate(product_tv = ifelse(product_category=='TV',1,0)) %>%
       mutate(product_laptop = ifelse(product_category=='Laptop',1,0)) %>%
       mutate(product_tablet = ifelse(product_category=='Tablet',1,0))
          refine2 %>% View()
   