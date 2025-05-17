#!/bin/bash
# Inputs : model/data factor horizon
#Rscript R/simulate.R 'config_domestics'
#Rscript R/simulate.R 'config_sap'
#Rscript R/simulate.R 'config_palo_alto'
#Rscript R_modified/simulate_modified.R 'config_palo_alto'
Rscript R_modified/simulate_modified.R 'config_sap'
#Rscript R_modified/simulate_modified.R 'config_domestics'


# Simulation domestics with added Parking Duration
#Rscript R_modified/simulate_modified.R 'config_domestics_puissance3'
#Rscript R_modified/simulate_modified.R 'config_domestics_puissance6'
#Rscript R_modified/simulate_modified.R 'config_domestics_puissance10'

