class JourneyDetails {
  int? distanceValue;
  int? duration;
  String? distanceText;
  String? durationText;
  String? encodedPoints;

  JourneyDetails(
      {this.distanceValue,
      this.duration,
      this.distanceText,
      this.durationText,
      this.encodedPoints});

  @override
  toString() {
    return 'distance: $distanceValue, duration: $duration, distance Text: $distanceText, duration Text: $durationText, encoded Points: $encodedPoints';
  }
}
