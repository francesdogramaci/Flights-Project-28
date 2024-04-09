//Amelie Bice
public class FlightBoard {
  Table boardTable;
  PImage planeIcon;
  PFont titleFont, headerFont, bodyFont;
  private Widget widgetForward, widgetBackward, widgetCanceled, widgetDelayed, widgetRightNormal, widgetLeftNormal, mainScreen;
  final int EVENT_NULL = 0;
  private final int EVENT_FORWARD = 12;
  private final int EVENT_BACKWARD = 13;
  private final int EVENT_CANCELED = 14;
  private final int EVENT_DELAYED = 15;
  private final int EVENT_NORMAL = 16;
  private final int EVENT_MAIN_SCREEN = 4;
  private ArrayList<BoardScreen> boardScreens, canceledScreens, delayedScreens;
  private BoardScreen currentBoardScreen;
  private final int FLIGHTS_PER_SCREEN = 18;
  private int currentScreenNumber, canceledScreenNumber, delayedScreenNumber;
  int index, cancelIndex, delayIndex;
  boolean canceled, delayed;
  private static final int SCREENX = 800;
  private static final int SCREENY = 600;

  FlightBoard(Table table) {
    this.boardTable = table;
  }

  void setup() {
    // Text setup
    textAlign(LEFT, CENTER);
    titleFont = loadFont("Optima-BoldItalic-30.vlw");
    bodyFont = loadFont("AlNile-20.vlw");
    headerFont = loadFont("Optima-BoldItalic-30.vlw");
    planeIcon = loadImage ("IMG_PLANE_ICON.jpeg");
    
    // Screens and widgets
    mainScreen = new Widget((SCREENX/2)-50, SCREENY-30, 100, 20, "Main Screen", color(120), bodyFont, EVENT_MAIN_SCREEN);
    widgetForward=new Widget(SCREENX-90, SCREENY-30, 80, 20, "Next", color(120), bodyFont, EVENT_FORWARD);
    widgetBackward=new Widget(20, SCREENY-30, 80, 20, "Back", color(120), bodyFont, EVENT_BACKWARD);
    widgetCanceled=new Widget(110, SCREENY-30, 80, 20, "Canceled", color(120), bodyFont, EVENT_CANCELED);
    widgetDelayed=new Widget(SCREENX-180, SCREENY-30, 80, 20, "Delayed", color(120), bodyFont, EVENT_DELAYED);
    widgetLeftNormal=new Widget(110, SCREENY-30, 80, 20, "All flights", color(120), bodyFont, EVENT_NORMAL);
    widgetRightNormal=new Widget(SCREENX-180, SCREENY-30, 80, 20, "All flights", color(120), bodyFont, EVENT_NORMAL);
    boardScreens= new ArrayList();
    canceledScreens= new ArrayList();
    delayedScreens= new ArrayList();
    currentScreenNumber = 0;
    canceledScreenNumber = 0;
    delayedScreenNumber = 0;
    index = 0;
    cancelIndex = 0;
    delayIndex = 0;
    canceled = false;
    delayed = false;
    boardScreens.add (new BoardScreen (0));
    currentBoardScreen = (BoardScreen) boardScreens.get(currentScreenNumber);
  }

  void draw(){
    if (currentBoardScreen.index>=FLIGHTS_PER_SCREEN) currentBoardScreen.add(widgetBackward);
    if (currentBoardScreen.index+FLIGHTS_PER_SCREEN<=boardTable.getRowCount()) currentBoardScreen.add(widgetForward);
    if (!canceled)currentBoardScreen.add(widgetCanceled);
    else currentBoardScreen.add(widgetLeftNormal);
    if (!delayed) currentBoardScreen.add(widgetDelayed);
    else currentBoardScreen.add(widgetRightNormal);
    currentBoardScreen.add(mainScreen);
    currentBoardScreen.draw();
  }

