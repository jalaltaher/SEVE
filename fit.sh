#!/bin/bash
# Inputs : train_starts train_ends dataset_name timezone
#Rscript R/fit.R 'config_domestics'
#Rscript R/fit.R 'config_sap'
#Rscript R/fit.R 'config_palo_alto'

# Fit with added Park.Duration
#Rscript R_modified/fit_modified.R 'config_palo_alto'
Rscript R_modified/fit_modified.R 'config_sap'

# Fit domestics with added Park.Duration
#Rscript R_modified/fit_modified.R 'config_domestics_puissance3'
#Rscript R_modified/fit_modified.R 'config_domestics_puissance6'
#Rscript R_modified/fit_modified.R 'config_domestics_puissance10'

