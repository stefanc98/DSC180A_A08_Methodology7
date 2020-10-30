#function for mootha data
mootha_function <- function(mootha) {
  
  # Two sample t-test
  g1 = 1:17
  g2 = 18:34
  #t.stat = apply(X=mootha, MARGIN=1, FUN=function(X){t.test(X[g1],X[g2],alternative="t",var.equal=TRUE)$statistic}) 
  t.stat = apply(X=mootha, MARGIN=1, FUN=function(X){t.test(X[g1],X[g2])$statistic}) 
  #p.value = 2*(1 - pt(abs(t.stat), df=32))
  p.value = 2*(1 - pnorm(abs(t.stat)))
  
  # Histogram of p-values
  p = seq(0,1,by=0.01)
  hist(p.value, freq=F)
  lines(p, dunif(p), lwd=2, col='red')
  
  # Histogram of t-statistics
  x = seq(-5,5,by=0.1)
  hist(t.stat, breaks=x, freq=F)
  lines(x, dnorm(x), lwd=2, col='red')
  
  # Expected number of p-values less than a threshold
  m=nrow(mootha)
  
  p.expected = p*m
  p.obtained = rep(0, length(p))
  for(i in 1:length(p)) {
    p.obtained[i] = sum(p.value < p[i])
  }
  plot(p, p.obtained, col='black', type='l', lwd=2, ylab='# p-values')
  lines(p, p.expected, type='l', col='red', lwd=2)
  
  # Expected number of t-values greater than a threshold
  t.expected = m*2*(1-pnorm(abs(x)))
  t.obtained = rep(0, length(x))
  for(i in 1:length(x)) {
    t.obtained[i] = sum(abs(t.stat) > abs(x[i]))
  }
  plot(x, t.obtained, col='black', type='l', lwd=2, ylab='# t-stat')
  lines(x, t.expected, type='l', col='red', lwd=2)
  
  # Plot of false discovery rate
  plot(p, p.expected/p.obtained, col='black', type='l', lwd=2, ylab='FDR')
  plot(x, t.expected/t.obtained, col='black', type='l', lwd=2, ylab='FDR')
  
  
  result = list(t.stat, p.value)
  
  return (result)
}

# function for Jongho data
Jongho_function <- function(Z) {
  Z.hist <- hist(Z, 100, probability = T)
  z <- Z.hist$mids
  lines(z, dnorm(z), col='red', lwd = 2)
  
  #fit empirical null
  index <- which(z>-2 & z<2)
  x <- z[index]
  y <- log(Z.hist$density[index])
  plot(x,y)
  m1 <- lm(y ~ x + I(x^2))
  lines(x, predict(m1), col='blue', lwd=2)
  result <- coef(m1)
  
  return (result)
}

#functions that might be used in the future (pipeline)

FDR_function <- function(){
  
}

simulate_function <-function(){
  
}

fit_function <- function(){
  
}

#
