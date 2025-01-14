# Note, please direct all questions regarding the R-code to Lucas Arnroth
# Lukas.Arnroth@statistik.uu.se room B341

# read data
dat <- read.csv("B3_HWA2.csv")


# we want 400, and leave 4 out for forecasting
datm <- dat[1:400, ] # subset 400 first rows of dat, include all columns
datf <- dat[401:404, ] # subset last 4 rows of dat, include all columns

# process 1-5
y_1 <- as.ts(datm[ , 3])
y_2 <- as.ts(datm[ , 4])
y_3 <- as.ts(datm[ , 5])
y_4 <- as.ts(datm[ , 6])
y_5 <- as.ts(datm[ , 7])


##################################################
#IDENTIFICATION
## Y1


#GUESS: ARMA(1,1), AR(2)
layout(matrix(c(1, 1, 2,
                1, 1, 3), nrow=2, byrow=TRUE)) 
ts.plot(y_1, main = "Time Series Y1") # time series plot
acf(y_1, lag.max = 20, type = "correlation", plot = T, main = "ACF") # ACF
acf(y_1, lag.max = 20, type = "partial", plot = T, main = "PACF") # PCAF
par(mfrow = c(1,1)) # set plot window to default


## Y2
#GUESS AR(1)
layout(matrix(c(1, 1, 2,
                1, 1, 3), nrow=2, byrow=TRUE)) 
ts.plot(y_2, main = "Time Series Y2") # time series plot
acf(y_2, lag.max = 20, type = "correlation", plot = T, main = "ACF") # ACF
acf(y_2, lag.max = 20, type = "partial", plot = T, main = "PACF") # PCAF
par(mfrow = c(1,1)) # set plot window to default

## Y3
#GUESS MA(2)
layout(matrix(c(1, 1, 2,
                1, 1, 3), nrow=2, byrow=TRUE)) 
ts.plot(y_3, main = "Time Series Y3") # time series plot
acf(y_3, lag.max = 20, type = "correlation", plot = T, main = "ACF") # ACF
acf(y_3, lag.max = 20, type = "partial", plot = T, main = "PACF") # PCAF
par(mfrow = c(1,1)) # set plot window to default

## Y4
#GUESS AR(2)
layout(matrix(c(1, 1, 2,
                1, 1, 3), nrow=2, byrow=TRUE)) 
ts.plot(y_4, main = "Time Series Y4") # time series plot
acf(y_4, lag.max = 20, type = "correlation", plot = T, main = "ACF") # ACF
acf(y_4, lag.max = 20, type = "partial", plot = T, main = "PACF") # PCAF
par(mfrow = c(1,1)) # set plot window to default

## Y5
#GUESS AR(1,1)?
layout(matrix(c(1, 1, 2,
                1, 1, 3), nrow=2, byrow=TRUE)) 
ts.plot(y_5, main = "Time Series Y5") # time series plot
acf(y_5, lag.max = 20, type = "correlation", plot = T, main = "ACF") # ACF
acf(y_5, lag.max = 20, type = "partial", plot = T, main = "PACF") # PCAF
par(mfrow = c(1,1)) # set plot window to default



######################################
## Estimation
E <- as.ts(datm$E)

### Y1
#Guess: ARMA(11)
m1 <- arima(y_1, order = c(1, 0, 1))
summary(m1)
sigma21 <- m1$sigma2
E1 <- residuals(m1)


### Y1
#Guess: AR(2)
m11 <- arima(y_1, order = c(2, 0, 0))
summary(m11)
sigma211 <- m11$sigma2
E11 <- residuals(m11)

### Y2
#GUESS: AR(1)
m2 <- arima(y_2, order = c(1, 0 , 0))
summary(m2)
sigma22 <- m2$sigma2
E2 <- residuals(m2)

### Y3
#GUESS: MA(2)
m3 <- arima(y_3, order = c(0, 0 , 2))
summary(m3)
sigma23 <- m3$sigma2
E3 <- residuals(m3)

### Y4
#GUESS: (AR(2))
m4 <- arima(y_4, order = c(2, 0 , 0))
summary(m4)
sigma24 <- m4$sigma2
E4 <- residuals(m4)

### Y5
#GUESS: ARMA(11)
m5 <- arima(y_5, order = c(1, 0 , 1))
summary(m5)
sigma25 <- m5$sigma2
E5 <- residuals(m5)


############################################################
#Diagnosis
## Y1
#GUESS ARMA(11)
layout(matrix(c(1, 1, 2,
                1, 1, 3), nrow=2, byrow=TRUE)) 
