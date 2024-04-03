class TreeChart {
  int[] emissions = {12, 24, 32, 48, 60, 72}; // CO2 emissions in tonnes
  int[] trees = {2, 4, 5, 7, 9, 11}; // Number of trees needed to offset emissions  

  void setup() {
    background(255);
  }

  void draw() {
    // Draw axes
    stroke(0);
    line(100, height - 100, width - 100, height - 100); // x-axis
    line(100, 100, 100, height - 100); // y-axis
    
    // Draw bars with images
    float barWidth = (width - 200) / (float)emissions.length;
    for (int i = 0; i < emissions.length; i++) {
      float x = map(i, 0, emissions.length - 1, 150, width - 100 - barWidth / 2);
      float y = map(trees[i], 2, 11, height - 100, 100); // Adjusted mapping for y-axis
      float imageWidth = barWidth * 0.8; // Scale the image width
      float imageHeight = map(trees[i], 2, 11, 20, height - 200); // Adjusted mapping for image height
      image(treeImage, x, y, imageWidth, imageHeight); // Draw image for trees
      
      // Display the number of trees on the side
      textAlign(RIGHT, CENTER); // Set alignment to RIGHT
      fill(0);
      text(trees[i], 140, y); // Adjusted x-coordinate
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
    text("Number of Trees Needed to Offset emissions", -height / 2 - 100, 50); // Adjusted position for the title
  }
}
