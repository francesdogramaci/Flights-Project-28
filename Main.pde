// Main - code from everyone - mainly Aimee for UI code and others for code relating to individual classes
import controlP5.*;

// Variables
int selectedOption = -1;
int x=50;
int y=20;
int  a=10;
int  b=510;
int numOfFlights;
PImage backgroundImage;
Table table;
PFont stdFont; //variable to store font
boolean keyA = false;
boolean keyD = false;
boolean keyO = false;
boolean isFlightBoardActive = false;
boolean isFactsActive = false;

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
final int EVENT_SEARCH = 10;
final int EVENT_DB = 11;
final int EVENT_FACTS = 12;

// Instances
FlightData flightData;
Emissions emissionsCalc;
ControlP5 cp5;
SearchBar searchBar;
SearchBar searchBar2;
QueryRender queryRender;
BarChart barChart;
Dropdown dropdown;
FlightBoard flightBoard;



Screen currentScreen, screenMain, screenBar, screenPie, screenSearch, screenOffset, screenBar2, screenSearchResultTree, screenDB, screenFacts;

void settings()
{
  size(SCREENX, SCREENY);
}

void setup() {
  // General Setup
  cp5 = new ControlP5(this);
  dropdown = new Dropdown(cp5);
  backgroundImage = loadImage("plane.jpg");

  stdFont = createFont("Chalkboard-30", 50);
  textFont(stdFont);

  // Read in Data
  table = loadTable("flights_full.csv", "header");
  flightData = new FlightData();
  flightData.loadFlightData();

  searchBar = new SearchBar(50, 300, 200, 30, flightData);
  searchBar2 = new SearchBar(550, 300, 200, 30, flightData);
  barChart = new BarChart();

  // Queries
  float[] queryFlightEmissions = flightData.sortFlightDataEmissions();
  emissionsCalc = new Emissions();
  float[] emissions = emissionsCalc.calculateEmissions(queryFlightEmissions);
  int[] queryDepartureTimeCounts = flightData.sortDepartureTimes();

  queryRender = new QueryRender(queryFlightEmissions, emissions, queryDepartureTimeCounts);



  //creating screen objects
  screenMain = new Screen();// main screen
  screenBar = new Screen();//bar chart screen
  screenPie = new Screen(); //pie chart screen
  screenSearch = new Screen(); //table screen
  screenOffset = new Screen(); //offset emissions table
  screenBar2 = new Screen(); // other bar chart emissions weekly
  screenSearchResultTree = new Screen(); // tree emissions
  screenDB = new Screen(); //departure board
  screenFacts = new Screen();

  Widget widget1 = new Widget(50, 350, 200, 50, "Average Emissions \n Bar Chart", color(255, 150, 200), stdFont, EVENT_FORWARD);
  Widget widget2 = new Widget(550, 350, 200, 50, "Pie Chart", color(255, 150, 200), stdFont, EVENT_PIE_CHART);
  Widget widget3 = new Widget(300, 275, 200, 50, "Search Your Flight", color(255, 150, 200), stdFont, EVENT_TABLE);
  Widget widget4 = new Widget(25, 10, 180, 30, "Main Screen", color(255, 150, 200), stdFont, EVENT_BACKWARD); // TOP SCREEN LEFT
  Widget widget5 = new Widget(300, 500, 205, 25, "Busiest Airports Information", color(255, 150, 200), stdFont, EVENT_TREE);
  Widget widget6 = new Widget(310, 20, 180, 30, "Main Screen", color(255, 150, 200), stdFont, EVENT_BACKWARD); // BOTTOM SCREEN RIGHT
  Widget widget7 = new Widget(300, 350, 200, 50, "Weekly Total Emissions \n Bar Chart", color(255, 150, 200), stdFont, EVENT_BAR);
  Widget widget8 = new Widget(300, 350, 200, 50, "Search", color(255, 150, 200), stdFont, EVENT_SEARCH);
  Widget widget9 = new Widget(310, 0, 180, 30, "Main Screen", color(255, 150, 200), stdFont, EVENT_BACKWARD); // TOP SCREEN MIDDLE
  Widget widget10 = new Widget(300, 560, 205, 25, "Departure Board", color(255, 150, 200), stdFont, EVENT_DB);
  Widget widget11 = new Widget(300, 530, 205, 25, "Offset Emissions", color(255, 150, 200), stdFont, EVENT_FACTS);
  //adding widgets to the screen
  screenMain.add(widget1); //bar chart button main screen
  screenMain.add(widget2); //pie chart widget main screen
  screenMain.add(widget3); //departure table widget main screen
  screenMain.add(widget5);
  screenMain.add(widget7);  // add weekly emissions
  screenMain.add(widget10); // add departure board screen
  screenMain.add(widget11); // add facts 
  screenBar.add(widget6); //main screen button bar chart screen
  screenSearch.add(widget9); //main screen button table screen
  screenPie.add(widget6); //main screen button pie chart screen
  screenOffset.add(widget4); //main screen button tree emissions screen
  screenBar2.add(widget6); //main screen button other bar chart screen
  screenFacts.add(widget6); //main screen button other bar chart screen
  screenSearch.add(widget8);
  screenSearchResultTree.add(widget9); // main screen button to trees

  // Intialize Screen
  currentScreen = screenMain;
}
void draw()
{
  if (currentScreen == screenMain) {
    background(120, 0, 70);
    image(backgroundImage, 0, 0, 800, 600);
    isFlightBoardActive = false;
    isFactsActive = false;

    // Dropdown menu
    dropdown.setVisible(true);
    fill(0);
    text("How would you like to represent your data?", 400, 125);

    //creating a moving title screen
    noStroke();
    fill(255);
    rect(0, 0, 800, 50);

    fill(255, 150, 200);
    textAlign(CENTER, CENTER);
    textSize(30);
    text("What is your flights CO2 Emissions?", x+100, y+8); //adjust co ords to centre text
    if (x++>=800) x=-400;
    // Other Screens draw
  } else if (currentScreen == screenBar) {
    background(255);
    currentScreen.draw();
    dropdown.setVisible(false);
    isFlightBoardActive = false;
    isFactsActive = false;
    barChart.draw();
  } else if (currentScreen == screenPie) {
    background(255);
    currentScreen.draw();
    dropdown.setVisible(false);
    isFlightBoardActive = false;
    isFactsActive = false;
    queryRender.drawPieChart();
  } else if (currentScreen == screenSearch) {
    background(255);
    dropdown.setVisible(false);
    image(backgroundImage, 0, 0, 800, 600);
    isFlightBoardActive = false;
    isFactsActive = false;
    noStroke();
    fill(255);
    rect(0, 0, 800, 50);
    currentScreen.draw();
    searchBar.draw(color(0), color(255), color(0), color(0));
    searchBar2.draw(color(0), color(255), color(0), color(0));
    // departure text label
    fill(255);
    rect(50, 268, 200, 20);
    textSize(15);
    textAlign(LEFT, CENTER);
    fill(0);
    text("Departure Airport:", 55, 280);

    // time text label
    fill(255);
    rect(550, 268, 200, 20);
    textSize(15);
    textAlign(LEFT, CENTER);
    fill(0);
    text("Arrival Airport:", 555, 280);
  } else if (currentScreen == screenOffset) {
    background(255);
    dropdown.setVisible(false);
    isFlightBoardActive = false;
    isFactsActive = false;
    currentScreen.draw();
    textAlign(CENTER, CENTER);
    textSize(25);
    text("Below are the three airports with the most departures per day \n Select the corresponding key for more info", 400, 150);
    fill(color(255, 150, 200));
    rect(0, 200, 800, 50);
    fill(255);
    textAlign(CENTER, CENTER);
    textSize(20);
    text("Atlanta International Airport \n ATL", 400, 225);
    text("Dallas Fort Worth \n DFW", 100, 225);
    text("O'Hare International \n ORD", 700, 225);

    fill(0);
    textSize(20);
    text("Press A", 400, 275);
    text("Press D", 100, 275);
    text("Press O", 700, 275);

    // Info
    if (keyA == true) {
      keyD = false;
      keyO = false;
      textSize(25);
      text("There were " + numOfFlights + " flights from Atlanta International in Jan 2022", 400, 350);
    } else if (keyD == true) {
      keyA = false;
      keyO = false;
      textSize(25);
      text("There were " + numOfFlights + " flights from Dallas International in Jan 2022", 400, 350);
    } else if (keyO == true) {
      keyA = false;
      keyD = false;
      textSize(25);
      text("There were " + numOfFlights + " flights from O'Hare International in Jan 2022", 400, 350);
    }
  } else if (currentScreen == screenBar2) {
    background(255);
    dropdown.setVisible(false);
    isFlightBoardActive = false;
    isFactsActive = false;
    currentScreen.draw();
    queryRender.drawBarChart();
  } else if (currentScreen == screenSearchResultTree) {
    background(255);
    dropdown.setVisible(false);
    currentScreen.draw();
    queryRender.drawTreeChart();
    isFlightBoardActive = false;
    isFactsActive = false;
  } else if (currentScreen == screenDB) {
    background(255);
    dropdown.setVisible(false);
    isFlightBoardActive = true;
    isFactsActive = false;
    flightBoard = new FlightBoard(table);
    flightBoard.setup();
    flightBoard.draw();
  } else if (currentScreen == screenFacts) {
    background(255);
    dropdown.setVisible(false);
    currentScreen.draw();
    queryRender.drawOffsetFacts();
    isFlightBoardActive = false;
    isFactsActive = true;
  }
  currentScreen.draw();
}


