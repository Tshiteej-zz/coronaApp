// class User {
//   int id;
//   String name;
//   String email;

//   User({this.id, this.name, this.email});

//   factory User.fromJson(Map<String, dynamic> json) {
//     return User(
//       id: json["id"] as int,
//       name: json["name"] as String,
//       email: json["email"] as String,
//     );
//   }
// }

class PageData {
  final String name;
  final String code;
  final int population;
  final String updatedDate;
  final int deaths;
  final int recovered;
  final int confirmed;

  PageData(
      {this.name,
      this.code,
      this.population,
      this.updatedDate,
      this.deaths,
      this.recovered,
      this.confirmed});
  // name: u["name"],
  // code: u["code"],
  // population: u["population"],
  // updatedDate: u["updated_at"],
  // deaths: u["latest_data"]["deaths"],
  // recovered: u["latest_data"]["recovered"],
  // confirmed: u["latest_data"]["confirmed"]);
  factory PageData.fromJson(Map<String, dynamic> json) {
    return PageData(
        name: json["name"] as String,
        code: json["code"] as String,
        population: json["population"] as int,
        updatedDate: json["updated_at"] as String,
        deaths: json["latest_data"]["deaths"] as int,
        recovered: json["latest_data"]["recovered"] as int,
        confirmed: json["latest_data"]["confirmed"] as int);
  }
}