  void mousePressed() {
    switch(currentBoardScreen.getEvent(mouseX, mouseY)) {
    case EVENT_FORWARD:
      if (canceled) {
        canceledScreenNumber++;
        if (canceledScreenNumber>=canceledScreens.size()) {
          //cancelIndex=cancelIndex+FLIGHTS_PER_SCREEN;
          canceledScreens.add (new BoardScreen (cancelIndex));
        }
        currentBoardScreen = (BoardScreen) canceledScreens.get(canceledScreenNumber);
        println("CANCELED"+ canceledScreenNumber);
      } else if (delayed) {
        delayedScreenNumber++;
        if (delayedScreenNumber>=delayedScreens.size()) {
          //delayIndex=delayIndex+FLIGHTS_PER_SCREEN;
          delayedScreens.add (new BoardScreen (delayIndex));
        }
        currentBoardScreen = (BoardScreen) delayedScreens.get(delayedScreenNumber);
        println("DELAYED"+ delayedScreenNumber);
      } else {
        currentScreenNumber++;
        if (currentScreenNumber>=boardScreens.size()) {
          index=index+FLIGHTS_PER_SCREEN;
          boardScreens.add (new BoardScreen (index));
        }
        currentBoardScreen = (BoardScreen) boardScreens.get(currentScreenNumber);
        println("forward"+ currentScreenNumber);
      }
      break;
    case EVENT_BACKWARD:
      if (canceled) {
        canceledScreenNumber--;
        currentBoardScreen = (BoardScreen) canceledScreens.get(canceledScreenNumber);
        println("CANCELED"+ canceledScreenNumber);
      } else if (delayed) {
        delayedScreenNumber--;
        currentBoardScreen = (BoardScreen) delayedScreens.get(delayedScreenNumber);
        println("DELAYED"+ delayedScreenNumber);
      } else {
        currentScreenNumber--;
        currentBoardScreen = (BoardScreen) boardScreens.get(currentScreenNumber);
        println("backward"+ currentScreenNumber);
      }
      break;
    case EVENT_CANCELED:
      canceled = true;
      delayed = false;
      if (canceledScreenNumber>=canceledScreens.size()) {
        canceledScreens.add (new BoardScreen (cancelIndex));
      }
      currentBoardScreen = (BoardScreen) canceledScreens.get(canceledScreenNumber);
      println("CANCELED"+ canceledScreenNumber);
      break;
    case EVENT_DELAYED:
      delayed = true;
      canceled = false;
      if (delayedScreenNumber>=delayedScreens.size()) {
        delayedScreens.add (new BoardScreen (delayIndex));
      }
      currentBoardScreen = (BoardScreen) delayedScreens.get(delayedScreenNumber);
      println("DELAYED"+ delayedScreenNumber);
      break;
    case EVENT_NORMAL:
      delayed = false;
      canceled = false;
      currentBoardScreen = (BoardScreen) boardScreens.get(currentScreenNumber);
      break;
    case EVENT_MAIN_SCREEN:
      currentScreen=screenMain;
      break;
    }
  }


  class BoardScreen {
    private final int DISTANCE_BETWEEN_ROWS = 25;
    private final int TITLE_LOCATION = 30;
    private final int HEADER_LOCATION = TITLE_LOCATION+50;
    private final int FIRST_ROW_LOCATION = HEADER_LOCATION+DISTANCE_BETWEEN_ROWS;
    private final int DISTANCE_BETWEEN_COLUMNS = 250;
    private final int FIRST_COLUMN_LOCATION = 50;
    private ArrayList boardScreenWidgets;
    color screenColor = 255;
    int index;
    BoardScreen(int index) {
      boardScreenWidgets=new ArrayList();
      this.index = index;
    }
    void add(Widget w) {
      boardScreenWidgets.add(w);
    }

