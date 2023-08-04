// To parse this JSON data, do
//
//     final projectList = projectListFromJson(jsonString);

// To parse this JSON data, do
//
//     final project = projectFromJson(jsonString);

// import 'dart:convert';
//
// Project projectFromJson(String str) => Project.fromJson(json.decode(str));
//
// String projectToJson(Project data) => json.encode(data.toJson());
//
// class Project {
//   Project({
//     required this.data,
//   });
//
//   List<Datum> data;
//
//   factory Project.fromJson(Map<String, dynamic> json) => Project(
//         data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
//       );
//
//   Map<String, dynamic> toJson() => {
//         "data": List<dynamic>.from(data.map((x) => x.toJson())),
//       };
// }
//
// class Datum {
//   Datum({
//     required this.id,
//     required this.name,
//     required this.slug,
//     required this.title,
//     required this.description,
//     required this.targetAmount,
//     required this.zakat,
//     required this.image,
//   });
//
//   int id;
//   String name;
//   String slug;
//   String title;
//   String description;
//   String targetAmount;
//   String zakat;
//   String image;
//
//   factory Datum.fromJson(Map<String, dynamic> json) => Datum(
//         id: json["id"],
//         name: json["name"],
//         slug: json["slug"],
//         title: json["title"],
//         description: json["description"],
//         targetAmount: json["target_amount"],
//         zakat: json["zakat"],
//         image: json["image"],
//       );
//
//   Map<String, dynamic> toJson() => {
//         "id": id,
//         "name": name,
//         "slug": slug,
//         "title": title,
//         "description": description,
//         "target_amount": targetAmount,
//         "zakat": zakat,
//         "image": image,
//       };
// }









// To parse this JSON data, do
//
//     final projects = projectsFromJson(jsonString);

import 'dart:convert';

Projects projectsFromJson(String str) => Projects.fromJson(json.decode(str));

String projectsToJson(Projects data) => json.encode(data.toJson());

class Projects {
  Projects({
    required this.data,
    required this.links,
    required this.meta,
  });

  List<Datum> data;
  Links links;
  Meta meta;

  factory Projects.fromJson(Map<String, dynamic> json) => Projects(
    data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
    links: Links.fromJson(json["links"]),
    meta: Meta.fromJson(json["meta"]),
  );

  Map<String, dynamic> toJson() => {
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
    "links": links.toJson(),
    "meta": meta.toJson(),
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
  dynamic image;

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

class Links {
  Links({
    required this.first,
    required this.last,
    this.prev,
    this.next,
  });

  String first;
  String last;
  dynamic prev;
  dynamic next;

  factory Links.fromJson(Map<String, dynamic> json) => Links(
    first: json["first"],
    last: json["last"],
    prev: json["prev"],
    next: json["next"],
  );

  Map<String, dynamic> toJson() => {
    "first": first,
    "last": last,
    "prev": prev,
    "next": next,
  };
}

class Meta {
  Meta({
    required this.currentPage,
    required this.from,
    required this.lastPage,
    required this.links,
    required this.path,
    required this.perPage,
    required this.to,
    required this.total,
  });

  int currentPage;
  int from;
  int lastPage;
  List<Link> links;
  String path;
  int perPage;
  int to;
  int total;

  factory Meta.fromJson(Map<String, dynamic> json) => Meta(
    currentPage: json["current_page"],
    from: json["from"],
    lastPage: json["last_page"],
    links: List<Link>.from(json["links"].map((x) => Link.fromJson(x))),
    path: json["path"],
    perPage: json["per_page"],
    to: json["to"],
    total: json["total"],
  );

  Map<String, dynamic> toJson() => {
    "current_page": currentPage,
    "from": from,
    "last_page": lastPage,
    "links": List<dynamic>.from(links.map((x) => x.toJson())),
    "path": path,
    "per_page": perPage,
    "to": to,
    "total": total,
  };
}

class Link {
  Link({
    this.url,
    required this.label,
    required this.active,
  });

  String? url;
  String label;
  bool active;

  factory Link.fromJson(Map<String, dynamic> json) => Link(
    url: json["url"],
    label: json["label"],
    active: json["active"],
  );

  Map<String, dynamic> toJson() => {
    "url": url,
    "label": label,
    "active": active,
  };
}

