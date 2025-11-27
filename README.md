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

## A. Deforestation Data
- **MapBiomas Collection 10** — annual land cover (2000–2023)  
  https://brasil.mapbiomas.org/en/
- **INPE PRODES** — annual forest loss (2001–2023)  
  https://terrabrasilis.dpi.inpe.br/

## B. Soybean Production and Cropland Expansion
- **IBGE** — agricultural production statistics  
  https://www.ibge.gov.br/en/ibge-search.html?searchphrase=all&searchword=Soybeans
- **MapBiomas Agriculture Layers** — cropland mapping  
  https://brasil.mapbiomas.org/en/
- **FAOSTAT** — global agricultural databases  
  https://www.fao.org/faostat/en/#data

## C. Climate Data
- **•	Climate Change Knowledge Portal (CCKP)** — temperature, precipitation, and climate indicators
https://climateknowledgeportal.worldbank.org/

## D. Soybean Exports from Brazil to China (2002–2025)
- **MDIC — Ministério do Desenvolvimento, Indústria e Comércio Exterior**  
  https://www.gov.br/mdic/pt-br/assuntos/comercio-exterior/estatisticas/base-de-dados-bruta#Municipio
- **ComexStat** — Brazilian export statistics  
  https://comexstat.mdic.gov.br/pt/municipio

## E. Soybean Exports from the United States to China
- **USDA FAS – Global Agricultural Trade System (GATS)**  
  https://apps.fas.usda.gov/gats/default.aspx

## F. Historical Soybean Price Data
- **Macrotrends** — historical soybean price series  
  https://www.macrotrends.net/2531/soybean-prices-historical-chart-data
- **Farmdoc Daily** — soybean market analysis  
  https://farmdocdaily.illinois.edu/2025/09/us-soybean-harvest-starts-with-no-sign-of-chinese-buying-as-brazil-sets-export-record.html  
  https://farmdocdaily.illinois.edu/2024/07/corn-and-soybeans-economics-in-2024-and-2025-back-to-the-new-old-normal.html

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

