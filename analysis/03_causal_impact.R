library(CausalImpact)
library(zoo)
load("analysis/data_imputed.RData")

pre.period  <- as.Date(c("2002-01-01","2018-01-01"))
post.period <- as.Date(c("2019-01-01","2024-01-01"))

impact <- CausalImpact(
  zdata,
  pre.period = pre.period,
  post.period = post.period,
  model.args = list(
    niter = 2500,
    standardize.data = TRUE,
    prior.level.sd = 0.15,
    dynamic.regression = FALSE
  )
)

save(impact, file = "analysis/impact.RData")