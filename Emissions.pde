// Lisa
import java.util.ArrayList;

class Emissions {
  final float AVERAGE_EMISSION_PER_MILE = 0.024;

  //Multiple distances
  public float[] calculateEmissions(float[] totalDistances) {
    float[] emissions = new float[totalDistances.length];
    for (int i = 0; i < totalDistances.length; i++) {
      emissions[i] = totalDistances[i] * AVERAGE_EMISSION_PER_MILE;
    }
    return emissions;
  }

  // One distance
  public float calculateEmission(float distance) {
    return distance * AVERAGE_EMISSION_PER_MILE;
  }
}
