# subset-selection.r
I will generate simulated data, and then will use this data to perform best subset selection
(1) use the norm() function to generate a predictor X of length n=100, as well as a noise vector e of length n=100. 
(2) generate a response vector Y of lenght n=100 according to the model Y=b0+b1X+b2X^2+b3X^3+e, where b0, b1, b2 and b3 are constants.
(3) use the regsubsets() function to perform best subset selection in order to choose the best model containing the predictors X, X^2, ....,X^10.
(4) fit a lasso model to the simulated data. Use cross-validation error as a function of lambda. 
lasso provides the results with the first three order of variable, which is same as what I simulated it. The coefficients estimated are 13.24, 13.25, 16.62, and 49.00, all of which are not far away from the true parameters.
