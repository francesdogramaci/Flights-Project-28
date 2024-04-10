//aimee
class Screen {
  ArrayList<Widget> screenWidgets;
  color screenColor;
 
  //final int EVENT_NULL = 0;
 
  Screen(){
    screenWidgets = new ArrayList<Widget>(); //initialising the list
  }
  //method to add widgets to the screen
  void add(Widget w){
    screenWidgets.add(w);
  }
 
 
  void draw(){
    //looping through widgets and getting each widget, casting from object to widget
    for(int i = 0; i<screenWidgets.size(); i++){
      Widget aWidget = (Widget)screenWidgets.get(i);
      aWidget.draw();
    }  
  }
 
  int getEvent(int mx, int my){
 //looping through each element in the screenWidgets arrayList
    for(int i = 0; i<screenWidgets.size(); i++){
      //every iteration gets the widget at the index from the arrayList and casts it
      //from type object to type widget
      Widget aWidget = (Widget) screenWidgets.get(i);
      //calling the getEvent() method on the current widget and passing the mouse co ords through
      int event = aWidget.getEvent(mouseX,mouseY);
      //returns the event associated with the widget if mouse is in widget bounds
        if(event != EVENT_NULL){
          return event; //mouse is within bounds of widget
        }  
    }
   return EVENT_NULL;
   }
 //getting all widgets on the screen and returning list of widgets
ArrayList getWidgets() {
return screenWidgets;
}
}
