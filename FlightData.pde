// Lisa
import java.util.ArrayList;

class FlightData {
  Table table;
  ArrayList<Flight> flightData;
  float[] queryFlightEmissions;
  int[] queryDepartureTimeCounts;
  Flight flight;
  SearchBar searchBar;
  Emissions emissions;
  String originAirport;
  String destinationAirport;

  public FlightData() {
    this.emissions = new Emissions(); // Initialize Emissions instance
  }

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
      int crsDepTime = row.getInt("CRS_DEP_TIME");
      int depTime = row.getInt("DEP_TIME");

      flight = new Flight(originAirport, destinationAirport, departureDate, distance, cancelled, crsDepTime, depTime);
      flightData.add(flight);
    }
  }

  public float[] sortFlightDataEmissions() {
    int barNums = 5;
    int groupSize = flightData.size() / 5;
    int startIndex = 0;
    queryFlightEmissions = new float[barNums];

    for (int i = 0; i < barNums; i++) {
      float totalDistance = 0;
      int endIndex = Math.min(startIndex + groupSize, flightData.size());

      for (int j = startIndex; j < endIndex; j++) {
        totalDistance += flightData.get(j).distance;
      }
      println(nf(totalDistance));
      queryFlightEmissions[i] = totalDistance;
      startIndex = endIndex;
    }
    return queryFlightEmissions;
  }

  public int[] sortDepartureTimes() {
    int earlyCount = 0;
    int onTimeCount = 0;
    int lateCount = 0;

    for (Flight flight : flightData) {
      int crsDepTime = flight.getCRSDepTime();
      int depTime = flight.getDepTime();

      if (crsDepTime != 0 && depTime != 0) {
        if (depTime < crsDepTime) {
          earlyCount++;
        } else if (depTime == crsDepTime) {
          onTimeCount++;
        } else {
          lateCount++;
        }
      }
    }

    queryDepartureTimeCounts = new int[]{earlyCount, onTimeCount, lateCount};
    return queryDepartureTimeCounts;
  }

  public float queryTreeChart(String originAirport, String destinationAirport) {
    float distance = getFlightDistance(originAirport, destinationAirport);
    if (distance >= 0) {
      float emission = emissions.calculateEmission(distance);
      return emission;
    } else {
      return -1;
    }
  }

  private float getFlightDistance(String originAirport, String destinationAirport) {
    println("Searching for flight with origin: " + originAirport + " and destination: " + destinationAirport);

    for (Flight flight : flightData) {
      println("Checking flight" + originAirport + "with origin: " + flight.getOrigin() + " and destination: " + flight.getDestination());
      if (flight.getOrigin().equals(originAirport) && flight.getDestination().equals(destinationAirport)) {
        println("Flight found: Distance: " + flight.getDistance());
        return flight.getDistance();
      }
    }

    println("No matching flight found");
    return -1; // If no matching flight is found
  }

  public int queryCountFlights(String originAirport) {
    int queryFlightCount = 0;
    for (Flight flight : flightData) {
      if (flight.getOrigin().equals(originAirport)) {
        queryFlightCount++;
      }
    }
    return queryFlightCount;
  }

  public String getRandomSentence() {
    String[] sentences = {
      "Reduce, reuse, recycle.",
      "Avoid buying fast fashion, instead opt\n for vintage and recycled clothing.",
      "Switch lights off and unplug your electeonic\n devices when not in use.",
      "Sign up to get your electricity from clean energy \nthrough your local utility or a certified renewable\n energy provider.",
      "Drive less, walk more.",
      "Fly nonstop since landings and takeoffs use\n more fuel and produce more emissions.",
      "Vote to let your representatives know you want the to \nphase out fossil fuels to decarbonise the earth.",
      "  Turn your water heater down to 120˚F.\n This can save about 550 pounds of CO2 a year.",
      "Support and buy from companies that are\n environmentally responsible.",
      "Try a Meatless Monday, reducing your consumption\n of meat reduces your carbon emissions."
    };
    // generate a random index to select a sentence from the array
    int randomIndex = int(random(sentences.length));
    return sentences[randomIndex]; // Return the selected random sentence
  }
}