ts.plot(E1, ylab = "Residuals", col = "blue", main = "Residuals from Fitted Model Y1")
abline(a = mean(E1), b = 0) # adds horizontal line with mean(E1) as intercept and 0 slope
abline(a = mean(E1) + sigma21, b = 0, lty="dotted") # same as above + sigma2
abline(a = mean(E1) - sigma21, b = 0, lty="dotted") # same as above - sigma2
acf(E1, lag.max = 20, type = "correlation", plot = T, main = "ACF") # ACF
acf(E1, lag.max = 20, type = "partial", plot = T, main = "PACF") # PCAF
par(mfrow = c(1,1)) # set plot window to default
#COrrelated?
Box.test(E1, lag = 20, type = c("Ljung-Box"), fitdf = 2)
e1_acf <- acf(E1, lag.max = 20, type = "correlation", plot = F) 
#Normality?
qqnorm(E1)

## Y1
#GUESS AR(2)
layout(matrix(c(1, 1, 2,
                1, 1, 3), nrow=2, byrow=TRUE)) 
ts.plot(E11, ylab = "Residuals", col = "blue", main = "Residuals from Fitted Model Y1")
abline(a = mean(E11), b = 0) # adds horizontal line with mean(E1) as intercept and 0 slope
abline(a = mean(E11) + sigma211, b = 0, lty="dotted") # same as above + sigma2
abline(a = mean(E11) - sigma211, b = 0, lty="dotted") # same as above - sigma2
acf(E11, lag.max = 20, type = "correlation", plot = T, main = "ACF") # ACF
acf(E11, lag.max = 20, type = "partial", plot = T, main = "PACF") # PCAF
par(mfrow = c(1,1)) # set plot window to default
#Correlated?
e11_acf <- acf(E11, lag.max = 20, type = "correlation", plot = F)
Box.test(E11, lag = 20, type = c("Ljung-Box"), fitdf = 2)
#Normal?
qqnorm(E11)

## Y2
#GUESS AR(1)
layout(matrix(c(1, 1, 2,
                1, 1, 3), nrow=2, byrow=TRUE)) 
ts.plot(E2, ylab = "Residuals", col = "blue", main = "Residuals from Fitted Model Y2")
abline(a = mean(E2), b = 0) # adds horizontal line with mean(E2) as intercept and 0 slope
abline(a = mean(E2) + sigma22, b = 0, lty="dotted") # same as above + sigma2
abline(a = mean(E2) - sigma22, b = 0, lty="dotted") # same as above - sigma2
acf(E2, lag.max = 20, type = "correlation", plot = T, main = "ACF") # ACF
acf(E2, lag.max = 20, type = "partial", plot = T, main = "PACF") # PCAF
par(mfrow = c(1,1)) # set plot window to default
#Correlated?
e2_acf <- acf(E2, lag.max = 20, type = "correlation", plot = F)
Box.test(E2, lag = 20, type = c("Ljung-Box"), fitdf = 1)
#Normal?
qqnorm(E2)


## Y3
#Guess MA(1)
layout(matrix(c(1, 1, 2,
                1, 1, 3), nrow=2, byrow=TRUE)) 
ts.plot(E3, ylab = "Residuals", col = "blue", main = "Residuals from Fitted Model Y3")
abline(a = mean(E3), b = 0) # adds horizontal line with mean(E3) as intercept and 0 slope
abline(a = mean(E3) + sigma23, b = 0, lty="dotted") # same as above + sigma2
abline(a = mean(E3) - sigma23, b = 0, lty="dotted") # same as above - sigma2
acf(E3, lag.max = 20, type = "correlation", plot = T, main = "ACF") # ACF
acf(E3, lag.max = 20, type = "partial", plot = T, main = "PACF") # PCAF
par(mfrow = c(1,1)) # set plot window to default
#Correlated?
e3_acf <- acf(E3, lag.max = 20, type = "correlation", plot = F)
Box.test(E3, lag = 20, type = c("Ljung-Box"), fitdf = 1)
#Normal?
qqnorm(E3)


## Y4
#GUESS AR(2)
layout(matrix(c(1, 1, 2,
                1, 1, 3), nrow=2, byrow=TRUE)) 
ts.plot(E4, ylab = "Residuals", col = "blue", main = "Residuals from Fitted Model Y4")
abline(a = mean(E4), b = 0) # adds horizontal line with mean(E4) as intercept and 0 slope
abline(a = mean(E4) + sigma24, b = 0, lty="dotted") # same as above + sigma2
abline(a = mean(E4) - sigma24, b = 0, lty="dotted") # same as above - sigma2

acf(E4, lag.max = 20, type = "correlation", plot = T, main = "ACF") # ACF
acf(E4, lag.max = 20, type = "partial", plot = T, main = "PACF") # PCAF
par(mfrow = c(1,1)) # set plot window to default

## Y5
#GUESS ARMA(1,1)
layout(matrix(c(1, 1, 2,
                1, 1, 3), nrow=2, byrow=TRUE)) 
ts.plot(E5, ylab = "Residuals", col = "blue", main = "Residuals from Fitted Model Y5")
abline(a = mean(E5), b = 0) # adds horizontal line with mean(E5) as intercept and 0 slope
abline(a = mean(E5) + sigma25, b = 0, lty="dotted") # same as above + sigma2
abline(a = mean(E5) - sigma25, b = 0, lty="dotted") # same as above - sigma2