void mousePressed() {
  if (isFlightBoardActive) {
    flightBoard.mousePressed();
  } else if(isFactsActive) {
    queryRender.mousePressed();
  } else {
    int event = currentScreen.getEvent(mouseX, mouseY); //getting event based on mouse position
    //handling diff events based on clicked button
    switch (event) {
    case EVENT_TABLE:
      println("Search Screen");
      currentScreen = screenSearch;
      break;
    case EVENT_PIE_CHART:
      println("Pie Chart!");
      currentScreen = screenPie;
      break;
    case EVENT_FORWARD :
      currentScreen = screenBar;
      break;
    case EVENT_BACKWARD:
      currentScreen = screenMain;
      break;
    case EVENT_TREE:
      currentScreen = screenOffset;
      break;
    case EVENT_BAR:
      currentScreen = screenBar2;
      break;
    case EVENT_SEARCH:
      currentScreen = screenSearchResultTree;
      String[] inputs = searchBar.checkAndSendData();
      queryRender.inputs = inputs;
      float emission = flightData.queryTreeChart(inputs[0], inputs[1]);
      queryRender.emission = emission;
      break;
    case EVENT_DB:
      currentScreen = screenDB;
      break;
    case EVENT_FACTS:
      currentScreen = screenFacts;
      break;
    default:
      if (currentScreen == screenMain && event == EVENT_FORWARD) {
        println("creating new screen");
        Screen newScreen = new Screen();
        currentScreen = newScreen;
      }

      break;
    }
  }
}


void keyPressed() {
  searchBar.mousePressed(mouseX, mouseY);
  searchBar2.mousePressed(mouseX, mouseY);
  searchBar.keyPressed(key, keyCode);
  searchBar2.keyPressed(key, keyCode);

  if (currentScreen == screenOffset) {
    if (key == 'A' || key == 'a') {
      numOfFlights = flightData.queryCountFlights("ATL");
      keyA = true;
    } else if (key == 'D' || key == 'd') {
      numOfFlights = flightData.queryCountFlights("DFW");
      keyD = true;
    } else if (key == 'O' || key == 'o') {
      numOfFlights = flightData.queryCountFlights("ORD");
      keyO = true;
    }
  }
}
