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
  
  rect(49, 45, 1, 505);   // y axis
  
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
  textSize(14);
  text("Flight Distance (in miles)", width / 2, height - 20);
  text("CO2 emissions", margin + 10, height - 590);
  text("(in tonnes)", margin + 10, height - 575);
  text("0", 40, height - 50);
  text("12", 40, height - 130);
  text("24", 40, height - 210);
  text("32", 40, height - 290);
  text("48", 40, height - 380);
  text("60", 40, height - 470);
  text("72", 40, height - 555);
  
  // draw x-axis values
  for (int i = 0; i < distanceRanges.length - 1; i++) {
    float x = margin + i * barWidth + barWidth / 2;
    textAlign(CENTER);    // text printed centre x axis of individual bar
    String label = "(" + distanceRanges[i] + "-" + distanceRanges[i+1] + ")";
    text(label, x, height - 35);
  }
}
}
