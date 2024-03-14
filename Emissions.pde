class Emissions {

  private float distance;

  Emissions(float distance) {
    this.distance = distance;
  }

  float getDistance(){
    return distance;
  }

  void setDistance(float distance){
    this.distance = distance;
  }

  float calculateEmissions(float distance){
  
    float EMISSION_FACTOR = 0.21;
    float emissions = distance * EMISSION_FACTOR;
  
    return emissions;
  }
}
