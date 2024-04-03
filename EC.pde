PImage treeImage; // Image for representing trees
TreeChart treeChart;

void setup() {
  size(800, 600);
  treeImage = loadImage("treeimage.png"); // Load image for trees
  
  
  treeChart = new TreeChart();
 
}

void draw() {
   treeChart.draw();
}
