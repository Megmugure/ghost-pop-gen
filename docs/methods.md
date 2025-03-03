
---

## **Drafting `docs/methods.md`**
This file will contains the methods.  

```md
# Methods

## Data Simulation
We simulated deep divergence genomic data under the **Isolation with Migration (IM) model** using the `msprime` software. We constructed six distinct models, each representing three populations:  

- \(N_{0}\) (Ancestral Population)  
- \(N_{1}\) (An Extant, Sampled Population)  
- \(N_{ghost}\) (An Unsampled "Ghost" Population)  

Each model varied in migration rates, population sizes, and divergence times.

## Statistical Tests for Ghost Population Detection

### 1. **Bimodal vs. Unimodal Coalescent Time Distribution**
To assess whether coalescent times suggest gene flow from a ghost population, we:  
- Extracted TMRCA values from **IMa3** output  
- Used **Kolmogorov-Smirnov (KS) tests** to compare empirical cumulative distribution functions (eCDFs)  
- Applied **Hartigan’s Dip Test** to detect bimodal distributions  

A bimodal distribution suggests potential introgression from an unsampled population.

### 2. **Likelihood Ratio Test (LRT) for Alternative Demographic Models**
We tested whether a model including gene flow from a ghost population fits the data better than a model without ghost gene flow.  
- Used **IMa3** to estimate likelihoods  
- Computed test statistic \( T = -2 (\log L_{H_0} - \log L_{H_A}) \)  
- Evaluated significance using a chi-square distribution  

### 3. **Bootstrap Hypothesis Testing for Admixture Model**
- Used **MULTICLUST** to compute bootstrap p-values under the admixture model  
- If \( p < 0.05 \), the null hypothesis was rejected, suggesting the presence of an additional genetic cluster (potential ghost population)  

For more details, refer to the raw data and statistical results in `results/summary_tables/`.

Execute the Snakemake pipeline with:  snakemake --cores 4
Or to run a specific step:  snakemake results/stats/ks_test_model1.txt --cores 4
