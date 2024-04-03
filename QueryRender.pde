class QueryRender {

  float[] distanceRanges; // array w distance in miles
  float[] emissions; // array w corresponding CO2 emissions in tonnes
  int[] departureTimeCounts; // departure time counts

  QueryRender(float[] queryFlightEmissions, float[] emissions, int[] queryDepartureTimeCounts) {
    this.distanceRanges = queryFlightEmissions;
    this.emissions = emissions;
    this.departureTimeCounts = queryDepartureTimeCounts;
  }


  void drawBarChart() {
    int margin = 50; // margin around chart

    float chartWidth = width - 2 * margin;    // keeps chart off screen boundaries (x)
    float chartHeight = height - 2 * margin;  // ^^ (y)

    float barWidth = chartWidth / (distanceRanges.length - 1); // divide chart into bars
    float maxValue = max(emissions); // find max val in emissions array (to scale)
    float minValue = min(emissions);

    rect(49, 45, 1, 305);   // y axis

    // draw bars
    for (int i = 0; i < distanceRanges.length - 1; i++) {
      float x = margin + i * barWidth;   // calcs x coord of currenr bar
      float y = map(emissions[i], 0, maxValue, height - margin, margin);  // prop bars
      fill(255, 182, 193);//(255, 150, 200); // pink <3
      rect(x, y, barWidth, height - margin - y);
    }

    // draw axes labels
    fill(0);
    textAlign(CENTER, CENTER);
    textSize(15);
    text("Week", width / 2, height - 20);
    text("Total CO2 emissions", margin + 10, height - 780);
    text("(in tonnes)", margin + 10, height - 765);
    text("0", 30, height - 50);
    text("1 Million", 30, height - 150);
    text("1.25 Million", 25, height - 250);
    text("1.5 Million", 25, height - 350);
    text("1.75 Million", 25, height - 450);
    text("2 Million", 25, height - 550);
    text("2.25 Million", 25, height - 650);
    text("2.5 Million", 25, height - 750);

    // draw x-axis values
    for (int i = 0; i < distanceRanges.length - 1; i++) {
      float x = margin + i * barWidth + barWidth / 2;
      textAlign(CENTER);    // text printed centre x axis of individual bar
      String label = "Week " + (i + 1);
      text(label, x, height - 35);
    }
  }



  void drawPieChart() {
    float totalFlights = departureTimeCounts[0] + departureTimeCounts[1] + departureTimeCounts[2];
    // Pie Chart Key
    textAlign(LEFT, TOP); //position the key for the pie chart in the top left corner
    fill(0); // make the text black
    textSize(14); // text size
    text("Late", 20, 20);
    text("Early", 20, 40);
    text("On Time", 20, 60);

    // Colored squares
    fill(250, 134, 221); // pink for late flights
    rect(120, 20, 15, 15);//position and size the squares
    fill(162, 41, 132); // purple for early flights
    rect(120, 40, 15, 15);
    fill(94, 8, 131);// light purple for on-time flights
    rect(120, 60, 15, 15);
    
    // Calculate the proportions of each count relative to the total
    float lateProportion = departureTimeCounts[2] / totalFlights;
    float earlyProportion = departureTimeCounts[1] / totalFlights;
    //float onTimeProportion = departureTimeCounts[0] / totalFlights;
    // Calculate the angles for each segment based on their proportions
    // 0 = mininmum value of the input range, 1= maximum vakue of the input range, 0= minimum value of the output range
    float lateAngle = map(lateProportion, 0, 1, 0, TWO_PI); // 1 is the max size of the angle when in radians
    float earlyAngle = map(earlyProportion, 0, 1, 0, TWO_PI); // two pie represents a full circle
    //float onTimeAngle = map(onTimeProportion, 0, 1, 0, TWO_PI);
    // map function take any number and scale it to a new number (using our data)
    arc(width / 2, height / 2, 300, 300, 0, lateAngle); // starts at 0 ends at the end of late angle

    fill(162, 41, 132); // Draw the early flights section (purple)
    arc(width / 2, height / 2, 300, 300, lateAngle, lateAngle + earlyAngle); // starts at the end of late angle, ends at late angle + early angle( end of early angle)

    fill(94, 8, 131); // Draw the on-time flights section (light purple)
    arc(width / 2, height / 2, 300, 300, lateAngle + earlyAngle, TWO_PI);
    
    fill(250, 134, 221); // Draw the late flights section (pink)
    arc(width / 2, height / 2, 300, 300, 0, lateAngle); // starts at 0 ends at the end of late angle
  }



  void drawDepBoard() {
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

    textAlign(LEFT, CENTER);
    titleFont = loadFont("Optima-BoldItalic-30.vlw");
    bodyFont = loadFont("AlNile-20.vlw");
    headerFont = loadFont("AlBayan-Bold-40.vlw");
    plane = loadImage ("IMG_PLANE_ICON.jpeg");

    image(plane, FIRST_COLUMN_LOCATION, TITLE_LOCATION - (plane.height/2));
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
    for (int i=0; i<15; i++) {
      if (table.getFloat(i, 15)==1) fill(255, 0, 0);
      else if (table.getFloat(i, 16)==1) fill(255, 125, 0);
      else fill(0);
      text (table.getString(i, 0), FIRST_COLUMN_LOCATION, FIRST_ROW_LOCATION+(i*DISTANCE_BETWEEN_ROWS));
      text (table.getString(i, 4), FIRST_COLUMN_LOCATION + (DISTANCE_BETWEEN_COLUMNS), FIRST_ROW_LOCATION+(i*DISTANCE_BETWEEN_ROWS));
      text (table.getString(i, 8), FIRST_COLUMN_LOCATION + (DISTANCE_BETWEEN_COLUMNS*2), FIRST_ROW_LOCATION+(i*DISTANCE_BETWEEN_ROWS));
    }
  }
}
