#use rnorm() to generate a predictor X of lenght n=100 and random noise
set.seed(123456)
X<-rnorm(100)
e<-rnorm(100)
#generate a response vector Y
b0<-10
b1<-15
b2<-20
b3<-50
Y<-b0+b1*X+b2*(X^2)+b3*(X^3)+e
#use regsubsets() to perform best subset selection
library(leaps)
data.fr<-data.frame(X,Y)
sub.select<-regsubsets(Y~poly(X,degree=10,raw=TRUE),data=data.fr,nvmax=10)
sum<-summary(sub.select)
plot(sum$cp)
which.min(sum$cp)
plot(sum$bic)
which.min(sum$bic)
plot(sum$adjr2)
which.max(sum$adjr2)
coefficients(sum$cp,id=3)
coefficients(sub.select,id=4)
coefficients(sub.select,id=6)
fwd.sub<-regsubsets(Y~poly(X, 10, raw=TRUE),data=data.fr, nvmax = 10, method = "forward")
bwd.sub<-regsubsets(Y~poly(X, 10, raw=TRUE),data=data.fr, nvmax = 10, method = "backward")
sum.fwd<-summary(fwd.sub)
sum.bwd<-summary(bwd.sub)
plot(fwd.sub)
which.min(sum.fwd$cp)
which.min(sum.bwd$cp)
which.min(sum.fwd$bic)
which.min(sum.bwd$bic)
which.max(sum.fwd$adjr2)
which.max(sum.bwd$adjr2)

#fit a lasso model using X, X^2...X^10 as predictors
install.packages("glmnet")
library(glmnet)
data.matrix<-model.matrix(Y~poly(X,10,raw=TRUE),data=data.fr)
lasso.fit<-cv.glmnet(data.matrix[,-1],Y,alpha=1)
plot(lasso.fit)
best.fit<-glmnet(data.matrix,Y,alpha=1)
predict(best.fit,s=lasso.fit$lambda.min,type="coefficients")
#generate a response vector Y
b7<-4
Y<-b0+b7*(X^7)+e
#subset selection
data.fr7<-data.frame(Y,X)
fit.sub<-regsubsets(Y~poly(X,10,raw=TRUE),data=data.fr7,nvmax=10)
which.min(summary(fit.sub)$cp)
coefficients(fit.sub, id = 3)
which.min(summary(fit.sub)$bic)
coefficients(fit.sub, id = 2)
which.max(summary(fit.sub)$adjr2)
coefficients(fit.sub, id = 5)
#lasso
data.matrix7<-model.matrix(Y~poly(X,10,raw=T),data=data.fr7)
lasso.fit7<-cv.glmnet(data.matrix7[,-1],Y,alpha=1)
plot(lasso.fit7)
best.fit7<-glmnet(data.matrix7,Y,alpha=1)
predict(best.fit7,s=lasso.fit7$lambda.min,type="coefficients")
