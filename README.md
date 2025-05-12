# SEVE
<img src="logo.webp" alt="Package Logo" width="200">

**SEVE** (Simulated Electric Vehicle Energy) is a specialized version of [ORFEVRE](https://github.com/yvenn-amara/ORFEVRE) for generating daily electric vehicle energy demand profiles. It combines mixture models and time series analysis trained on real-world data from the [ev-open-data](https://github.com/yvenn-amara/ev-load-open-data) repository. Developed and maintained by Yvenn Amara-Ouali.

## Installing Environment

```bash
mamba env create -f environment.yml
```

## Usage

1. **Configure Settings**  
   Choose and modify one of the configuration files:
   - `config_domestics.yaml`: Residential charging
   - `config_sap.yaml`: Workplace/residential charging
   - `config_palo_alto.yaml`: Workplace/public charging
2. **Train Models**  
   Run the fitting script:
   ```bash
   bash fit.sh
  The models are saved in [models](./models)
3. **Simulate Data**
   Simulate daily EV energy following the last training point. Can be extended to different EV adoption scenarios using the arguments m_factor and a_factor in the configuration file.

## Scenario Generation

Let's take a look at an example:

`config_sap.yaml`
```config_sap.yaml
# Scenario Generation parameters
m_factor:        10    # multiplicative factor to produce scenarios
a_factor:       100    # additive factor to produce scenarios
horizon:        365    # number of days to simulate
n_sim_sarima:    10    # number of SARIMA simulations
n_sim_gmm:       10    # number of GMM simulations
```

`simulate.sh`
```simulate.sh
#!/bin/bash
Rscript R/simulate.R 'config_sap'
```

You can then run the following bash command directly in your terminal:

```bash
bash simulate.sh 
```

## Contributing

Contributions are welcome! Please fork the repository and submit pull requests. For major changes, please open an issue first to discuss potential modifications.

## Author

- [Yvenn Amara-Ouali](https://www.yvenn-amara.com/)

## License

This project is licensed under the MIT License. See the `LICENSE` file for details.

## Acknowledgments

Special thanks to all contributors and users who provide feedback to improve this package.
