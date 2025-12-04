library(tseries)
library(urca)
library(vars)
library(dplyr)

# 1. Load Data --------------------------------------------------------------
df <- read.csv('/Users/mustakahmad/Library/CloudStorage/OneDrive-purdue.edu/FACAI LAB/Project3_tariff/tariff_war/raw_data/forest_loss.csv',
               stringsAsFactors = FALSE)

df$date <- as.Date(sprintf("%d-01-01", df$year))

# 2. Create LEVEL time-series (must match actual years) ---------------------
start_year <- min(df$year)

ts_soy    <- ts(df$Soy_Prod.ha., start = start_year, end = 2023, frequency = 1)
ts_forest <- ts(df$FCL_Soybean,    start = start_year, end = 2023, frequency = 1)
# NOTE: use the same end year for both series

# 3. First-difference BOTH SERIES (to achieve stationarity) -----------------
d_soy    <- diff(ts_soy)
d_forest <- diff(ts_forest)

# 4. ADF Test on Differenced Series (stationarity check) -------------------
adf_soy_diff    <- ur.df(d_soy,    type = "drift", selectlags = "AIC")
adf_forest_diff <- ur.df(d_forest, type = "drift", selectlags = "AIC")

summary(adf_soy_diff)
summary(adf_forest_diff)

# 5. Phillips-Perron (PP Test) on Differenced Series ------------------------
pp_soy_diff    <- ur.pp(d_soy,    type = "Z-tau", model = "constant")
pp_forest_diff <- ur.pp(d_forest, type = "Z-tau", model = "constant")

summary(pp_soy_diff)
summary(pp_forest_diff)

# 6. KPSS Test on Differenced Series ---------------------------------------
kpss.test(d_soy, null = "Trend")
kpss.test(d_forest, null = "Trend")

# 7. Test for Cointegration on LEVEL data -----------------------------------
# (Even though d_forest is borderline, always test cointegration on levels)
data_mat <- cbind(ts_forest, ts_soy)
colnames(data_mat) <- c("forest", "soy")

jtest <- ca.jo(data_mat, type = "trace", K = 2, ecdet = "trend")
summary(jtest)

# 8. Prepare stationary data for VAR (use differenced series) ---------------
ts_data <- cbind(d_forest, d_soy)
colnames(ts_data) <- c("forest", "soy")

# 9. Select optimal lag length (keep small due to small sample) -------------
lag_sel <- VARselect(ts_data, lag.max = 4, type = "const")
lag_sel$selection

# 10. Fit the VAR model -----------------------------------------------------
p_opt <- lag_sel$selection["AIC(n)"]  # use AIC-selected lag
var_model <- VAR(ts_data, p = p_opt, type = "const")

summary(var_model)
