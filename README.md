# Amazon Tariff Deforestation Analysis (2002–2025)

This repository contains data and code supporting the analysis of trade-mediated deforestation following the 2018 U.S.–China tariff war. The workflow includes:

- Granger causality testing
- Bayesian Structural Time Series (BSTS / CausalImpact)
- ARIMAX forecasting of post-2018 forest loss
- Imputation and preprocessing workflows
- Reproduction of manuscript figures and tables

All scripts are modular and located in the `analysis/` directory.

## Data Availability

All source datasets are openly available:

- **MapBiomas Collection 10** — annual land cover (2000–2023)  
  https://mapbiomas.org/
- **INPE PRODES** — forest loss (2001–2023)  
  https://terrabrasilis.dpi.inpe.br/
- **World Governance Indicators**  
  https://databank.worldbank.org/source/worldwide-governance-indicators
- **Climate (ERA5)** — reanalysis precipitation & temperature  
  https://cds.climate.copernicus.eu/

Processed data used in the analysis are included in `data/processed/`.

---

## Software Environment

- **R 4.3.2**
  - `CausalImpact`
  - `bsts`
  - `forecast`
  - `lmtest`
  - `missForest`
- **Python 3.11**
  - `statsmodels`

---

## How to Reproduce the Analysis

Run scripts in order:

1. `analysis/01_load_data_impute.R`
2. `analysis/02_granger_test.R`
3. `analysis/03_causal_impact.R`
4. `analysis/04_inclusion_probabilities.R`
5. `analysis/05_arimax_forecast.R`
6. `analysis/06_impact_forecast_plot.R`
7. `analysis/07_export_ratio_plots.R`

Figures are saved in `results/figures/`.
