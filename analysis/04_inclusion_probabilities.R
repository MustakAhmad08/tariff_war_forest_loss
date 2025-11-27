library(ggplot2)
load("analysis/impact.RData")

coef_sum <- summary(impact$model$bsts.model)$coefficients
df_coef <- data.frame(
  Variable = rownames(coef_sum),
  InclusionProb = coef_sum[, "inc.prob"]
)

df_coef <- df_coef[df_coef$Variable != "(Intercept)", ]
df_coef$Variable <- factor(df_coef$Variable, levels = df_coef$Variable)

p_coef <- ggplot(df_coef, aes(InclusionProb, Variable)) +
  geom_col(fill = "grey50") +
  scale_x_continuous(limits = c(0,1)) +
  theme_classic()

ggsave("results/inclusion_probabilities.png", p_coef, width = 6, height = 5, dpi = 300)
save(p_coef, file = "analysis/inclusion_plot.RData")