Table table;
PImage backgroundImage;
PImage barChartImage;
int x;
int y;
int a;
int b;

final int SCREENX = 800;
final int SCREENY = 600;

void settings()
{
  size(SCREENX, SCREENY);
}
void setup() {
  table = loadTable("flights_full.csv", "header");
  
  println(table.getRowCount() + " total rows in table");
  println(table.getColumnCount() + " total colums in table");
  
  backgroundImage = loadImage("plane.jpg");
  barChartImage = loadImage("barChart.jpeg");
   
   x=50;
   y=20;
   a=10;
   b=510;
}
void draw()
{
  background(120,0,70);
  image(backgroundImage, 0, 0, 800, 600);
  
  //creating a moving title screen
  noStroke(); fill(0);
  rect(x, y, 200, 50);
  
  fill(255, 190, 250);
  textAlign(CENTER, CENTER);
  text("What is your flights CO2 Emissions?", x+100, y+25); //adjust co ords to centre text
  textSize(13);
  if(x++>=800) x=-400;
  
  image(barChartImage, 50, 400, 100, 100);
  fill(250);
  textAlign(20, 400);
  text("Click to view Emissions bar chart", a+10, b+2);
  textSize(10);
}
