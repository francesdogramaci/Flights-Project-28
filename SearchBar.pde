class SearchBar {
  String inputText = "";
  String inputText2 = "";
  boolean isFocused = false;
  boolean isFocused2 = false;
  int posX, posY, boxWidth, boxHeight;
  FlightData flightData;
  String[] inputs;
  boolean enterPressed = false;
  boolean enterPressedTwice = false;
  int posX2;

  SearchBar(int x, int y, int width, int height, FlightData flightData) {
    posX = x;
    posY = y;
    boxWidth = width;
    boxHeight = height;
    this.flightData = flightData;
    inputs = new String[2];
    posX2 = x + 500; // Setting the x-coordinate of the second box
  }

  void mousePressed(int mx, int my) {
    // first box boundaries
    if (mx > posX && mx < posX + boxWidth && my > posY && my < posY + boxHeight) {
      isFocused = true; // Set focus to the first search box
      isFocused2 = false; // Ensure the second search box doesn't have focus
    }
    // second box boundaries
    else if (mx > posX2 && mx < posX2 + boxWidth && my > posY && my < posY + boxHeight) {
      isFocused2 = true; // Set focus to the second search box
      isFocused = false; // Ensure the first search box doesn't have focus
    }
    // outside both
    else {
      isFocused = false; // Neither search box has focus
      isFocused2 = false; // Neither search box has focus
    }
  }


  void draw(int strokeColor, int fillColor, int textColor, int cursorColor) {
    // Draw the textbox
    textColor = 0;
    fillColor = color(255, 182, 193);
    cursorColor = color(120, 0, 70);

    stroke(strokeColor);
    fill(fillColor);
    rect(posX, posY, boxWidth, boxHeight);

    // Display the text inside the textbox
    textAlign(LEFT, CENTER);
    fill(textColor);
    text(inputText, posX + 5, posY + boxHeight/2);

    // Draw cursor if the textbox is focused
    if (isFocused && frameCount % 60 < 30) {
      float cursorX = posX + textWidth(inputText) + 5;
      stroke(cursorColor);
      line(cursorX, posY + 5, cursorX, posY + boxHeight - 5);
    }
  }

  void keyPressed(char key, int keyCode) {
    if (isFocused) {
      if (keyCode == BACKSPACE && inputText.length() > 0) {
        inputText = inputText.substring(0, inputText.length() - 1);
      } else if (keyCode != ENTER && keyCode != RETURN && keyCode != TAB && keyCode != DELETE && keyCode != SHIFT) {
        inputText += key;
      } else if (keyCode == ENTER) {
        inputs[0] = inputText; // Check if both inputs are ready and send data
        checkAndSendData();
      }
    }

    if (isFocused2) {
      if (keyCode == BACKSPACE && inputText2.length() > 0) {
        inputText2 = inputText2.substring(0, inputText2.length() - 1);
      } else if (keyCode != ENTER && keyCode != RETURN && keyCode != TAB && keyCode != DELETE && keyCode != SHIFT) {
        inputText2 += key;
      } else if (keyCode == ENTER) {
        inputs[1] = inputText2;
        checkAndSendData();
      }
    }
  }

  String[] checkAndSendData() {
    // Check if both inputs are ready
    if (inputs[0] != null && inputs[1] != null) {
      // Both inputs are ready, so return the inputs array
      println(inputs[0] + inputs[1]);
      return inputs;
    }
    return inputs;
  }
}
