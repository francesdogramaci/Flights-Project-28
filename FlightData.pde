import java.util.ArrayList;
// Lisa
class FlightData {
  Table table;
  ArrayList<Flight> flightData;

  public void loadFlightData() {
    table = loadTable("flights_full.csv", "header");
    flightData = new ArrayList<>();

    for (int i = 0; i < table.getRowCount(); i++) {
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

  public ArrayList<Flight> sortFlightData(String originAirport, String departureDate) {
    ArrayList<Flight> sortedFlights = new ArrayList<>();

    for (Flight flight : flightData) {
      if (flight.getDate().equals(departureDate) && flight.getOrigin().equals(originAirport)) {
        sortedFlights.add(flight);
      }
    }
    return sortedFlights;
  }




    public void printFlightDB(ArrayList<Flight> sortedFlights, String departureDate, String originAirport) {    // DB = Departure Board
      println("Departure board for " + departureDate + " from " + originAirport + ": ");

      for (Flight flight : sortedFlights) {
        float emissions;
        String cancelled;

        if (flight.getCancelled() == 1) {
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
  }
