param numCities;
set Cities:=1..numCities;
param TransportCost {i in Cities, j in Cities};        
param VaccineDemand {i in Cities};
param VaccineAmount {i in Cities}; 
param VaccinePrice {i in Cities};
param Budget {i in Cities};


# variable declaration
var X {i in Cities, j in Cities} >= 0 binary;

# objective function
minimize cost:
	sum{i in Cities, j in Cities} (TransportCost[i,j]+VaccinePrice[j])*X[i,j];   
	 
subject to min_demand {j in Cities}:
	VaccineAmount[j]-sum{i in Cities}(X[i,j]*VaccineDemand[i])<=VaccineDemand[j];
	
subject to budget_limit {i in Cities}:
	Budget[i]>=sum{j in Cities}(TransportCost[i,j]+VaccinePrice[j])*X[i,j];