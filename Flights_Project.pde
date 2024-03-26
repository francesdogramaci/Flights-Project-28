
PImage backgroundImage;
PImage barChartImage;
Table table;

ArrayList<Flight> flightDataDB; // DB = Departure Board

// initialize variables
final int SCREENX = 800;
final int SCREENY = 600;
int x=50;
int y=20;
int  a=10;
int  b=510;

import controlP5.*;

ControlP5 cp5;
Dropdown dropdown;
SearchBar searchBar;
SearchBar searchBar2;

void settings () {
  size(SCREENX, SCREENY);
}


void setup() {
  table = loadTable("flights_full.csv", "header");
  cp5 = new ControlP5(this);
  dropdown = new Dropdown(cp5);
  backgroundImage = loadImage("plane.jpg");
  searchBar = new SearchBar(50, 300, 200, 30);
  searchBar2 = new SearchBar(550, 300, 200, 30);
  
  flightDataDB = new ArrayList<>();  
 
  sortData();
  
  // Stand-in for User Input
  String originAirport = "LAX";
  String departureDate = "01/01/2022 00:00";
  
  getInfo(originAirport, departureDate);
}

void draw() {
  background(120, 0, 70);
  image(backgroundImage, 0, 0, 800, 600);
  searchBar.draw(color(0), color(255), color(0), color(0));
  searchBar2.draw(color(0), color(255), color(0), color(0));


  // dropdown label
  fill(0);
  textSize(20);
  text("How would you like to represent your data?", 225, 125);

  // departure text label
  fill(255);
  rect(50, 268, 200, 20);
  textSize(20);
  fill(0);
  text("Departure Airport:", 50, 275);

  // time text label
  fill(255);
  rect(550, 268, 200, 20);
  textSize(20);
  fill(0);
  text("Departure Time:", 550, 275);

  //creating a moving title screen
  noStroke();
  fill(0);
  rect(x, y, 200, 50);

  fill(255, 190, 250);
  textSize(13);
  textAlign(CENTER, CENTER);
  text("What is your flights CO2 Emissions?", x+100, y+25); //adjust co ords to centre text
  textSize(13);
  if (x++>=800) x=-400;
}

void keyPressed() {
  searchBar.keyPressed(key, keyCode);
  searchBar.mousePressed(mouseX, mouseY);
  searchBar.keyPressed(key, keyCode);
  searchBar2.mousePressed(mouseX, mouseY);
  searchBar2.keyPressed(key, keyCode);
}

void controlEvent(ControlEvent event) {
  dropdown.controlEvent(event);
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
    flightDataDB.add(flight);
  }
}


void getInfo(String originAirport, String departureDate) {
  ArrayList<Flight> DBSortedFlights = new ArrayList<>();
  
  for (Flight flight : flightDataDB) {
    if (flight.getDate().equals(departureDate) && flight.getOrigin().equals(originAirport)) {
      DBSortedFlights.add(flight);
    }
  }
  
  
  println("Departure board for " + departureDate + " from " + originAirport + ": ");
  for(Flight flight : DBSortedFlights) {
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
