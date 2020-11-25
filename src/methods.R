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
  #hist(p.value, freq=F)
  #lines(p, dunif(p), lwd=2, col='red')
  
  # Histogram of t-statistics
  x = seq(-5,5,by=0.1)
  # hist(t.stat, breaks=x, freq=F)
  # lines(x, dnorm(x), lwd=2, col='red')
  
  # Expected number of p-values less than a threshold
  m=nrow(mootha)
  
  p.expected = p*m
  p.obtained = rep(0, length(p))
  for(i in 1:length(p)) {
    p.obtained[i] = sum(p.value < p[i])
  }
  #plot(p, p.obtained, col='black', type='l', lwd=2, ylab='# p-values')
  #lines(p, p.expected, type='l', col='red', lwd=2)
  
  # Expected number of t-values greater than a threshold
  t.expected = m*2*(1-pnorm(abs(x)))
  t.obtained = rep(0, length(x))
  for(i in 1:length(x)) {
    t.obtained[i] = sum(abs(t.stat) > abs(x[i]))
  }
  #plot(x, t.obtained, col='black', type='l', lwd=2, ylab='# t-stat')
  #lines(x, t.expected, type='l', col='red', lwd=2)
  
  # Plot of false discovery rate
  path = './test/test_output/P_FDR.png'
  png(filename=path)
  plot(p, p.expected/p.obtained, col='black', type='l', lwd=2, ylab='FDR')
  dev.off()
  
  path = './test/test_output/T_FDR.png'
  png(filename=path) 
  plot(x, t.expected/t.obtained, col='black', type='l', lwd=2, ylab='FDR')
  dev.off()
}

# function for Jongho data
Jongho_function <- function(Z) {
  
  path = './test/test_output/Jongho_distribution.png'
  png(filename=path) 
  Z.hist <- hist(Z, 100, probability = T)
  z <- Z.hist$mids
  lines(z, dnorm(z), col='red', lwd = 2)
  dev.off()
  
  #fit empirical null
  index <- which(z>-2 & z<2)
  x <- z[index]
  y <- log(Z.hist$density[index])
  m1 <- lm(y ~ x + I(x^2))

  path = './test/test_output/Jongho_Empirical.png'
  png(filename=path) 
  plot(x,y)
  lines(x, predict(m1), col='blue', lwd=2)
  dev.off()
}

#functions that might be used in the future (pipeline)

FDR_function <- function(t,null,alt){
  observation = c(null,alt)
  H0 = c()
  HA = c()
  for (i in 1:n){
    if (observation[i] <= t){
      H0 = append(H0,observation[i])
    }
    else{
      HA = append(HA,observation[i])
    }
  }
  TP = 0
  for (i in 1:length(HA)){
    if (HA[i] %in% alt){
      TP = TP + 1
    }
  }
  FP = length(HA) - TP
  FDR = FP/length(HA)
  
  return(FDR)
}

Plot_FDR <- function(t){
  
}

#functions that might be used in the future (pipeline)

simulate_function <-function(){
  
}

fit_function <- function(){
  
}

#
