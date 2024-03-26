//Imports
import java.util.ArrayList; import controlP5.*;

// Intialize Variables
PImage backgroundImage;
PImage barChartImage;
final int SCREENX = 800;
final int SCREENY = 600;
int x=50; int y=20; int  a=10; int  b=510;
ControlP5 cp5; Dropdown dropdown; SearchBar searchBarOA; SearchBar searchBarDD;

// Main Program
public void settings() {
  size(SCREENX, SCREENY);
}

public void setup(){
  // User Interface 
  cp5 = new ControlP5(this);
  dropdown = new Dropdown(cp5);
  backgroundImage = loadImage("plane.jpg");
  searchBarOA = new SearchBar(50, 300, 200, 30);     // OA == OriginAirport   
  searchBarDD = new SearchBar(550, 300, 200, 30);    // DD == DepartureDate
  
  // Get User Input Area
  String originAirport = "JFK";
  String departureDate = "01/01/2022 00:00";


  
  // Filter Flights
  FlightData flightData = new FlightData();
  flightData.loadFlightData();
  ArrayList<Flight> sortedFlights = flightData.sortFlightData(originAirport, departureDate);
  
  // Display Departure Board
  if(sortedFlights.isEmpty()){
    System.out.println("No flights found from " + originAirport + " on the date " 
    + departureDate + ". Please check your details and try again.");
  } else {
    flightData.printFlightDB(sortedFlights, originAirport, departureDate);
  }
}

void draw() {
  background(120, 0, 70);
  image(backgroundImage, 0, 0, 800, 600);
  searchBarOA.draw(color(0), color(255), color(0), color(0));  // OA == OriginAirport
  searchBarDD.draw(color(0), color(255), color(0), color(0));  // DD == DepartureDate

}

void keyPressed() {
  searchBarOA.keyPressed(key, keyCode);
  searchBarOA.mousePressed(mouseX, mouseY);
  searchBarDD.mousePressed(mouseX, mouseY);
  searchBarDD.keyPressed(key, keyCode);
}

void controlEvent(ControlEvent event) {
  dropdown.controlEvent(event);
}
