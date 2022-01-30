class LineResponse{
  int Rank;
  String Name;
  double Points;
  LineResponse({required this.Rank, required this.Name, required this.Points});

  factory LineResponse.fromJson(Map<String, dynamic> json) {
    return LineResponse(
        Rank : json["Rank"],
        Name : json["Name"],
        Points : json["Points"]
    );
  }
}