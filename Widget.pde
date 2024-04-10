//aimee
class Widget{
int x, y, width, height;
String label;  //widget label
int event;
color widgetColor, labelColor, lineColor; //colors for widget
PFont widgetFont;

 //constructor
Widget(int x,int y, int width, int height, String label, color widgetColor, PFont widgetFont, int event){
  this.x=x;
  this.y=y;
  this.width = width;
  this.height= height;
  this.label=label;
  this.event=event;
  this.widgetColor=widgetColor;
  this.widgetFont=widgetFont;
  labelColor= color(0);
  lineColor= color(0);
   }
 
  void draw(){
  fill(widgetColor);
  stroke(lineColor);
  rect(x,y,width,height);
  fill(labelColor);
  textSize(15);
  textAlign(CENTER, CENTER);
  text(label, x+width/2, y+height/2); //drawing label
  }
 
  //changes line colour if mouse is over widget
void mouseOver() {
  lineColor = color(255);
}
void mouseNotOver() {
lineColor = color(0);
}

//getting event based on mouse position
int getEvent(int mX, int mY){
if(mX>x && mX < x+width && mY >y && mY <y+height){ //if mouse is over widget
        return event;
     }
     return EVENT_NULL;
  }
}
