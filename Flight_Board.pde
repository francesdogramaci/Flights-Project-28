Table table;
PImage plane;
final int DISTANCE_BETWEEN_ROWS = 25;
final int TITLE_LOCATION = 30;
final int HEADER_LOCATION = TITLE_LOCATION+50;
final int FIRST_ROW_LOCATION = HEADER_LOCATION+DISTANCE_BETWEEN_ROWS;
final int DISTANCE_BETWEEN_COLUMNS = 200;
final int FIRST_COLUMN_LOCATION = 50;
PFont titleFont;
PFont headerFont;
PFont bodyFont;

void setup(){
  size (700, 500);
  table = loadTable("flights_full.csv", "header");
  textAlign(LEFT, CENTER);
  titleFont = loadFont("Optima-BoldItalic-30.vlw");
  bodyFont = loadFont("AlNile-20.vlw");
  headerFont = loadFont("AlBayan-Bold-40.vlw");
  plane = loadImage ("IMG_PLANE.jpeg");
}

void draw(){
  background(255);
  image(plane, FIRST_COLUMN_LOCATION, TITLE_LOCATION - (plane.height/2));
  fill(0);
  textFont(titleFont, 30);
  text ("departures", FIRST_COLUMN_LOCATION+DISTANCE_BETWEEN_COLUMNS, TITLE_LOCATION);
  textFont(titleFont, 20);
  text (hour() +":"+ minute(), FIRST_COLUMN_LOCATION+(DISTANCE_BETWEEN_COLUMNS*2), TITLE_LOCATION);
  textFont(headerFont, 15);
  text (("DATE/TIME"), FIRST_COLUMN_LOCATION, HEADER_LOCATION);
  text (("CITY ORIGIN"), FIRST_COLUMN_LOCATION+DISTANCE_BETWEEN_COLUMNS, HEADER_LOCATION);
  text (("CITY DESTINATION"), FIRST_COLUMN_LOCATION+(DISTANCE_BETWEEN_COLUMNS*2), HEADER_LOCATION);
  textFont(bodyFont, 15);
  for (int i=0; i<15; i++){
    if (table.getFloat(i, 15)==1) fill(255, 0, 0);
    else if (table.getFloat(i, 16)==1) fill(255, 125, 0);
    else fill(0);
    text (table.getString(i, 0), FIRST_COLUMN_LOCATION, FIRST_ROW_LOCATION+(i*DISTANCE_BETWEEN_ROWS));
    text (table.getString(i, 4), FIRST_COLUMN_LOCATION + (DISTANCE_BETWEEN_COLUMNS), FIRST_ROW_LOCATION+(i*DISTANCE_BETWEEN_ROWS));
    text (table.getString(i, 8), FIRST_COLUMN_LOCATION + (DISTANCE_BETWEEN_COLUMNS*2), FIRST_ROW_LOCATION+(i*DISTANCE_BETWEEN_ROWS));
  }
}
