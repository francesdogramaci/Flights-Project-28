// frances
class SearchBar {
  String inputText = "";
  String inputText2 = "";
  boolean isFocused2 = false;
  boolean isFocused = false;
  int posX, posY, boxWidth, boxHeight;
 
  SearchBar(int x, int y, int width, int height) {
    posX = x;
    posY = y;
    boxWidth = width;
    boxHeight = height;
  }

 void mousePressed(int mx, int my) {
    if (mx > posX && mx < posX + boxWidth && my > posY && my < posY + boxHeight) {
    isFocused = true;
      if (mx >= 500 && my <= 250){
      isFocused2 = true;
      }
    } else {
      isFocused = false;
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
  if (isFocused2) {
    if (keyCode == BACKSPACE && inputText2.length() > 0) {
      inputText2 = inputText2.substring(0, inputText2.length() - 1);
    } else if (keyCode != ENTER && keyCode != RETURN && keyCode != TAB && keyCode != DELETE && keyCode != SHIFT) {
      inputText2 += key;
    }
    println(inputText2);
  }
 
  if (isFocused) {
    if (keyCode == BACKSPACE && inputText.length() > 0) {
      inputText = inputText.substring(0, inputText.length() - 1);
    } else if (keyCode != ENTER && keyCode != RETURN && keyCode != TAB && keyCode != DELETE && keyCode != SHIFT) {
      inputText += key;
    }
    println(inputText);
  }
}
}
