// Modal class for the data we are getting from the API
class Country {
  Country({
    required this.id,
    required this.country,
    required this.totalConfirmed,
    required this.totalDeaths,
  });

  final String id;
  final String country;
  final int totalConfirmed;
  final int totalDeaths;

  factory Country.fromJson(Map<String, dynamic> json) => Country(
        id: json["ID"],
        country: json["Country"],
        totalConfirmed: json["TotalConfirmed"],
        totalDeaths: json["TotalDeaths"],
      );

  Map<String, dynamic> toJson() => {
        "ID": id,
        "Country": country,
        "TotalConfirmed": totalConfirmed,
        "TotalDeaths": totalDeaths,
      };
}
