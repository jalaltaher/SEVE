### 0. Input data

source('R/utilities.R')
args <- commandArgs(trailingOnly = TRUE)
config <- yaml.load_file(paste0(args[1],'.yaml'))
models <- readRDS(paste0('models/',config$name,'.rds'))
m_factor <- as.integer(config$m_factor)
a_factor <- as.integer(config$a_factor)
horizon <- as.numeric(config$horizon)
tz <- config$tz
refit_starts <- models[[3]][[1]]
refit_ends <- models[[3]][[2]]
df <- read.csv(paste0("data/",config$name,".csv"))

n_sim_gmm <- as.integer(config$n_sim_gmm) # number of gmm simulations 
n_sim_sarima <- as.integer(config$n_sim_sarima) # number of sarima simulations 

reg <- config$reg
freq <- as.numeric(config$freq)

### 1. Sarima

sess <- sessions(df = df,train_starts = refit_starts,train_ends = refit_ends,tz = "US/Pacific")
sess$sessions <- (sess$sessions + a_factor)*m_factor
X <- ts(sess$sessions,frequency=freq)

if(reg){
    new_mod <- auto.arima(X,xreg=sess %>% pull(weekend), allowdrift = FALSE)
}else{
    new_mod <- auto.arima(X, allowdrift = FALSE)
}

sarima_sim <- sarima_simulate(fit = new_mod, sess = sess, horizon = horizon, freq = freq, reg=reg, n_sim = n_sim_sarima)

simulations <- sarima_sim[[1]]
# quantile_forecasts <- sarima_sim[[2]]

### 2. GMM
# gmm_sim <- gmm_simulate(gmm = models[[2]], quantile_forecasts = quantile_forecasts,n_simu = n_sim_gmm)
gmm_sim <- gmm_simulate(gmm = models[[2]], quantile_forecasts = simulations,n_simu = n_sim_gmm)

### 3. Daily Energy
print("===== Daily Energy reconstruction =====")
energy <- flatten(gmm_sim) %>%
  map_dfr(daily_energy)

final <- energy %>%
group_by(Start_Date) %>%
summarise(
  mean = mean(Energy),
  q10 = quantile(Energy, 0.10, type=1),
  q50 = quantile(Energy, 0.50, type=1),
  q90 = quantile(Energy, 0.90, type=1)
)

write.csv(final, paste0('outputs/',config$name,'.csv'))

### 4. Plot
ggsave(paste0('outputs/',config$name,'.pdf'), plot = plot_energy(final), width = 15, height = 12)

### END