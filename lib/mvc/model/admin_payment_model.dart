// To parse this JSON data, do
//
//     final adminPayment = adminPaymentFromJson(jsonString);

import 'dart:convert';

AdminPayment adminPaymentFromJson(String str) => AdminPayment.fromJson(json.decode(str));

String adminPaymentToJson(AdminPayment data) => json.encode(data.toJson());

class AdminPayment {
  AdminPayment({
    required this.data,
    required this.links,
    required this.meta,
  });

  List<Datum> data;
  Links links;
  Meta meta;

  factory AdminPayment.fromJson(Map<String, dynamic> json) => AdminPayment(
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
    required this.project,
    required this.customerInfo,
    required this.targetAmount,
    required this.amount,
  });

  int id;
  Project project;
  CustomerInfo customerInfo;
  String? targetAmount;
  String amount;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"],
    project: Project.fromJson(json["project"]),
    customerInfo: CustomerInfo.fromJson(json["customer_info"]),
    targetAmount: json["target_amount"],
    amount: json["amount"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "project": project.toJson(),
    "customer_info": customerInfo.toJson(),
    "target_amount": targetAmount,
    "amount": amount,
  };
}

class CustomerInfo {
  CustomerInfo({
    this.name,
    this.email,
    this.address,
  });

  String? name;
  String? email;
  String? address;

  factory CustomerInfo.fromJson(Map<String, dynamic> json) => CustomerInfo(
    name: json["name"],
    email: json["email"],
    address: json["address"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "email": email,
    "address": address,
  };
}

class Project {
  Project({
     this.name,
     this.title,
  });

  String? name;
  String? title;

  factory Project.fromJson(Map<String, dynamic> json) => Project(
    name: json["name"],
    title: json["title"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "title": title,
  };
}

class Links {
  Links({
    required this.first,
    required this.last,
    this.prev,
    required this.next,
  });

  String first;
  String last;
  dynamic prev;
  String next;

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
