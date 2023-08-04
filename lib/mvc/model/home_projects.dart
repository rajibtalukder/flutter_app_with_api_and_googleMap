// To parse this JSON data, do
//
//     final homeProjects = homeProjectsFromJson(jsonString);

import 'dart:convert';

HomeProjects homeProjectsFromJson(String str) => HomeProjects.fromJson(json.decode(str));

String homeProjectsToJson(HomeProjects data) => json.encode(data.toJson());

class HomeProjects {
  HomeProjects({
    required this.data,
  });

  List<Datum> data;

  factory HomeProjects.fromJson(Map<String, dynamic> json) => HomeProjects(
    data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class Datum {
  Datum({
    required this.id,
    required this.name,
    required this.slug,
    required this.title,
    required this.description,
    required this.targetAmount,
    required this.zakat,
    required this.image,
  });

  int id;
  String name;
  String slug;
  String title;
  String description;
  String targetAmount;
  String zakat;
  String image;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"],
    name: json["name"],
    slug: json["slug"],
    title: json["title"],
    description: json["description"],
    targetAmount: json["target_amount"],
    zakat: json["zakat"],
    image: json["image"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "slug": slug,
    "title": title,
    "description": description,
    "target_amount": targetAmount,
    "zakat": zakat,
    "image": image,
  };
}
