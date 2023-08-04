// To parse this JSON data, do
//
//     final projectsDetails = projectsDetailsFromJson(jsonString);

import 'dart:convert';

ProjectsDetails projectsDetailsFromJson(String str) => ProjectsDetails.fromJson(json.decode(str));

String projectsDetailsToJson(ProjectsDetails data) => json.encode(data.toJson());

class ProjectsDetails {
  ProjectsDetails({
    required this.data,
  });

  Data data;

  factory ProjectsDetails.fromJson(Map<String, dynamic> json) => ProjectsDetails(
    data: Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "data": data.toJson(),
  };
}

class Data {
  Data({
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

  factory Data.fromJson(Map<String, dynamic> json) => Data(
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
