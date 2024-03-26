//jamie
class PieChart {
  int lateCount = 0; //initialise the counts
  int earlyCount = 0;
  int onTimeCount = 0;
  
  int[] scheduledDep;//create integer array to store the departure times
  int[] actualDep;
  
  PieChart(int[] scheduledDep, int[] actualDep)// pie chart takes two integer arrays as parameters
  {
    this.scheduledDep = scheduledDep; // assign to insatnce variables
    this.actualDep = actualDep;
  }

  void countFlights() //this method increments the flight count variables based on their departure times
  {
    for (int i = 0; i < table.getRowCount(); i++) //using the table defined in the main class
    {

    int actualDeparture = actualDep[i]; // get the actual departure time at index i
    int scheduledDeparture = scheduledDep[i]; //get the scheduled departure time at index i
    
    if ( actualDeparture > scheduledDeparture)
    {
        lateCount++; // increment lateCount if the actual departure is later than scheduled
    }
    
     if ( actualDeparture == scheduledDeparture)
    {
       onTimeCount++; // increment earlyCount if the actual departure is earlier than scheduled
    }
    
     if ( actualDeparture < scheduledDeparture)
    {
        earlyCount++; // increment onTimeCount if the actual departure is the same as scheduled
    }
    }// close for loop
  }

  void draw() {
    
    background(255);// set bakground to white

    float totalFlights = lateCount + earlyCount + onTimeCount;  // Calculate the total count of flights

    // Calculate the proportions of each count relative to the total
    float lateProportion = lateCount / totalFlights;
    float earlyProportion = earlyCount / totalFlights;
   // float onTimeProportion = onTimeCount / totalFlights;

    // Calculate the angles for each segment based on their proportions
    // 0 = mininmum value of the input range, 1= maximum vakue of the input range, 0= minimum value of the output range
    float lateAngle = map(lateProportion, 0, 1, 0, TWO_PI); // 1 is the max size of the angle when in radians
    float earlyAngle = map(earlyProportion, 0, 1, 0, TWO_PI); // two pie represents a full circle
    //float onTimeAngle = map(onTimeProportion, 0, 1, 0, TWO_PI);
  // map function take any number and scale it to a new number (using our data)
    
   drawPieChart(lateAngle, earlyAngle); // call on Draw the pie chart method

   drawKey(); // call on Draw the key method
}

void drawPieChart(float lateAngle, float earlyAngle) {
  
    fill(250, 134, 221); // Draw the late flights section (pink)
    arc(width / 2, height / 2, 300, 300, 0, lateAngle); // starts at 0 ends at the end of late angle

    fill(162, 41, 132); // Draw the early flights section (purple)
    arc(width / 2, height / 2, 300, 300, lateAngle, lateAngle + earlyAngle); // starts at the end of late angle, ends at late angle + early angle( end of early angle)

    fill(94, 8, 131); // Draw the on-time flights section (light purple)
    arc(width / 2, height / 2, 300, 300, lateAngle + earlyAngle, TWO_PI); // starts at end of early angle, ends at end of circle (two pie is a full circle) 
}

void drawKey () {
    textAlign(LEFT, TOP); //position the key for the pie chart in the top left corner
    fill(0); // make the text black
    textSize(14); // text size
    text("Late", 20, 20);
    text("Early", 20, 40);
    text("On Time", 20, 60);

    // Colored squares
    fill(250, 134, 221); // pink for late flights
    rect(120, 20, 15, 15);//position and size the squares
    fill(162, 41, 132); // purple for early flights
    rect(120, 40, 15, 15);
    fill(94, 8, 131);// light purple for on-time flights
    rect(120, 60, 15, 15);
}
}
