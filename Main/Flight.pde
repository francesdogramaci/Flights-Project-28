// Lisa
class Flight {
  private String originAirport;
  private String destinationAirport;
  private String departureDate;
  private float distance;
  private int cancelled;
  
  public Flight(String originAirport, String destinationAirport, String departureDate, float distance, int cancelled) {
    this.originAirport = originAirport;
    this.destinationAirport = destinationAirport;
    this.departureDate = departureDate;
    this.distance = distance;
    this.cancelled = cancelled;
  }
  
  public String getOrigin() {
    return originAirport;
  }
  
  public String getDestination() {
    return destinationAirport;
  }
  
  public String getDate() {
    return departureDate;
  }
  
  public float getDistance() {
    return distance;
  }
  
  public int getCancelled() {
    return cancelled;
  }
  
  public void setOrigin(String originAirport) {
    this.originAirport = originAirport;
  }
  
  public void setDestination(String destinationAirport) {
    this.destinationAirport = destinationAirport;
  }
  
  public void setDate(String departureDate) {
    this.departureDate = departureDate;
  }
  
  public void setDistance(float distance) {
    this.distance = distance;
  }
  
  public void setCancelled(int cancelled) {
    this.cancelled = cancelled;
  }
  
  
}
