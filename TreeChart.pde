
class TreeChart {
   
    PImage treeImage; 
    int[] C02emissions = {12, 24, 32, 48, 60, 72}; // CO2 emissions in tonnes
    int[] trees = {2, 4, 5, 7, 9, 11}; // Number of trees needed to offset emissions  
    TreeChart(PImage treeImage)
    {
        this.treeImage = treeImage;
     }
     
    void draw() {
        // Draw axes
        stroke(0); // Set stroke color to black
        line(100, height - 100, width - 100, height - 100);// Draw x-axis from (100, height - 100) to (width - 100, height - 100)
        line(100, 100, 100, height - 100);// Draw y-axis from (100, 100) to (100, height - 100)

        // Draw bars with images
        // Calculate the width of each bar
        float barWidth = (width - 200) / (float)C02emissions.length;
        for (int i = 0; i < C02emissions.length; i++) {
            float x = map(i, 0, C02emissions.length - 1, 150, width - 100 - barWidth / 2);// Map the index to x-coordinate within the canvas
            float y = map(trees[i], 0, 30, height - 100, 100);// Map the number of trees to y-coordinate within the canvas
            float imageWidth = barWidth * 0.8;// Scale the image width for the bar
            float imageHeight = map(trees[i], 0, 30, 20, height - 200);// Scale the image height for the bar
            image(treeImage, x, height - 100 - imageHeight, imageWidth, imageHeight);
            
            // Display the number of trees on the side
            textAlign(RIGHT, CENTER); // Align text to the right
            fill(0); // Set fill color to black
            text(trees[i] + " billion", 120, y); // Draw the number of trees

        }

        // Draw labels
        fill(0); // Set fill color to black
        textAlign(CENTER, CENTER); // Align text to the center
        for (int i = 0; i < C02emissions.length; i++) {
            // Map the index to x-coordinate within the canvas
            float x = map(i, 0, C02emissions.length - 1, 150, width - 100 - barWidth / 2);
            // Draw the label for CO2 emissions at (x, height - 50)
            text(C02emissions[i] + " tonnes", x, height - 50);
        }

        // Draw titles
        textAlign(CENTER, CENTER); // Align text to the center
        textSize(20); // Set text size to 20
        text("CO2 Emissions", width / 2, height - 20);  // x-axis - width/2 to put at horizontal centre
        rotate(-HALF_PI); // Rotate text by -90 degrees to make y axis text vertical
        text("Number of Trees Needed to Offset", -height / 2 - 100, 50); // y-axis
    }
}
