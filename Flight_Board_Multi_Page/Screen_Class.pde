class Screen {
  ArrayList screenWidgets;
  color screenColor = 255;
  int index;
  Screen(int index){
    screenWidgets=new ArrayList();
    this.index = index;
  }
  void add(Widget w){
    screenWidgets.add(w);
  }
  
  void draw(){
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
    int j=0;
    if (boardTable!=null){
      if(canceled){
        for (int i=index; j<FLIGHTS_PER_SCREEN; i++){
          fill(255, 0, 0);
          if (i<=boardTable.getRowCount()){
            if (boardTable.getFloat(i, 15)==1){
              text (boardTable.getString(i, 0), FIRST_COLUMN_LOCATION, FIRST_ROW_LOCATION+(j*DISTANCE_BETWEEN_ROWS));
              text (boardTable.getString(i, 4), FIRST_COLUMN_LOCATION + (DISTANCE_BETWEEN_COLUMNS), FIRST_ROW_LOCATION+(j*DISTANCE_BETWEEN_ROWS));
              text (boardTable.getString(i, 8), FIRST_COLUMN_LOCATION + (DISTANCE_BETWEEN_COLUMNS*2), FIRST_ROW_LOCATION+(j*DISTANCE_BETWEEN_ROWS));
              j++;
            }
          }
          else break;
          cancelIndex=i++;
        }
      }
      else if(delayed){
        for (int i=index; j<FLIGHTS_PER_SCREEN; i++){
          fill(255, 125, 0);
          if (i<=boardTable.getRowCount()){
            if (boardTable.getFloat(i, 16)==1){
              text (boardTable.getString(i, 0), FIRST_COLUMN_LOCATION, FIRST_ROW_LOCATION+(j*DISTANCE_BETWEEN_ROWS));
              text (boardTable.getString(i, 4), FIRST_COLUMN_LOCATION + (DISTANCE_BETWEEN_COLUMNS), FIRST_ROW_LOCATION+(j*DISTANCE_BETWEEN_ROWS));
              text (boardTable.getString(i, 8), FIRST_COLUMN_LOCATION + (DISTANCE_BETWEEN_COLUMNS*2), FIRST_ROW_LOCATION+(j*DISTANCE_BETWEEN_ROWS));
              j++;
            }
          }
          else break;
          delayIndex=i++;
        } 
      }
      else {
        for (int i=index; i<index+FLIGHTS_PER_SCREEN; i++){
          if (boardTable.getFloat(i, 15)==1) fill(255, 0, 0);
          else if (boardTable.getFloat(i, 16)==1) fill(255, 125, 0);
          else fill(0);
          if (i<=boardTable.getRowCount()){
            text (boardTable.getString(i, 0), FIRST_COLUMN_LOCATION, FIRST_ROW_LOCATION+(j*DISTANCE_BETWEEN_ROWS));
            text (boardTable.getString(i, 4), FIRST_COLUMN_LOCATION + (DISTANCE_BETWEEN_COLUMNS), FIRST_ROW_LOCATION+(j*DISTANCE_BETWEEN_ROWS));
            text (boardTable.getString(i, 8), FIRST_COLUMN_LOCATION + (DISTANCE_BETWEEN_COLUMNS*2), FIRST_ROW_LOCATION+(j*DISTANCE_BETWEEN_ROWS));
            j++;
          }
          else break;
        }
      }
    }
    for(int i = 0; i<screenWidgets.size(); i++){
      Widget aWidget = (Widget)screenWidgets.get(i);
      aWidget.draw();
    }
  }
  int getEvent(int mx, int my){
    for(int i = 0; i<screenWidgets.size(); i++){
      Widget aWidget = (Widget) screenWidgets.get(i);
      int event = aWidget.getEvent(mouseX,mouseY);
      if(event != EVENT_NULL){
        return event;
      }
    }
    return EVENT_NULL;
  }
  ArrayList getWidgets(){
    return screenWidgets;
  }
}
