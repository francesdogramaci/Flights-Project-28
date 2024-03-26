// Frances
import controlP5.*;

public class Dropdown {
  ControlP5 cp5;

  public Dropdown(ControlP5 cp5) {
    this.cp5 = cp5;
    cp5.addDropdownList("Data Options")
      .setPosition(350, 150)
      .setSize(100, 100)
      .addItem("Barchart", 0)
      .addItem("Table", 1)
      .addItem("Map", 2);
    cp5.setColorBackground(color(120, 0, 70));
    cp5.setColorForeground(color(255, 182, 193));
  }

  public void controlEvent(ControlEvent event) {
    if (event.isGroup() && event.getController().getName().equals("dropdown")) {
      int selected = (int) event.getValue();
      String selectedOption = "";
      switch(selected) {
      case 0:
        selectedOption = "Barchart";
        break;
      case 1:
        selectedOption = "Table";
        break;
      case 2:
        selectedOption = "Map";
        break;
      }
      System.out.println("Selected option: " + selectedOption);
    }
  }
}
