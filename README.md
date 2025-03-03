# Detecting "ghost" populations in genomic data

## Overview
This project designs a series of statistical tests to detect unsampled "ghost" populations in genomic datasets. 
It investigates the presence of unsampled "ghost" populations in population genomic data using simulation-based statistical tests. 
The study is based on the **Isolation with Migration (IM) model** and **Admixture models**.

## Methods
- **Simulations:** Generate synthetic genomic data with structured and known population histories.
- **Statistical Tests:** Design and implement statistical tests.
- **Pipeline:** Automate analyses using Snakemake/Python.
- **Visualization:** Generate figures for easy interpretation.

## Repository Structure
- `src/` – Code for simulations and statistical tests.
- `notebooks/` – Jupyter Notebooks for analysis.
- `results/` – Figures and summary statistics.
- `docs/` – Detailed methodology and explanations.

## Installation
```bash
pip install -r requirements.txt
python src/analysis_pipeline.py
