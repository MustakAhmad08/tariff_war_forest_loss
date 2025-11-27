library(lmtest)
library(ggplot2)
library(dplyr)

load("analysis/data_imputed.RData")

df_sub <- df %>% select(FCL_Soybean, Soy_Prod.ha.) %>% na.omit()
max_lag <- 6

pvals <- sapply(1:max_lag, function(l) {
  out <- try(grangertest(FCL_Soybean ~ Soy_Prod.ha., order = l, data = df_sub), silent = TRUE)
  if (inherits(out, "try-error")) return(NA)
  out$`Pr(>F)`[2]
})

gc_df <- data.frame(Lag = 1:max_lag, p_value = pvals) %>% filter(!is.na(p_value))

p_pvalue <- ggplot(gc_df, aes(Lag, p_value)) +
  geom_line(linewidth = 0.9, color = "#0072B2") +
  geom_point(size = 1.2, color = "#0072B2") +
  geom_hline(yintercept = 0.05, linetype = "dashed", color = "red", linewidth = 0.4) +
  theme_classic(base_size = 9)

ggsave("results/granger_pvalues.png", p_pvalue, width = 6, height = 4, dpi = 300)
save(p_pvalue, file = "analysis/gc_plot.RData")