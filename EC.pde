import controlP5.*;

// Variables
int selectedOption = -1;
int x=50;
int y=20;
int  a=10;
int  b=510;
PImage backgroundImage;
PImage treeImage; // Image for representing trees
Table table;
PFont stdFont; //variable to store font

// Constants
final int SCREENX = 800;
final int SCREENY = 600;
final int EVENT_BARCHART_BACK = 5;
final int EVENT_NULL = 0;
final int EVENT_BUTTON1 = 1;
final int EVENT_FORWARD = 2;
final int EVENT_BUTTON2 = 3;
final int EVENT_BACKWARD = 4;
final int EVENT_PIE_CHART = 6;
final int EVENT_TABLE = 7;
final int EVENT_TREE = 8;
final int EVENT_BAR = 9;

// Instances
FlightData flightData;
Emissions emissionsCalc;
ControlP5 cp5;
Dropdown dropdown;
SearchBar searchBar;
SearchBar searchBar2;
QueryRender queryRender;
BarChart barChart;
TreeChart treeChart;//for tree chart



Screen currentScreen, screen1, screen2, screen3, screen4, screen5, screen6;

void settings()
{
  size(SCREENX, SCREENY);
}

void setup() {
  // General Setup
  cp5 = new ControlP5(this);
  dropdown = new Dropdown(cp5);
  backgroundImage = loadImage("plane.jpg");
  treeImage = loadImage("treeimage.png"); // Load image for trees
  searchBar = new SearchBar(50, 300, 200, 30);
  searchBar2 = new SearchBar(550, 300, 200, 30);
  barChart = new BarChart();
  treeChart = new TreeChart(treeImage);
  
  stdFont = createFont("Chalkboard-30", 30);
  textFont(stdFont);
  textAlign(CENTER, CENTER);
  
  // Read in Data
  table = loadTable("flights_full.csv", "header");
  flightData = new FlightData();
  flightData.loadFlightData();
  
  // Queries
  float[] queryFlightEmissions = flightData.sortFlightDataEmissions();
  emissionsCalc = new Emissions();
  float[] emissions = emissionsCalc.calculateEmissions(queryFlightEmissions);
  int[] queryDepartureTimeCounts = flightData.sortDepartureTimes();
  queryRender = new QueryRender(queryFlightEmissions, emissions, queryDepartureTimeCounts);
  

  //creating two screen objects 
  screen1 = new Screen();// main screen
  screen2 = new Screen();//bar chart screen
  screen3 = new Screen(); //pie chart screen
  screen4 = new Screen(); //table screen
  screen5 = new Screen(); //tree emissions table
  screen6 = new Screen(); // other bar chart emissions weekly
 
  Widget widget1 = new Widget(250, 400, 75, 25, "           Bar Chart", color(255, 150, 200), stdFont, EVENT_FORWARD);
  Widget widget2 = new Widget(470, 400, 75, 25, "           Pie Chart", color(255, 150, 200), stdFont, EVENT_PIE_CHART);
  Widget widget3 = new Widget(340, 400, 115, 25, "                     Departure Table", color(255, 150, 200), stdFont, EVENT_TABLE);
  Widget widget4 = new Widget(125, 10, 180, 30, "                                  Main Screen", color(255, 150, 200), stdFont, EVENT_BACKWARD);
  Widget widget5 = new Widget(300, 500, 205, 25, "                                           How to offset your emissions!", color(255, 150, 200), stdFont, EVENT_TREE);
  Widget widget6 = new Widget(50, 550, 180, 30, "               Main Screen", color(255, 150, 200), stdFont, EVENT_BACKWARD);
  Widget widget7 = new Widget(300, 450, 205, 25, "                                           Weekly Emissions Bar Chart", color(255, 150, 200), stdFont, EVENT_TREE);
  //adding widgets to the screen
   screen1.add(widget1); //bar chart button main screen
   screen1.add(widget2); //pie chart widget main screen
   screen1.add(widget3); //departure table widget main screen
   screen1.add(widget5);
   screen1.add(widget7);  // add weekly emissions
   screen2.add(widget4); //main screen button bar chart screen
   screen4.add(widget4); //main screen button table screen 
   screen5.add(widget5); //main screen button tree emissions screen
   screen6.add(widget4); //main screen button tree emissions screen
  
  // Intialize Screen
  currentScreen = screen1;
   
  // pieChart = new PieChart(scheduledDep, actualDep);
  // screen3.addPieChart(pieChart);
   screen3.add(widget6); //main screen button pie chart screen
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
  text("Heres how we can represent your data:", 280, 125);
  
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
  
  // Set dropdown visibility
    dropdown.setVisible(true);

  //creating a moving title screen
  noStroke(); 
  fill(255);
  rect(x-100, y+11, 400, 30);
  
  fill(255, 150, 200);
  textAlign(CENTER, CENTER);
  text("What is your flights CO2 Emissions?", x+100, y+25); //adjust co ords to centre text
  textSize(13);
  if(x++>=800) x=-400;
 
  }
  else if(currentScreen == screen2){
    background(255);
    currentScreen.draw();
    // Set dropdown visibility
    dropdown.setVisible(false);
    barChart.draw();
  }
  else if(currentScreen == screen3){
    background(255);
    currentScreen.draw();
    dropdown.setVisible(false);
    queryRender.drawPieChart();
  }
  else if(currentScreen == screen4){
    background(450, 200, 5);
    currentScreen.draw();
    dropdown.setVisible(false);
  }
  else if(currentScreen == screen5){
    background(255);
    currentScreen.draw();
    dropdown.setVisible(false);
    treeChart.draw();
  }
  else if(currentScreen == screen6){
    background(255);
    currentScreen.draw();
    dropdown.setVisible(false);
    queryRender.drawBarChart();
  }
    
  
  currentScreen.draw();
}
void mousePressed(){
  int event = currentScreen.getEvent(mouseX, mouseY); //getting event based on mouse position
  
  //handling diff events based on clicked button
  switch (event) {
    case EVENT_TABLE:
      println("Departure Table");
      currentScreen = screen4;
      break;
    case EVENT_PIE_CHART:
      println("Pie Chart!");
      currentScreen = screen3;
      break;
    case EVENT_FORWARD :
      currentScreen = screen2;
      break;
    case EVENT_BACKWARD:
      currentScreen = screen1;
      break;
   case EVENT_TREE:
       currentScreen = screen5;
   case EVENT_BAR:
       currentScreen = screen6;
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
