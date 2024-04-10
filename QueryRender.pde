//Lisa, Jamie and Orla
class QueryRender {

  float[] distanceRanges; // array w distance in miles
  float[] emissions; // array w corresponding CO2 emissions in tonnes
  int[] departureTimeCounts; // departure time counts
  float emission;
  String inputs[];

  QueryRender(float[] queryFlightEmissions, float[] emissions, int[] queryDepartureTimeCounts) {
    this.distanceRanges = queryFlightEmissions;
    this.emissions = emissions;
    this.departureTimeCounts = queryDepartureTimeCounts;
  }


  void drawBarChart() {
    int margin = 75; // margin around chart

    float chartWidth = width - 2 * margin;    // keeps chart off screen boundaries (x)
    float chartHeight = height - 2 * margin;  // ^^ (y)

    float barWidth = chartWidth / (distanceRanges.length - 1); // divide chart into bars
    float maxValue = max(emissions); // find max val in emissions array (to scale)
    float minValue = min(emissions);

    rect(75, 48, 0.5, 375);   // y axis

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
    textSize(20);
    text("Week", width / 2, height - 20);
    textSize(15);
    rotate(-HALF_PI);
    text("CO2  emissions (in tonnes)", -height / 2 - 15, 10);
    rotate(HALF_PI);
    text("0", 65, height - 75);
    text("1 \n Million", 45, height - 150);
    text("1.25 \n Million", 45, height - 250);
    text("1.5 \n Million", 45, height - 350);
    text("1.75 \n Million", 45, height - 450);
    text("2 \n Million", 45, height - 550);
    text("2.25 \n Million", 45, height - 650);
    text("2.5 \n Million", 45, height - 750);

    // draw x-axis values
    for (int i = 0; i < distanceRanges.length - 1; i++) {
      float x = margin + i * barWidth + barWidth / 2;
      textAlign(CENTER);    // text printed centre x axis of individual bar
      String label = "Week " + (i + 1);
      text(label, x, height - 55);
    }
  }



  void drawPieChart() {
    float totalFlights = departureTimeCounts[0] + departureTimeCounts[1] + departureTimeCounts[2];
    // Pie Chart Key
    textAlign(LEFT, TOP); //position the key for the pie chart in the top left corner
    fill(0); // make the text black
    textSize(14); // text size
    text("Late", 660, 20);
    text("Early", 660, 40);
    text("On Time", 660, 60);

    // Colored squares
    fill(250, 134, 221); // pink for late flights
    rect(765, 20, 15, 15);//position and size the squares
    fill(162, 41, 132); // purple for early flights
    rect(765, 40, 15, 15);
    fill(94, 8, 131);// light purple for on-time flights
    rect(765, 60, 15, 15);

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


  void drawTreeChart() {
    textSize(20);
    textAlign(CENTER, CENTER);
    text("Your flight emissions for your flight from " + inputs[0] + " to " + inputs[1] + " are " + emission + " tonnes. ", 400, 45);



    int[] emissions = {12, 24, 32, 48, 60, 72}; // CO2 emissions in tonnes
    int[] trees = {2, 4, 5, 7, 9, 11}; // Number of trees needed to offset emissions

    // Draw axes
    stroke(0);
    line(100, height - 100, width - 100, height - 100); // x-axis
    line(100, 100, 100, height - 100); // y-axis

    // Draw bars with images
    float barWidth = (width - 200) / (float)emissions.length;
    for (int i = 0; i < emissions.length; i++) {
      float x = map(i, 0, emissions.length - 1, 150, width - 100 - barWidth / 2);
      float y = map(trees[i], 2, 11, height - 120, 100); // Adjusted mapping for y-axis
      float imageWidth = barWidth * 0.8; // Scale the image width
      float imageHeight = map(trees[i], 2, 11, 20, height - 200); // Adjusted mapping for image height
      PImage treeImage;
      treeImage = loadImage("treeimage.png");
      image(treeImage, x, y, imageWidth, imageHeight); // Draw image for trees

      // Display the number of trees on the side
      textAlign(LEFT, CENTER); // Set alignment to RIGHT
      fill(0);
      text(trees[i], 80, y); // Adjusted x-coordinate
    }

    // Draw labels
    fill(0);
    textAlign(CENTER, CENTER);
    for (int i = 0; i < emissions.length; i++) {
      float x = map(i, 0, emissions.length - 1, 150, width - 100 - barWidth / 2);
      text(emissions[i] + " tonnes", x, height - 50);
    }

    // Draw titles
    textAlign(CENTER, CENTER);
    textSize(20);
    text("CO2 Emissions", width / 2, height - 20);
    rotate(-HALF_PI);
    textAlign(CENTER, CENTER);
    text("Number of Trees Needed to Offset emissions", -height / 2 - 15, 50); // Adjusted position for the title
  }
}
