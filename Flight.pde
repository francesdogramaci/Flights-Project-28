// Lisa
class Flight {
  private String originAirport;
  private String destinationAirport;
  private String departureDate;
  private float distance;
  private int cancelled;
  private int crsDepTime;
  private int depTime;
 
  public Flight(String originAirport, String destinationAirport, String departureDate,
                float distance, int cancelled, int crsDepTime, int depTime)
  {
    this.originAirport = originAirport;
    this.destinationAirport = destinationAirport;
    this.departureDate = departureDate;
    this.distance = distance;
    this.cancelled = cancelled;
    this.crsDepTime = crsDepTime;
    this.depTime = depTime;
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
 
  public int getCRSDepTime() {
    return crsDepTime;
  }
 
  public int getDepTime() {
    return depTime;
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
 
  public void setCRSDepTime(int crsDepTime) {
    this.crsDepTime = crsDepTime;
  }
 
  public void setDepTime(int depTime) {
    this.depTime = depTime;
  }
 
}
