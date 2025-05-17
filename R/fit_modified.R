### 0. Input data

source('R_modified/utilities_modified.R')
args <- commandArgs(trailingOnly = TRUE)
config <- yaml.load_file(paste0(args[1],'.yaml'))
train_starts <- config$train_start
train_ends <- config$train_end
dataset_name <- config$name
tz <- config$tz
df <- read.csv(paste0("data/",dataset_name,".csv"))
reg <- config$reg
freq <- as.numeric(config$freq)

### 1. Sarima
print(dataset_name)
print("_______________________________________________")
print('==== Fitting SARIMA modified =====')
sess <- sessions(df = df,train_starts = train_starts,train_ends = train_ends,tz = tz)
X <- ts(sess$sessions,frequency=freq)
if(reg){
    sarima <- auto.arima(X,xreg=sess %>% pull(weekend), allowdrift = FALSE)
}else{
    sarima <- auto.arima(X, allowdrift = FALSE)
}


### 2. GMM

print('==== Fitting Mixture Model modified =====')
trans <- transactions(df = df,train_starts = train_starts,train_ends = train_ends,tz = tz)
print(head(trans,n=3))
print(head(df,n=3))
gmm <- gmm_fit(trans,max_sample=100)

### 3. Saving models

print('==== Saving Models modified =====')
models <- list()
models[[1]] <- sarima
models[[2]] <- gmm
models[[3]] <- list(train_starts,train_ends)
models[[4]] <- tz
 
saveRDS(models, paste0('models/',dataset_name,'.rds'))

### END