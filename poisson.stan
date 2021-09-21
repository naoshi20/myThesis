data{
  int N_x; // sample size
  
  // variables
  int<lower=0, upper=8> Y[N_x]; // amusement
  vector[N_x] AU10; // AU10 ( 0 or 1 ) 
  
  // for prediction
  int N_x_pred;
  vector[N_x_pred] x_pred;
}

parameters{
  real beta0; // intercept
  real beta1; // slope
}


transformed parameters{
  vector[N_x] theta; //real theta[N_x];
  
  for(i in 1:N_x){
    theta[i] = exp(beta0 + beta1 * AU10[i]);
  }
}

model{
  for(i in 1:N_x){
    Y[i] ~ poisson(theta[i]);
  }
}

generated quantities{
  real theta_pred[N_x_pred]; // for regression line int<lower=0, upper=8>
  
  for(k in 1:N_x_pred){
    theta_pred[k] = beta0 + beta1 * x_pred[k];
  }
}
