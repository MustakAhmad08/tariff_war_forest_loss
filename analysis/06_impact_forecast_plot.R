library(ggplot2)
load("analysis/impact.RData")
load("analysis/arimax_2025.RData")

ci <- impact$series
ci_df <- data.frame(
  date = index(ci),
  observed  = ci[,"response"],
  predicted = ci[,"point.pred"]
)
ci_df$year <- as.numeric(format(ci_df$date, "%Y"))

df_obs <- ci_df[, c("year","observed")]
df_cf  <- ci_df[!is.na(ci_df$predicted), c("year","predicted")]

last_year <- max(df_obs$year)
last_val  <- df_obs$observed[df_obs$year == last_year]

df_connection <- data.frame(
  year  = c(last_year, forecast_2025$year),
  value = c(last_val, forecast_2025$mean)
)

p <- ggplot() +
  geom_line(data = df_obs, aes(year, observed/1e6), color = "#46a0de") +
  geom_line(data = df_cf,  aes(year, predicted/1e6), color = "#238b41") +
  geom_line(data = df_connection, aes(year, value/1e6), color = "#e41a1c") +
  geom_point(aes(forecast_2025$year, forecast_2025$mean/1e6),
             color = "#e41a1c", size = 2) +
  theme_classic() +
  labs(x="Year", y="Forest Loss (Mha)")

ggsave("results/impact_forecast_2025.png", p, width = 7, height = 4, dpi = 300)