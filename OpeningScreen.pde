//aimee
PImage backgroundImage;
PImage fakeChartImage;
Table table;
PFont stdFont; //variable to store font

ArrayList<Flight> flightDataDB; // DB = Departure Board

int x=50;
int y=20;
int  a=10;
int  b=510;
import controlP5.*;

final int SCREENX = 800;
final int SCREENY = 600;
final int EVENT_BARCHART_BACK = 5;
final int EVENT_NULL = 0;
final int EVENT_BUTTON1 = 1;
final int EVENT_FORWARD = 2;
final int EVENT_BUTTON2 = 3;
final int EVENT_BACKWARD = 4;

ControlP5 cp5;
Dropdown dropdown;
SearchBar searchBar;
SearchBar searchBar2;
BarChart barChart;

Screen currentScreen, screen1, screen2;

void settings()
{
  size(SCREENX, SCREENY);
}

void setup() {
  table = loadTable("flights_full.csv", "header");
  cp5 = new ControlP5(this);
  dropdown = new Dropdown(cp5);
  stdFont = createFont("Chalkboard-30", 30);
  textFont(stdFont);
  textAlign(CENTER, CENTER);
  
  backgroundImage = loadImage("plane.jpg");
  searchBar = new SearchBar(50, 300, 200, 30);
  searchBar2 = new SearchBar(550, 300, 200, 30);
  barChart = new BarChart();

  flightDataDB = new ArrayList<>();  
  
  sortData();
  
  // Stand-in for User Input
  String originAirport = "LAX";
  String departureDate = "01/01/2022 00:00";
  
  getInfo(originAirport, departureDate);
  //creating two screen objects 
  screen1 = new Screen();//(backgroundImage);
  screen2 = new Screen();//(fakeChartImage);
  
    //Widget widget1 = new Widget(100, 100, 180, 40, "VIEW CO2", color(172, 10, 173), stdFont, EVENT_BUTTON1);
  Widget widget1 = new Widget(350, 400, 75, 25, "      GO!", color(250, 134, 211), stdFont, EVENT_FORWARD);
  //Widget widget3 = new Widget(100, 100, 180, 40, "Bar Chart", color(172, 10, 173), stdFont, EVENT_BUTTON2); 
  Widget widget4 = new Widget(325, 550, 180, 30, "                                  Main Screen", color(250, 134, 211), stdFont, EVENT_BACKWARD);
  
  //adding widgets to the screen
   screen1.add(widget1);
   //screen1.add(widget2);
   //screen2.add(widget3);
   screen2.add(widget4);
   
   currentScreen = screen1;
}
void draw()
{
  if(currentScreen == screen1){
  background(120,0,70);
  image(backgroundImage, 0, 0, 800, 600);
  searchBar.draw(color(0), color(255), color(0), color(0));
  searchBar2.draw(color(0), color(255), color(0), color(0));
  
  //dropdown label
  fill(0);
  text("How would you like to represent your data?", 400, 125);
  
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
  textAlign(CENTER, CENTER);
  text("What is your flights CO2 Emissions?", x+100, y+25); //adjust co ords to centre text
  textSize(13);
  if(x++>=800) x=-400;
 
  }
  else if(currentScreen == screen2){
    background(255);
  }
  
  currentScreen.draw();
}
void mousePressed(){
  int event = currentScreen.getEvent(mouseX, mouseY); //getting event based on mouse position
  
  //handling diff events based on clicked button
  switch (event) {
    case EVENT_BUTTON1:
      println("button 1!");
      break;
    case EVENT_BUTTON2:
      println("button 2!");
      break;
    case EVENT_FORWARD:
      println("bar chart"); 
      currentScreen = screen2;
      break;
    case EVENT_BACKWARD:
      println("main screen"); 
      currentScreen = screen1;
      break;
    default:
      if(currentScreen == screen1 && event == EVENT_FORWARD){
        println("creating new screen");
        Screen newScreen = new Screen();
        currentScreen = newScreen;
      }
      break;
  }
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