    void draw() {
      background(screenColor);
      image(planeIcon, FIRST_COLUMN_LOCATION, TITLE_LOCATION - (planeIcon.height/2));
      fill(0);
      textFont(titleFont, 30);
      text ("departures", FIRST_COLUMN_LOCATION+DISTANCE_BETWEEN_COLUMNS, TITLE_LOCATION);
      textFont(titleFont, 20);
      String minute = (minute()<10)? "0":"";
      text (hour() +":" +minute +minute(), FIRST_COLUMN_LOCATION+(DISTANCE_BETWEEN_COLUMNS*2), TITLE_LOCATION);
      textFont(headerFont, 15);
      text (("DATE/TIME"), FIRST_COLUMN_LOCATION, HEADER_LOCATION);
      text (("CITY ORIGIN"), FIRST_COLUMN_LOCATION+DISTANCE_BETWEEN_COLUMNS, HEADER_LOCATION);
      text (("CITY DESTINATION"), FIRST_COLUMN_LOCATION+(DISTANCE_BETWEEN_COLUMNS*2), HEADER_LOCATION);
      textFont(bodyFont, 15);
      int rowsOnPage=0;
      if (boardTable!=null) {
        if (canceled) {
          for (int i=index; rowsOnPage<FLIGHTS_PER_SCREEN; i++) {
            fill(255, 0, 0);
            if (i<=boardTable.getRowCount()) {
              if (boardTable.getFloat(i, 15)==1) {
                text (boardTable.getString(i, 0), FIRST_COLUMN_LOCATION, FIRST_ROW_LOCATION+(rowsOnPage*DISTANCE_BETWEEN_ROWS));
                text (boardTable.getString(i, 4), FIRST_COLUMN_LOCATION + (DISTANCE_BETWEEN_COLUMNS), FIRST_ROW_LOCATION+(rowsOnPage*DISTANCE_BETWEEN_ROWS));
                text (boardTable.getString(i, 8), FIRST_COLUMN_LOCATION + (DISTANCE_BETWEEN_COLUMNS*2), FIRST_ROW_LOCATION+(rowsOnPage*DISTANCE_BETWEEN_ROWS));
                rowsOnPage++;
              }
            } else break;
            cancelIndex=i++;
          }
        } else if (delayed) {
          for (int i=index; rowsOnPage<FLIGHTS_PER_SCREEN; i++) {
            fill(255, 125, 0);
            if (i<=boardTable.getRowCount()) {
              if (boardTable.getFloat(i, 16)==1) {
                text (boardTable.getString(i, 0), FIRST_COLUMN_LOCATION, FIRST_ROW_LOCATION+(rowsOnPage*DISTANCE_BETWEEN_ROWS));
                text (boardTable.getString(i, 4), FIRST_COLUMN_LOCATION + (DISTANCE_BETWEEN_COLUMNS), FIRST_ROW_LOCATION+(rowsOnPage*DISTANCE_BETWEEN_ROWS));
                text (boardTable.getString(i, 8), FIRST_COLUMN_LOCATION + (DISTANCE_BETWEEN_COLUMNS*2), FIRST_ROW_LOCATION+(rowsOnPage*DISTANCE_BETWEEN_ROWS));
                rowsOnPage++;
              }
            } else break;
            delayIndex=i++;
          }
        } else {
          for (int i=index; i<index+FLIGHTS_PER_SCREEN; i++) {
            if (boardTable.getFloat(i, 15)==1) fill(255, 0, 0);
            else if (boardTable.getFloat(i, 16)==1) fill(255, 125, 0);
            else fill(0);
            if (i<=boardTable.getRowCount()) {
              text (boardTable.getString(i, 0), FIRST_COLUMN_LOCATION, FIRST_ROW_LOCATION+(rowsOnPage*DISTANCE_BETWEEN_ROWS));
              text (boardTable.getString(i, 4), FIRST_COLUMN_LOCATION + (DISTANCE_BETWEEN_COLUMNS), FIRST_ROW_LOCATION+(rowsOnPage*DISTANCE_BETWEEN_ROWS));
              text (boardTable.getString(i, 8), FIRST_COLUMN_LOCATION + (DISTANCE_BETWEEN_COLUMNS*2), FIRST_ROW_LOCATION+(rowsOnPage*DISTANCE_BETWEEN_ROWS));
              rowsOnPage++;
            } else break;
          }
        }
      }
      for (int i = 0; i<boardScreenWidgets.size(); i++) {
        Widget aWidget = (Widget)boardScreenWidgets.get(i);
        aWidget.draw();
      }
    }
    int getEvent(int mx, int my) {
      for (int i = 0; i<boardScreenWidgets.size(); i++) {
        Widget aWidget = (Widget) boardScreenWidgets.get(i);
        int event = aWidget.getEvent(mouseX, mouseY);
        if (event != EVENT_NULL) {
          return event;
        }
      }
      return EVENT_NULL;
    }
    ArrayList getWidgets() {
      return boardScreenWidgets;
    }
  }
}
