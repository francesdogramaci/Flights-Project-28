//jamie
class Emissions{
  //must create an array for each flight and details
  // uses distance specified in each value in the array to find the carbon emissions for each flight
  
  int distance;
  //set the constants
  double constant = 3.1;// number of tonnes of c02 fuel produced by burning  a tonne of aviation fuel
  double avFuelM = 0.00066964; // average fuel mass per 1 air mile(tonnes) 
  
  void EmissionsCalc() {
  //calculations
  double FuelMass = distance * avFuelM; //multiply the amount of miles by the average fuel Mass
  double carbonEmissions = FuelMass * constant; //calculate carbon emission per flight
  }
}
