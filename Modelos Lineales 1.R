
data(pima, package="faraway")

library(faraway)
data(pima)

head(pima)

tail(pima)

summary(pima)

head(sort(pima$diastolic),50)

pima$diastolic[pima$diastolic == 0] <- NA
pima$glucose[pima$glucose == 0] <- NA
pima$triceps[pima$triceps == 0] <- NA
pima$insulin[pima$insulin == 0] <- NA
pima$bmi[pima$bmi == 0] <- NA

pima$test <- factor(pima$test)
levels(pima$test) <- c("negative","positive")
summary(pima)

par(mfrow=c(2,3))
hist(pima$diastolic,xlab="Diastolic",main="")
plot(density(pima$diastolic,na.rm=TRUE),main="")
plot(sort(pima$diastolic),ylab="Sorted Diastolic")
plot(diabetes ~ diastolic,pima)
plot(diabetes ~ test,pima)
par(mfrow=c(1,1))

data(gala, package="faraway")
head(gala)

varsel<-gala[,c(1,2)]
summary(varsel)

par(mfrow=c(2,3))
x <- varsel$Species
boxplot(varsel, main="Boxplor for Species & Endemics")
h<-hist(x, breaks=25, col="red", xlab="Species", main="Histogram with \n Density Curve")
xfit<-seq(min(x), max(x), length=40)
yfit<-dnorm(xfit, mean=mean(x), sd=sd(x))
yfit <- yfit*diff(h$mids[1:2])*length(x)
lines(xfit, yfit, col="blue", lwd=2)
h<-hist(x, freq = F, breaks=25, col="red", xlab="Species", main="Histogram with \n Normal Curve")
lines(density(x), col="blue", lwd=2)
plot(sort(x),ylab="Sorted Species", main = "Sorted Plot")
with(gala, plot(Endemics,Species, main = "Dispersion Plot"))
par(mfrow=c(1,1))

fit<-lm(Species~Endemics, data = varsel)
library(faraway)
sumary(fit)

x0<-seq(min(varsel$Endemics),max(varsel$Endemics),length=30)
pred.m<-predict(fit,data.frame(Endemics=x0),interval="confidence",se.fit=T)
pred.p<-predict(fit,data.frame(Endemics=x0),interval="prediction",se.fit=T)

matplot(x0,cbind(pred.m$fit,pred.p$fit[,-1]),lty=c(1,2,2,3,3),
        col=c("black","red","red","blue","blue"),type="l",xlab="Endemics",
        ylab="Species")

legend('topleft',c("Estim.Media","Prediccion"),lty=c(2,3),
       col=c("red","blue"))

points(varsel$Endemics,varsel$Species, pch = 20)
