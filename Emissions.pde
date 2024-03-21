
class Emissions {
  float emissions;
  float distance;
  final float EMISSIONS_PER_MILE = 0.2;
  
  Emissions(float distance) {
    this.distance = distance;
  }
  
  public float calculateEmissions(){
    return distance * EMISSIONS_PER_MILE;
  }
}
