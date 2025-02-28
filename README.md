NMF for Geochemical Modeling Analysis
This repository contains an R script for performing Non-negative Matrix Factorization (NMF) on a geochemical modeling output dataset. 
The script reads a CSV file, filters out non-informative columns, applies NMF using the NMF package, and generates 
visualizations—including line plots to illustrate signal progression and heatmaps to highlight attribute significance.
Prerequisites
•	R (version 3.0 or later recommended)
•	Required R Packages: 
      install.packages(c("dplyr", "magrittr", "deSolve", "NMF"))
Usage
     1.	Clone the Repository: 
     2.	https://github.com/DLD0061/NMF.git
     3.	Set Up Your Data: 
        • Place your CSV file in the repository directory.
     4.	Run the Script: 
        •	Open the NMR.R file in RStudio or your preferred R environment.
        •	Execute the script to perform the NMF analysis, generate the plots, and output the resulting CSV file.
