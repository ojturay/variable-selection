proc import file= "C:\Users\ojtur\...\Datasets\cars.txt"
		out=cars
		dbms=" "
		;
run;

proc reg data=cars outest=result;
	model price = age milage inspect extras1 extras2/ selection= rsquare adjrsq cp aic sbc ;
run;

proc sort data=result;
	by _aic_;
 	proc print data= result; 
run;

/*models based on various model selection criteria*/

/* age = a, milage = m, inspect= i, extras1= e1, extras2 = e2*/

/* Rsquare - describes proportion of the variation of the dependent variable
			 which can be explained by the model. it measures the goodnes of fit.
			 the larger the Rsquare the better the model.
		model :  price = age milage inspect extras1 extras2
					 price = 9.931117 - 0.038329a - 0.009742m - 0.005483477i - 0.23766e1 - 0.00986e2*/

/*adjusted Rsquare - indicates whether adding additional predictors improves a regression model 
					 by minimising the variance.
					 the larger the better 
		model : price = age milage extras1 
					price = 9.20600 - 0.038311a - 0.009780a - 0.22636e1*/

/*mallows Cp - complexity statistic used for as a stopping rule for various stepwise regression.
			   finds the best subset of model for availbale predictors.
			   the smaller the cp value the more precise the model 
		model : price = age milage extras1 
					price = 9.20600 - 0.038311a - 0.009780a - 0.22636e1*/

/* AIC - is an estimator of predictor error thus  better suited to select models with good prediction performance and not consistent 
		for selecting the 'true model' thus typically producing complex models. 
		the smaller the AIC the better
	model : price = age milage extras1 
			price = 9.20600 - 0.038311a - 0.009780a - 0.22636e1*/

/*SBC/BIC - imposes higher penalty on complex models. minimising BIC corresponds to selecting 
			the 'most probable' model and thus BIC is consistent for selecting model
            that describes the data better
			the smaller the better 
	model : price = age milage 
			price = 9.00258 - 0.037861a - 0.009800m */