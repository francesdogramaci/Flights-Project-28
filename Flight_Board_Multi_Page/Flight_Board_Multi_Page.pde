final int SCREENX = 700;
final int SCREENY = 500;
Table boardTable;
PImage planeIcon;
PFont titleFont;
PFont headerFont;
PFont bodyFont;
final int DISTANCE_BETWEEN_ROWS = 25;
final int TITLE_LOCATION = 30;
final int HEADER_LOCATION = TITLE_LOCATION+50;
final int FIRST_ROW_LOCATION = HEADER_LOCATION+DISTANCE_BETWEEN_ROWS;
final int DISTANCE_BETWEEN_COLUMNS = 200;
final int FIRST_COLUMN_LOCATION = 50;
Widget widgetForward, widgetBackward, widgetCanceled, widgetDelayed, widgetRightNormal, widgetLeftNormal;
final int EVENT_NULL=0;
final int EVENT_FORWARD=1;
final int EVENT_BACKWARD=2;
final int EVENT_CANCELED= 3;
final int EVENT_DELAYED= 4;
final int EVENT_NORMAL= 5;
ArrayList Screens, CanceledScreens, DelayedScreens;
Screen currentScreen;
final int FLIGHTS_PER_SCREEN = 15;
int currentScreenNumber, canceledScreenNumber, delayedScreenNumber, index, cancelIndex, delayIndex;
boolean canceled, delayed;

void settings(){
   size (SCREENX, SCREENY); 
}

void setup(){
  boardTable = loadTable("flights_full.csv", "header");
  textAlign(LEFT, CENTER);
  titleFont = loadFont("Optima-BoldItalic-30.vlw");
  bodyFont = loadFont("AlNile-20.vlw");
  headerFont = loadFont("AlBayan-Bold-40.vlw");
  planeIcon = loadImage ("IMG_PLANE_ICON.jpeg");
  widgetForward=new Widget(610, 470, 80, 20, "Next", color(120), bodyFont, EVENT_FORWARD);
  widgetBackward=new Widget(20, 470, 80, 20, "Back", color(120), bodyFont, EVENT_BACKWARD);
  widgetCanceled=new Widget(110, SCREENY-30, 80, 20, "Canceled", color(120), bodyFont, EVENT_CANCELED);
  widgetDelayed=new Widget(SCREENX-180, SCREENY-30, 80, 20, "Delayed", color(120), bodyFont, EVENT_DELAYED);
  widgetLeftNormal=new Widget(110, SCREENY-30, 80, 20, "All flights", color(120), bodyFont, EVENT_NORMAL);
  widgetRightNormal=new Widget(SCREENX-180, SCREENY-30, 80, 20, "All flights", color(120), bodyFont, EVENT_NORMAL);
  Screens= new ArrayList();
  CanceledScreens= new ArrayList();
  DelayedScreens= new ArrayList();
  currentScreenNumber = 0;
  canceledScreenNumber = 0;
  delayedScreenNumber = 0;
  index = 0;
  cancelIndex = 0;
  delayIndex = 0;
  canceled = false;
  delayed = false;
  Screens.add (new Screen (0));
  currentScreen = (Screen) Screens.get(currentScreenNumber);
}

void draw(){
  if (currentScreen.index>=FLIGHTS_PER_SCREEN) currentScreen.add(widgetBackward);
  if (currentScreen.index+FLIGHTS_PER_SCREEN<=boardTable.getRowCount()) currentScreen.add(widgetForward);
  if (!canceled)currentScreen.add(widgetCanceled);
  else currentScreen.add(widgetLeftNormal);
  if (!delayed) currentScreen.add(widgetDelayed);
  else currentScreen.add(widgetRightNormal);
  currentScreen.draw();
}

void mousePressed(){
  switch(currentScreen.getEvent(mouseX, mouseY)) {
    case EVENT_FORWARD:
    if (canceled){
      canceledScreenNumber++;
      if (canceledScreenNumber>=CanceledScreens.size()){
        //cancelIndex=cancelIndex+FLIGHTS_PER_SCREEN;
        CanceledScreens.add (new Screen (cancelIndex));
      }
      currentScreen = (Screen) CanceledScreens.get(canceledScreenNumber);
      println("CANCELED"+ canceledScreenNumber);
    }
    else if (delayed){
      delayedScreenNumber++;
      if (delayedScreenNumber>=DelayedScreens.size()){
        //delayIndex=delayIndex+FLIGHTS_PER_SCREEN;
        DelayedScreens.add (new Screen (delayIndex));
      }
      currentScreen = (Screen) DelayedScreens.get(delayedScreenNumber);
      println("DELAYED"+ delayedScreenNumber);
    }
    else{
      currentScreenNumber++;
      if (currentScreenNumber>=Screens.size()){
        index=index+FLIGHTS_PER_SCREEN;
        Screens.add (new Screen (index));
      }
      currentScreen = (Screen) Screens.get(currentScreenNumber);
      println("forward"+ currentScreenNumber);
    }
    break;
    case EVENT_BACKWARD:
    if (canceled){
      canceledScreenNumber--;
      currentScreen = (Screen) CanceledScreens.get(canceledScreenNumber);
      println("CANCELED"+ canceledScreenNumber);
    }
    else if(delayed){
      delayedScreenNumber--;
      currentScreen = (Screen) DelayedScreens.get(delayedScreenNumber);
      println("DELAYED"+ delayedScreenNumber);
    }
    else{
      currentScreenNumber--;
      currentScreen = (Screen) Screens.get(currentScreenNumber);
      println("backward"+ currentScreenNumber);
    }
    break;
    case EVENT_CANCELED:
    canceled = true;
    delayed = false;
    if (canceledScreenNumber>=CanceledScreens.size()){
      CanceledScreens.add (new Screen (cancelIndex));
    }
    currentScreen = (Screen) CanceledScreens.get(canceledScreenNumber);
    println("CANCELED"+ canceledScreenNumber);
    break;
    case EVENT_DELAYED:
    delayed = true;
    canceled = false;
    if (delayedScreenNumber>=DelayedScreens.size()){
      DelayedScreens.add (new Screen (delayIndex));
    }
    currentScreen = (Screen) DelayedScreens.get(delayedScreenNumber);
    println("DELAYED"+ delayedScreenNumber);
    break;
    case EVENT_NORMAL:
    delayed = false;
    canceled = false;
    currentScreen = (Screen) Screens.get(currentScreenNumber);
    break;
  }
}
