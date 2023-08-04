// To parse this JSON data, do
//
//     final hadithModel = hadithModelFromJson(jsonString);

import 'dart:convert';

HadithModel hadithModelFromJson(String str) => HadithModel.fromJson(json.decode(str));

String hadithModelToJson(HadithModel data) => json.encode(data.toJson());

class HadithModel {
  HadithModel({
    required this.data,
  });

  Data data;

  factory HadithModel.fromJson(Map<String, dynamic> json) => HadithModel(
    data: Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "data": data.toJson(),
  };
}

class Data {
  Data({
    required this.name,
    required this.description,
    required this.reference,
  });

  String name;
  String description;
  String reference;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    name: json["name"],
    description: json["description"],
    reference: json["reference"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "description": description,
    "reference": reference,
  };
}
