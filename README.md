# ORFEVRE
<img src="logo.webp" alt="Package Logo" width="200">

SEVE (Simulated Electric Vehicle Energy) is a version of [ORFEVRE](https://github.com/yvenn-amara/ORFEVRE) designed to generate daily energy demand of electric vehicles based on mixture models and time series models fitted on real data available on the [ev-open-data](https://github.com/yvenn-amara/ev-load-open-data) repository. Developed and maintained by Yvenn Amara-Ouali.

## Usage

With the data provided:
- Select an existing configuration and modify it accordingly:
    -  [config_domestics.yaml](./config.yaml) for residential recharging
    -  [config_sap.yaml](./config.yaml) for workplace/residential recharging
    -  [config_palo_alto.yaml](./config.yaml) for workplace/public recharging
- Fit models using the fit.sh bash script (the models are saved in [models](./models))
- Simulate daily EV energy following the last training point. Can be extended to different EV adoption scenarios using the arguments m_factor and a_factor in the configuration file.

## Scenario Generation

```yaml
# Scenario Generation parameters
m_factor:        10    # multiplicative factor to produce scenarios
a_factor:       100    # additive factor to produce scenarios
horizon:        365    # number of days to simulate
n_sim_sarima:    10    # number of SARIMA simulations
n_sim_gmm:       10    # number of GMM simulations

```simulate.sh
#!/bin/bash
Rscript R/simulate.R 'config_sap'

You can then run the following bash command directly in your terminal:

```bash
bash simulate.sh 

## Contributing

Contributions are welcome! Please fork the repository and submit pull requests. For major changes, please open an issue first to discuss potential modifications.

## Author

- [Yvenn Amara-Ouali](https://www.yvenn-amara.com/)

## License

This project is licensed under the MIT License. See the `LICENSE` file for details.

## Acknowledgments

Special thanks to all contributors and users who provide feedback to improve this package.
