configfile: "config.yaml"

SAMPLES = ["sample1", "sample2", "sample3"]  # Users can modify in config.yaml

# Rule to estimate demographic parameters using IMa3
rule run_IMa3:
    input:
        "data/input/{sample}.u"
    output:
        "data/IMa3_output/{sample}.IMa3.out"
    shell:
        "mpirun -np 1 IMa3 -i {input} -o {output}"

# Rule to extract TMRCA values using ARGWeaver
rule extract_TMRCA:
    input:
        "data/IMa3_output/{sample}.IMa3.out"
    output:
        "data/ARGWeaver_output/{sample}.tmrca"
    shell:
        "python scripts/extract_tmrca.py --input {input} --output {output}"

# Rule to perform KS test, jackknifing, and Hartigan's Dip Test
rule statistical_tests:
    input:
        "data/ARGWeaver_output/{sample}.tmrca"
    output:
        "results/{sample}_ks_results.txt",
        "results/{sample}_dip_test.txt"
    shell:
        "Rscript scripts/KS_tests.R {input} results/{sample}_ks_results.txt results/{sample}_dip_test.txt"

# Rule to perform LRT and compute p-values
rule likelihood_ratio_test:
    input:
        "data/input/{sample}.u"
    output:
        "data/LRT_results/{sample}_LRT.out"
    shell:
        "mpirun -np 1 IMa3 -i {input} -o {output}"

rule extract_LRT_pvalues:
    input:
        "data/LRT_results/{sample}_LRT.out"
    output:
        "results/{sample}_lrt_pvalues.txt"
    shell:
        "python scripts/LRT_test.py --input {input} --output {output}"

# Rule to convert .u files to STRUCTURE format
rule convert_to_structure:
    input:
        "data/input/{sample}.u"
    output:
        "data/STRUCTURE_input/{sample}.str"
    shell:
        "python scripts/convert_to_structure.py --input {input} --output {output}"

# Rule to analyze population structure using STRUCTURE
rule structure_analysis:
    input:
        "data/STRUCTURE_input/{sample}.str"
    output:
        "data/STRUCTURE_out/{sample}_structure_results.txt"
    shell:
        "python scripts/STRUCTURE_analysis.py --input {input} --output {output}"

# Rule to run bootstrap test for ghost admixture
rule bootstrap_test:
    input:
        "data/STRUCTURE_input/{sample}.str"
    output:
        "data/Bootstrap_out/{sample}_bootstrap.log"
    shell:
        "bash scripts/bootstrap_test.sh {input} {output}"

# Rule to extract AIC and BIC values
rule extract_AIC_BIC:
    input:
        "data/STRUCTURE_out/{sample}_structure_results.txt"
    output:
        "results/{sample}_AIC_BIC.txt"
    shell:
        "python scripts/extract_AIC_BIC.py --input {input} --output {output}"

# Rule to generate final tables and figures
rule generate_figures:
    input:
        expand("results/{sample}_ks_results.txt", sample=SAMPLES),
        expand("results/{sample}_dip_test.txt", sample=SAMPLES),
        expand("results/{sample}_lrt_pvalues.txt", sample=SAMPLES),
        expand("results/{sample}_AIC_BIC.txt", sample=SAMPLES)
    output:
        "results/final_report.pdf"
    shell:
        "python scripts/generate_figures.py --input {input} --output {output}"

