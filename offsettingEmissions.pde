boolean buttonClicked = false;
String[] sentences = {
  "Reduce, reuse, recycle.",
  "Avoid buying fast fashion, instead opt\n for vintage and recycled clothing.",
  "Switch lights off and unplug your electeonic\n devices when not in use.",
  "Sign up to get your electricity from clean energy \nthrough your local utility or a certified renewable\n energy provider.",
  "Drive less, walk more.",
  "Fly nonstop since landings and takeoffs use\n more fuel and produce more emissions.",
  "Vote to let your representatives know you want the to \nphase out fossil fuels to decarbonise the earth.",
  "  Turn your water heater down to 120˚F.\n This can save about 550 pounds of CO2 a year.",
  "Support and buy from companies that are\n environmentally responsible.",
  "Try a Meatless Monday, reducing your consumption\n of meat reduces your carbon emissions."
};
String randomSentence; // Declare a global variable to store the random sentence
PImage natureBackground;

void setup() {
  size(800, 600);
  natureBackground = loadImage("natureBackground5.jpg");
}

void draw() {
  background(255);
  image(natureBackground, 0, 0, 800, 600);
  fill(0);
  textSize(20);
  text("Click for a method to offset your carbon emissions!", 200, 220);
  fill(#14C11A);
  ellipse(width/2, height/2, 100, 100);
  
  if (buttonClicked) {
    fill(0);
    textSize(30);
    float textWidth = textWidth(randomSentence); // Calculate the width of the text
    text(randomSentence, (width - textWidth) / 2, 400); // Center the text horizontally
  }
}

void mousePressed() {
  if (dist(mouseX, mouseY, width/2, height/2) < 50) {
    // toggle the buttonClicked flag every time the button is clicked
    buttonClicked = !buttonClicked;
    if (buttonClicked) {
      // If buttonClicked is true, select a random sentence
      randomSentence = getRandomSentence();
    }
  }
}

String getRandomSentence() {
  // generate a random index to select a sentence from the array
  int randomIndex = int(random(sentences.length));
  return sentences[randomIndex]; // Return the selected random sentence
}
