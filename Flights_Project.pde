// project week one 
Table table;

String[] originAirports;
String[] destinationAirports;
float[] distances;
float[] calculatedEmissions;
//Emissions emissions[];

void setup() {
  table = loadTable("flights_full.csv", "header");
  
  println(table.getRowCount() + " total rows in table");
  println(table.getColumnCount() + " total columns in table");
  
  originAirports = new String[table.getRowCount()];
  destinationAirports = new String[table.getRowCount()];
  distances = new float[table.getRowCount()];
  //emissions = new Emissions[table.getRowCount()];
  
  sortData();
}


void sortData() {
  for (int i = 0; i < 10; i++) {
    TableRow row = table.getRow(i);
    originAirports[i] = row.getString("ORIGIN");
    destinationAirports[i] = row.getString("DEST");
    distances[i] = row.getInt("DISTANCE");
    //calculatedEmissions[i] = emissions[i].calculateEmissions(distances[i]);
    
     int flightNumber = i + 1;
     println("Flight " + flightNumber + " of the month flew from " + originAirports[i] + " to " + destinationAirports[i] + 
             ". It flew a total of " + distances[i] + " miles.");
  }
}
