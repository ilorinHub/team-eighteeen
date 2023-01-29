class EventGeneric {
  static T fromJson<T>(Map<String, dynamic> json) {
    throw Exception("Unknown class");
  }
}
