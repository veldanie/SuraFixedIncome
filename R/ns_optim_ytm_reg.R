ns_optim_ytm_reg <- function(betas_ini, date_ini, ytm, coupon, matur, freq, conv, y_lim=c(0,5), delta_beta=0.01, min_beta=c( 0 , -15 , -10 ,5), max_beta=c(15 , 0, 10 ,10)){

  diff<-function(betas,date_ini, ytm, coupon, matur, freq, conv, y_lim){
    res=as.numeric(diff_ytm_ns(betas, date_ini, ytm, coupon, matur, freq, conv, y_lim)+delta_beta*crossprod(betas-betas_ini))
    return(res)
  }

  #betas_optim=optim(par=betas_ini, fn=diff, date_ini=date_ini, ytm=ytm, coupon=coupon, matur=matur, freq=freq, conv=conv, y_lim=y_lim, control=list(abs.tol=0), lower=min_beta, upper=max_beta)$par
  betas_optim=nlminb(start=betas_ini, objective=diff, date_ini=date_ini, ytm=ytm, coupon=coupon, matur=matur, freq=freq, conv=conv, y_lim=y_lim, lower=min_beta, upper=max_beta)
  return(betas_optim)
}
