categories = c(p = "smartphone", v = "tv", x = "laptop", q = "tablet") 
product_category <- categories[df$product.code] # define new variable product_category, rather than ifelse
df <- mutate(df, product.cat = product_category) # not needed, could just do df$product.cat == df$product_category

or
categories = c(p = "smartphone", v = "tv", x = "laptop", q = "tablet") 
df$product.cat <- categories[df$product.code]