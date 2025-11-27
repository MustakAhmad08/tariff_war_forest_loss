library(zoo)
library(missForest)
library(dplyr)

df <- read.csv("data/forest_loss.csv")
df$date <- as.Date(sprintf("%d-01-01", df$year))

cols_impute <- c(44, 6, 7, 8, 9, 10, 11, 12, 17, 18, 19)
col_names <- names(df)[cols_impute]

subset_df <- df %>% select(all_of(cols_impute))

set.seed(42)
im_out <- missForest(subset_df, ntree = 500, maxiter = 15)
df[cols_impute] <- im_out$ximp

zdata <- zoo(df[, cols_impute], order.by = df$date)
zdata <- na.locf(zdata)
colnames(zdata) <- col_names

save(df, zdata, col_names, file = "analysis/data_imputed.RData")