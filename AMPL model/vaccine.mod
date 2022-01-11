param numCities;
set Cities:=1..numCities;
param TransportCost {i in Cities, j in Cities};        
param VaccineDemand {i in Cities};
param VaccineAmount {i in Cities}; 
param VaccinePrice {i in Cities};
param Budget {i in Cities};


# variable declaration
var X {i in Cities, j in Cities} >= 0 binary;

# objective function 1
#minimize cost:
	#sum{i in Cities, j in Cities} (TransportCost[i,j]+VaccinePrice[j])*X[i,j];   

# objective function 2
maximize coverage:
	sum{i in Cities, j in Cities} (VaccineAmount[i]/VaccineDemand[j])*X[i,j]; 
	 
subject to min_demand {j in Cities}:
	1.1*(VaccineAmount[j]- VaccineDemand[j])<=sum{i in Cities}(X[i,j]*(VaccineAmount[i]-VaccineDemand[i]));

subject to demand_satisf {i in Cities}:
	VaccineDemand[i]-VaccineAmount[i] <= sum{j in Cities}(X[i,j]*(VaccineAmount[j]-VaccineDemand[j]));
	
subject to budget_limit {i in Cities}:
	Budget[i]>=sum{j in Cities}(TransportCost[i,j]+VaccinePrice[j])*X[i,j];