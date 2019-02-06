
datos<-read.csv('DataSets/acme.csv')
attach(datos)
plot(market,acme)

summary(datos[,c(3,4)])
cor.test(market,acme)

fit<-lm(acme~market, data = datos)

mc<-fit2$coefficients;mc
abline(a=0,b=mc[2], col = 'red')
library(faraway)
sumary(fit)


x0<-seq(min(market),max(market),length=60)
pred.m<-predict(fit,data.frame(market=x0),interval="confidence",se.fit=T)
pred.p<-predict(fit,data.frame(market=x0),interval="prediction",se.fit=T)


matplot(x0,cbind(pred.m$fit,pred.p$fit[,-1]),lty=c(1,2,2,3,3),
        col=c("black","red","red","blue","blue"),type="l",xlab="market",
        ylab="acme")

legend('topleft',c("Estim.Media","Prediccion"),lty=c(2,3),
       col=c("red","blue"))

points(market,acme, pch = 20)


