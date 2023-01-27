abstract class Event {
  String name = 'event name';
  Map<String, dynamic> data() {
    return {};
  }
}

class NewRideEvent implements Event {
  @override
  String name = "NEW_RIDE";

  @override
  Map<String, dynamic> data() {
    return {};
  }
}
