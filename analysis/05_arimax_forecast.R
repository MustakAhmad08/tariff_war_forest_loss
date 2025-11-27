library(forecast)
library(dplyr)
load("analysis/data_imputed.RData")

df_fc <- data.frame(date = index(zdata), as.data.frame(zdata))
df_fc$year <- as.integer(format(df_fc$date, "%Y"))

response_col <- col_names[1]
y <- as.numeric(df_fc[[response_col]])

X <- df_fc %>%
  select(all_of(col_names)) %>%
  select(-all_of(response_col))

X <- X[, sapply(X, sd, na.rm = TRUE) > 0]
X <- na.omit(X)
y <- tail(y, nrow(X))

fit_arimax <- auto.arima(y, xreg = as.matrix(X),
                         stepwise = FALSE, approximation = FALSE, allowdrift = TRUE)

X_future <- sapply(X, function(x) {
  forecast(auto.arima(x, allowdrift = TRUE), h = 1)$mean
})
X_future <- matrix(X_future, nrow = 1)

fc <- forecast(fit_arimax, xreg = X_future, h = 1)

forecast_2025 <- data.frame(
  year  = max(df_fc$year) + 1,
  mean  = fc$mean,
  lower = fc$lower[,2],
  upper = fc$upper[,2]
)

save(forecast_2025, file = "analysis/arimax_2025.RData")