#!/bin/bash
# Inputs : train_starts train_ends dataset_name timezone
Rscript R/fit.R 'config_domestics'
Rscript R/fit.R 'config_sap'
Rscript R/fit.R 'config_palo_alto'