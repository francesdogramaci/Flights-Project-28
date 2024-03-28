Table table;
PImage planeIcon;
final int DISTANCE_BETWEEN_ROWS = 25;
final int TITLE_LOCATION = 30;
final int HEADER_LOCATION = TITLE_LOCATION+50;
final int FIRST_ROW_LOCATION = HEADER_LOCATION+DISTANCE_BETWEEN_ROWS;
final int DISTANCE_BETWEEN_COLUMNS = 200;
final int FIRST_COLUMN_LOCATION = 50;
PFont titleFont;
PFont headerFont;
PFont bodyFont;
final int SCREENX = 700;
final int SCREENY = 500;
final int EVENT_NULL=0;
final int EVENT_FORWARD=1;
final int EVENT_BACKWARD=2;
Widget widgetForward, widgetBackward;
Screen currentScreen;
ArrayList Screens;
int currentScreenNumber = 0;
int index =0;

void settings(){
   size (SCREENX, SCREENY); 
}

void setup(){
  table = loadTable("flights_full.csv", "header");
  textAlign(LEFT, CENTER);
  titleFont = loadFont("Optima-BoldItalic-30.vlw");
  bodyFont = loadFont("AlNile-20.vlw");
  headerFont = loadFont("AlBayan-Bold-40.vlw");
  planeIcon = loadImage ("IMG_PLANE_ICON.jpeg");
  widgetForward=new Widget(610, 470, 70, 20, "Next", color(120), bodyFont, EVENT_FORWARD);
  widgetBackward=new Widget(20, 470, 70, 20, "Back", color(120), bodyFont, EVENT_BACKWARD);
  Screens = new ArrayList();
  Screens.add (new Screen (table, 0));
  currentScreen = (Screen) Screens.get(currentScreenNumber);
}

void draw(){
  if (currentScreen.index>=15){
    currentScreen.add(widgetBackward);
  }
  if (currentScreen.index+15<=table.getRowCount()){
    currentScreen.add(widgetForward);
  }
  currentScreen.draw();
}

void mousePressed(){
  switch(currentScreen.getEvent(mouseX, mouseY)) {
    case EVENT_FORWARD:
      currentScreenNumber++;
      if (currentScreenNumber>=Screens.size()){
        index=index+15;
        Screens.add (new Screen (table, index));
      }
        currentScreen = (Screen) Screens.get(currentScreenNumber);
      println("forward"+ currentScreenNumber);
      break;
    case EVENT_BACKWARD:
      currentScreenNumber--;
      currentScreen = (Screen) Screens.get(currentScreenNumber);
      println("backward"+ currentScreenNumber);
      break;
  }
}
