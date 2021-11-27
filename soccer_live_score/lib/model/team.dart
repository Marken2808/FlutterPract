class Team {
  int id;
  String name;
  String logoUrl;
  bool? winner;

  Team({
    required this.id,
    required this.name,
    required this.logoUrl,
    required this.winner,
  });

  factory Team.fromJson(Map<String, dynamic> json) {
    return Team(
        id: json['id'],
        name: json['name'],
        logoUrl: json['logo'],
        winner: json['winner']);
  }
}
