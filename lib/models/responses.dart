class Responses<T> {
  String? message;
  bool condition;
  T? results;

  Responses({
    required this.condition,
    this.message,
    this.results,
  });

  Map<String, dynamic> toJson() {
    // ignore: prefer_typing_uninitialized_variables
    var _results;
    try {
      _results = getResults;
    } catch (e) {
      _results = null;
    }

    return {
      'message': message,
      'condition': condition,
      'results': _results,
    };
  }

  T? get getResults => results;
}
