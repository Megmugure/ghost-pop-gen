Here's a **clean and well-structured** `README.md` file without emojis, keeping it professional and easy to read.  

---

# **Ghost Population Detection Pipeline**  

## Overview  

This project implements statistical tests to detect unsampled "ghost" populations in genomic datasets. It investigates hidden ancestral populations using:  

- **Isolation with Migration (IM) Model**  
- **Admixture Models**  

The pipeline automates genomic dataset analysis to explore the effects of gene flow from a ghost population on:  

- Coalescent times  
- Demographic inference  
- Population structure  

### Key Features  

- Coalescent time distribution analysis (Kolmogorov-Smirnov test, jackknifing, Hartigan’s Dip test)  
- Likelihood Ratio Test (LRT) to compare alternative demographic histories  
- Model selection for ghost admixture using STRUCTURE  
- Bootstrap test for ghost admixture using MULTICLUST  
- Automated workflow with Snakemake for easy reproducibility  

---

## Repository Structure  

```
ghost-pop-gen/
│── config.yaml              # Pipeline configuration file
│── Snakefile                # Snakemake workflow
│── environment.yml          # Conda environment setup
│── requirements.txt         # Python dependencies
│── data/                    # Input data & intermediate files
│── results/                 # Output results
│── scripts/                 # Custom scripts for analysis
│   ├── KS_tests.R
│   ├── LRT_test.py
│   ├── STRUCTURE_analysis.py
│   ├── bootstrap_test.sh
│   ├── convert_to_structure.py
│   ├── extract_AIC_BIC.py
│   ├── extract_tmrca.py
│   ├── generate_figures.py
│── logs/                    # Snakemake run logs
│── docs/                    # Documentation files
│── LICENSE                  # License information
│── README.md                # This file
```

---

## Installation and Setup  

### Clone the Repository  

```bash
git clone git@github.com:Megmugure/ghost-pop-gen.git
cd ghost-pop-gen
```

### Set Up a Conda Environment  

```bash
conda env create -f environment.yml
conda activate ghost-pop-gen
```

### Install Additional Dependencies (if needed)  

```bash
pip install -r requirements.txt
```

---

## Running the Pipeline  

### Run the Full Pipeline  

```bash
snakemake --cores all
```

### Perform a Dry Run (Check Dependencies)  

```bash
snakemake -n
```

### Generate a DAG (Workflow Graph)  

```bash
snakemake --dag | dot -Tpng > dag.png
```

---

## Pipeline Steps and Statistical Tests  

### 1. IMa3 Analysis  

- Estimates demographic parameters from `.u` files  
- Uses ARGWeaver to extract TMRCA values  

### 2. Coalescent Time Analysis  

- Kolmogorov-Smirnov test (KS test) for distribution comparisons  
- Jackknifing to test statistical robustness  
- Hartigan’s Dip Test to assess multimodality  

### 3. Likelihood Ratio Test (LRT)  

- Compares alternative demographic models  
- Uses IMa3 to estimate likelihood values  
- Extracts LRT values and computes p-values  

### 4. STRUCTURE Analysis  

- Converts `.u` files to `.str` format  
- Uses STRUCTURE for admixture proportion estimation  

### 5. Bootstrap Test for Ghost Admixture  

- Uses MULTICLUST under the admixture model  
- Custom Bash script automates bootstrapping  
- Extracts AIC and BIC values for model selection  

### 6. Result Visualization  

- Generates tables and figures from the analysis  

---

## Example Commands  

Run the Kolmogorov-Smirnov (KS) Test:  

```bash
Rscript scripts/KS_tests.R data/input.tmrca
```

Run the Likelihood Ratio Test (LRT):  

```bash
python scripts/LRT_test.py results/lrt_values.txt
```

Run the Bootstrap Test for Ghost Admixture:  

```bash
bash scripts/bootstrap_test.sh data/structure_data.str
```

---

## License  

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.  

---

## Contributing  

Contributions are welcome.  

1. Fork the repository  
2. Create a feature branch (`git checkout -b feature-branch`)  
3. Commit changes (`git commit -m "Added new feature"`)  
4. Push to your fork (`git push origin feature-branch`)  
5. Submit a Pull Request (PR)  

---

## Contact  

**Author:** Margaret Mugure  
**Email:** margaretwmugure@gmail.com  
**GitHub:** [Megmugure](https://github.com/Megmugure)  

---