acf(E5, lag.max = 20, type = "correlation", plot = T, main = "ACF") # ACF
acf(E5, lag.max = 20, type = "partial", plot = T, main = "PACF") # PCAF
par(mfrow = c(1,1)) # set plot window to default



########################################################################
### Forecasting

#Y1, using AR(2)
# use the predict function. The object parameter is the model from before
# and n.ahead gives number of time periods to forecast
y_1_pred <- predict(object = m11, n.ahead = 4)

# we can submit more than one time series to the ts.plot() function. In this case
# i add, apart from  predicted y, predicty y +- se of prediction
ts.plot(y_1_pred$pred, y_1_pred$pred + y_1_pred$se, 
        y_1_pred$pred - y_1_pred$se, ylab = "Predicted Y", 
        main = expression(paste("Predicted ", Y['1'])), # we can use mathematical notation in r plots!
        lty=c(1:3),
        col = c("blue", "black", "black"))
# compare fitted and actual
ts.plot(datf$Y1, y_1_pred$pred, col = c("red", "blue"))
# x & y need to be adjusted manually. A good idea is to take min(x) and add 1 as x - coordinate
# and max y remove 1 as y coordinate. Then fine tune 
legend(x = 401, y = 2, legend = c("actual", "fitted"), col = c("red", "blue"), lty=c(1,1))

#TABLE 1
### need some measurements of the forecast
y1 <- as.vector(dat$Y1[401:404]) # no real need for these to be time series objects...
y1_hat <- as.vector(y_1_pred$pred) # ... so just store them as your plain vanilla vectors :)
#MSE
(mean((y1-y1_hat)^2))
# RMSE
sqrt(mean((y1-y1_hat)^2))
# MAPE
mape <- 0
for(i in 1:4) {
  mape <- mape + abs((y1[i] - y1_hat[i])/y1[i])
}
100*mean(abs((y1-y1_hat)/y1))


#Y2, using AR(1)
# use the predict function. The object parameter is the model from before
# and n.ahead gives number of time periods to forecast
y_2_pred <- predict(object = m2, n.ahead = 4)
ts.plot(y_2_pred$pred, y_2_pred$pred + y_2_pred$se, 
        y_2_pred$pred - y_2_pred$se, ylab = "Predicted Y", 
        main = expression(paste("Predicted ", Y['2'])), # we can use mathematical notation in r plots!
        lty=c(1:3),
        col = c("blue", "black", "black"))
# compare fitted and actual
ts.plot(datf$Y2, y_2_pred$pred, col = c("red", "blue"))
# x & y need to be adjusted manually. A good idea is to take min(x) and add 1 as x - coordinate
# and max y remove 1 as y coordinate. Then fine tune 
legend(x = 401, y = 2, legend = c("actual", "fitted"), col = c("red", "blue"), lty=c(1,1))
#TABLE 1
y2 <- as.vector(dat$Y2[401:404]) # no real need for these to be time series objects...
y2_hat <- as.vector(y_2_pred$pred) # ... so just store them as your plain vanilla vectors :)
#MSE
(mean((y2-y2_hat)^2))
# RMSE
sqrt(mean((y2-y2_hat)^2))
# MAPE
mape <- 0
for(i in 1:4) {
  mape <- mape + abs((y2[i] - y2_hat[i])/y2[i])
}
100*mean(abs((y2-y2_hat)/y2))



#Y3
y_3_pred <- predict(object = m3, n.ahead = 4)
ts.plot(y_3_pred$pred, y_3_pred$pred + y_3_pred$se, 
        y_3_pred$pred - y_3_pred$se, ylab = "Predicted Y", 
        main = expression(paste("Predicted ", Y['3'])), # we can use mathematical notation in r plots!
        lty=c(1:3),
        col = c("blue", "black", "black"))
# compare fitted and actual
ts.plot(datf$Y3, y_3_pred$pred, col = c("red", "blue"))
legend(x = 401, y = 2, legend = c("actual", "fitted"), col = c("red", "blue"), lty=c(1,1))
#TABLE 1
y3 <- as.vector(dat$Y2[401:404]) # no real need for these to be time series objects...
y3_hat <- as.vector(y_2_pred$pred) # ... so just store them as your plain vanilla vectors :)
#MSE
(mean((y3-y3_hat)^2))
# RMSE
sqrt(mean((y3-y3_hat)^2))
# MAPE
mape <- 0
for(i in 1:4) {
  mape <- mape + abs((y3[i] - y3_hat[i])/y3[i])
}
100*mean(abs((y3-y3_hat)/y3))












#Y4-5 Correlation and prediction
e4_acf <- acf(E4, lag.max = 20, type = "correlation", plot = F) 
e5_acf <- acf(E5, lag.max = 20, type = "correlation", plot = F) 
y_4_pred <- predict(object = m4, n.ahead = 4)
y_5_pred <- predict(object = m5, n.ahead = 4)
