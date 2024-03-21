
Table table;

ArrayList<Flight> flightData;


void setup() {
  table = loadTable("flights_full.csv", "header");
  
  flightData = new ArrayList<>();
  sortData();
  
  // Stand-in for User Input
  String originAirport = "LAX";
  String departureDate = "01/01/2022 00:00";
  
  getInfo(originAirport, departureDate);
}


void sortData() {
  for (int i = 0; i < table.getRowCount(); i++){
    TableRow row = table.getRow(i);
    String originAirport = row.getString("ORIGIN");
    String destinationAirport = row.getString("DEST");
    String departureDate = row.getString("FL_DATE");
    float distance = row.getFloat("DISTANCE");
    int cancelled = row.getInt("CANCELLED");
    
    Flight flight = new Flight(originAirport, destinationAirport, departureDate, distance, cancelled);
    flightData.add(flight);
  }
}

void getInfo(String originAirport, String departureDate) {
  ArrayList<Flight> sortedFlights = new ArrayList<>();
  
  for (Flight flight : flightData) {
    if (flight.getDate().equals(departureDate) && flight.getOrigin().equals(originAirport)) {
      sortedFlights.add(flight);
    }
  }
  
  
  
  println("Departure board for " + departureDate + " from " + originAirport + ": ");
  
  for(Flight flight : sortedFlights) {
    float emissions; String cancelled;
    
    if(flight.getCancelled() == 1) {
      emissions = 0;
      cancelled = "Cancelled";
    } else {
      Emissions emissionCalc = new Emissions(flight.getDistance());
      emissions = emissionCalc.calculateEmissions();
      cancelled = "Departed";
    }
    
    println("Destination: " + flight.getDestination() + ", Distance: " + flight.getDistance() + " miles, Status: " 
    + cancelled + ", Emissions: " + emissions + " kg");
  }
}