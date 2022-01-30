class Result{
  int rank;
  String name;
  int score;
  Result({required this.rank, required this.name, required this.score});

  factory Result.fromJson(Map<String, dynamic> json) {
    return Result(
        rank : json["rank"],
        name : json["name"],
        score : json["score"]
    );
  }
}