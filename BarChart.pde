// orla

class BarChart {
  
int[] distanceRanges = {0, 500, 1000, 1500, 2000, 2500, 3000}; // array w distance in miles
float[] emissions = {12, 24, 36, 48, 60, 72}; // array w corresponding CO2 emissions in tonnes

int margin = 50; // margin around chart

void draw() {
  float chartWidth = width - 2 * margin;    // keeps chart off screen boundaries (x)
  float chartHeight = height - 2 * margin;  // ^^ (y)
  
  float barWidth = chartWidth / (distanceRanges.length - 1); // divide chart into bars
  float maxValue = max(emissions); // find max val in emissions array (to scale)
  
  rect(50, 50, 1, 500);   // y axis
  
  // draw bars
  for (int i = 0; i < distanceRanges.length - 1; i++) {
    float x = margin + i * barWidth;   // calcs x coord of currenr bar
    float y = map(emissions[i], 0, maxValue, height - margin, margin);  // prop bars
    fill(255, 150, 200); // pink <3
    rect(x, y, barWidth, height - margin - y);
  }
  
  // draw axes labels
  fill(0);
  textAlign(CENTER, CENTER);
  textSize(16);
  text("Flight Distance (in miles)", width / 2, height - 20);
  rotate(-HALF_PI);
  text("CO2  emissions (in tonnes)", -height / 2 - 15, 10);
  rotate(HALF_PI);
  textSize(14);
  text("0", 37, height - 50);
  text("12", 37, height - 135);
  text("24", 37, height - 218);
  text("32", 37, height - 301);
  text("48", 37, height - 384);
  text("60", 37, height - 467);
  text("72", 37, height - 550);
  
  // draw x-axis values
  for (int i = 0; i < distanceRanges.length - 1; i++) {
    float x = margin + i * barWidth + barWidth / 2;
    textAlign(CENTER);    // text printed centre x axis of individual bar
    String label = "(" + distanceRanges[i] + "-" + distanceRanges[i+1] + ")";
    text(label, x, height - 35);
  }
}
}
