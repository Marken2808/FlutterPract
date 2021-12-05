class League {
  String name;
  String? country;
  String? logo;
  String? flag;
  dynamic season;
  String? round;

  League({
    required this.name,
    required this.country,
    required this.logo,
    required this.flag,
    required this.season,
    this.round,
  });

  factory League.fromJson(Map<String, dynamic> json) {
    return League(
      name: json['name'],
      country: json['country'],
      logo: json['logo'],
      flag: json['flag'],
      season: json['season'],
      round: json['round'],
    );
  }

  @override
  String toString() {
    return 'League(name: $name, country: $country, logo: $logo, flag: $flag, season: $season, round: $round)';
  }
}
