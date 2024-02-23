import 'dart:convert';

BookModel bookModelFromJson(String str) => BookModel.fromJson(json.decode(str));

String bookModelToJson(BookModel data) => json.encode(data.toJson());

class BookModel {
  List<BookData>? data;
  Meta? meta;

  BookModel({this.data, this.meta});

  factory BookModel.fromJson(Map<String, dynamic> json) {
    return BookModel(
      data: json["data"] == null
          ? []
          : List<BookData>.from(json["data"]!.map((x) => BookData.fromJson(x))),
          meta: json["meta"] == null ? null :  Meta.fromJson(json["meta"]) 
    );
  }

  Map<String, dynamic> toJson() => {
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class BookData {
  int? id;
  Attributes? attributes;

  BookData({
    this.id,
    this.attributes,
  });

  factory BookData.fromJson(Map<String, dynamic> json) {
    return BookData(
      id: json["id"],
      attributes: json["attributes"] == null
          ? null
          : Attributes.fromJson(json["attributes"]),
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "attributes": attributes == null ? null : attributes!.toJson(),
      };
}

class Attributes {
  String? code;
  String? title;
  String? description;
  DateTime? createdAt;
  DateTime? updatedAt;
  DateTime? publishedAt;
  int? price;
  int? starReview;
  DateTime? originallyPublished;
  String? pdfLink;
  bool? isEnabled;
  IbAuthor? ibAuthor;
  Thumbnail? thumbnail;
  Meta? meta;

  Attributes({
    this.code,
    this.title,
    this.description,
    this.createdAt,
    this.updatedAt,
    this.publishedAt,
    this.price,
    this.starReview,
    this.originallyPublished,
    this.pdfLink,
    this.isEnabled,
    this.ibAuthor,
    this.thumbnail,
    this.meta,
  });
  factory Attributes.fromJson(Map<String, dynamic> json) {
    return Attributes(
      code: json["code"],
      title: json["title"],
      description: json["description"],
      createdAt: DateTime.tryParse(json["createdAt"] ?? ""),
      updatedAt: DateTime.tryParse(json["updatedAt"] ?? ""),
      publishedAt: DateTime.tryParse(json["publishedAt"] ?? ""),
      price: json["price"],
      starReview: json["star_review"],
      originallyPublished:
          DateTime.tryParse(json["originally_published"] ?? ""),
      pdfLink: json["pdf_link"],
      isEnabled: json["isEnabled"],
      ibAuthor: json["ib_author"] == null
          ? null
          : IbAuthor.fromJson(json["ib_author"]),
      thumbnail: json["thumbnail"] == null
          ? null
          : Thumbnail.fromJson(json["thumbnail"]),
      meta: json["meta"] == null ? null : Meta.fromJson(json["meta"]),
    );
  }

  Map<String, dynamic> toJson() => {
        "code": code,
        "title": title,
        "description": description,
        "createdAt": createdAt!.toIso8601String(),
        "updatedAt": updatedAt!.toIso8601String(),
        "publishedAt": publishedAt!.toIso8601String(),
        "price": price,
        "star_review": starReview,
        "originally_published":
            "${originallyPublished!.year.toString().padLeft(4, '0')}-${originallyPublished!.month.toString().padLeft(2, '0')}-${originallyPublished!.day.toString().padLeft(2, '0')}",
        "pdf_link": pdfLink,
        "isEnabled": isEnabled,
        "ib_author": ibAuthor!.toJson(),
        "thumbnail": thumbnail!.toJson(),
        "meta": meta!.toJson(),
      };
}

class IbAuthor {
  AuthorData? data;

  IbAuthor({
    required this.data,
  });
  factory IbAuthor.fromJson(Map<String, dynamic> json) {
    return IbAuthor(
      data: json["data"] == null ? null : AuthorData.fromJson(json["data"]),
    );
  }
  Map<String, dynamic> toJson() => {
        "data": data!.toJson(),
      };
}

class AuthorData {
  int? id;
  AuthorAttributes? attributes;

  AuthorData({
    required this.id,
    required this.attributes,
  });

  factory AuthorData.fromJson(Map<String, dynamic> json) {
    return AuthorData(
      id: json["id"],
      attributes: json["attributes"] == null
          ? null
          : AuthorAttributes.fromJson(json["attributes"]),
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "attributes": attributes!.toJson(),
      };
}

class AuthorAttributes {
  String? name;
  String? shortBiography;
  DateTime? createdAt;
  DateTime? updatedAt;

  AuthorAttributes({
    this.name,
    this.shortBiography,
    this.createdAt,
    this.updatedAt,
  });

  factory AuthorAttributes.fromJson(Map<String, dynamic> json) {
    return AuthorAttributes(
      name: json["name"],
      shortBiography: json["short_biography"],
      createdAt: DateTime.tryParse(json["createdAt"] ?? ""),
      updatedAt: DateTime.tryParse(json["updatedAt"] ?? ""),
    );
  }

  Map<String, dynamic> toJson() => {
        "name": name,
        "short_biography": shortBiography,
        "createdAt": createdAt!.toIso8601String(),
        "updatedAt": updatedAt!.toIso8601String(),
      };
}

class Meta {
  Pagination? pagination;

  Meta({
    required this.pagination,
  });

  factory Meta.fromJson(Map<String, dynamic> json) {
    return Meta(
      pagination: json["pagination"] == null
          ? null
          : Pagination.fromJson(json["pagination"]),
    );
  }

  Map<String, dynamic> toJson() => {
        "pagination": pagination!.toJson(),
      };
}

class Pagination {
  int? page;
  int? pageSize;
  int? pageCount;
  int? total;

  Pagination({
    this.page,
    this.pageSize,
    this.pageCount,
    this.total,
  });

  factory Pagination.fromJson(Map<String, dynamic> json) {
    return Pagination(
      page: json["page"],
      pageSize: json["pageSize"],
      pageCount: json["pageCount"],
      total: json["total"],
    );
  }

  Map<String, dynamic> toJson() => {
        "page": page,
        "pageSize": pageSize,
        "pageCount": pageCount,
        "total": total,
      };
}

class Thumbnail {
  ThumbnailData? data;

  Thumbnail({
    required this.data,
  });

  factory Thumbnail.fromJson(Map<String, dynamic> json) {
    return Thumbnail(
      data: json["data"] == null ? null : ThumbnailData.fromJson(json["data"]),
    );
  }

  Map<String, dynamic> toJson() => {
        "data": data!.toJson(),
      };
}

class ThumbnailData {
  int? id;
  ThumbnailAttributes? attributes;

  ThumbnailData({
    this.id,
    this.attributes,
  });

  factory ThumbnailData.fromJson(Map<String, dynamic> json) {
    return ThumbnailData(
      id: json["id"],
      attributes: json["attributes"] == null
          ? null
          : ThumbnailAttributes.fromJson(json["attributes"]),
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "attributes": attributes!.toJson(),
      };
}

class ThumbnailAttributes {
  String? url;

  ThumbnailAttributes({
    required this.url,
  });

  factory ThumbnailAttributes.fromJson(Map<String, dynamic> json) {
    return ThumbnailAttributes(
      url: json["url"],
    );
  }

  Map<String, dynamic> toJson() => {
        "url": url,
      };
}
