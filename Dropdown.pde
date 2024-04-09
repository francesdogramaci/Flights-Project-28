public class Dropdown {
  ControlP5 cp5;
  DropdownList dropdownList;

  public Dropdown(ControlP5 cp5) {
    this.cp5 = cp5;
     dropdownList = cp5.addDropdownList("Data Options")
      .setPosition(350, 150)
      .setSize(100, 100)
      .addItem("Barchart", 0)
      .addItem("Table", 1)
      .addItem("Piechart", 2);
    cp5.setColorBackground(color(120, 0, 70));
    cp5.setColorForeground(color(255, 182, 193));

  }

  public void setVisible(boolean visible) {
    dropdownList.setVisible(visible);
  }
  
  public void controlEvent(ControlEvent event) {
    if(currentScreen == screenMain){
    if (event.isGroup() && event.getController().getName().equals("dropdown")) {
      int selected = (int) event.getValue();
      selectedOption = (int) event.getValue();
      String selectedOption = "";
      switch(selected) {
      case 0:
        selectedOption = "Barchart";
        currentScreen = screenBar;
        println("Switching to screen2");
        break;
      case 1:
        selectedOption = "Table";
        break;
      case 2:
        selectedOption = "Piechart";
        break;
      }
      System.out.println("Selected option: " + selectedOption);
      if (selectedOption.equals("Barchart")) { // Remove the semicolon here
        currentScreen = screenBar;
      }
    
  }
 

    }
}
}
