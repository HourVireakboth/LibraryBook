import 'dart:convert';

BookResponse bookResponseFromJson(String str) => BookResponse.fromJson(json.decode(str));

String bookResponseToJson(BookResponse data) => json.encode(data.toJson());

class BookResponse {
    Data? data;
    Meta? meta;

    BookResponse({
        required this.data,
        required this.meta,
    });

    factory BookResponse.fromJson(Map<String, dynamic> json){ 
        return BookResponse(
            data: json["data"] == null ? null : Data.fromJson(json["data"]),
            meta: json["meta"] == null ? null : Meta.fromJson(json["meta"]),
        );
    }

    Map<String, dynamic> toJson() => {
        "data": data!.toJson(),
        "meta": meta!.toJson(),
    };
}

class Data {
    int? id;
    Attributes? attributes;

    Data({
        required this.id,
        required this.attributes,
    });

    factory Data.fromJson(Map<String, dynamic> json){ 
        return Data(
            id: json["id"],
            attributes: json["attributes"] == null ? null : Attributes.fromJson(json["attributes"]),
        );
    }

    Map<String, dynamic> toJson() => {
        "id": id,
        "attributes": attributes!.toJson(),
    };
}

class Attributes {
    String ?code;
    String ?title;
    String ?description;
    DateTime? createdAt;
    DateTime? updatedAt;
    DateTime? publishedAt;
    int? price;
    int? starReview;
    dynamic originallyPublished;
    dynamic pdfLink;
    bool isEnabled;

    Attributes({
        required this.code,
        required this.title,
        required this.description,
        required this.createdAt,
        required this.updatedAt,
        required this.publishedAt,
        required this.price,
        required this.starReview,
        this.originallyPublished,
        this.pdfLink,
        required this.isEnabled,
    });

    factory Attributes.fromJson(Map<String, dynamic> json){ 
        return Attributes(
            code: json["code"],
            title: json["title"],
            description: json["description"],
            createdAt: DateTime.tryParse(json["createdAt"] ?? ""),
            updatedAt: DateTime.tryParse(json["updatedAt"] ?? ""),
            publishedAt: DateTime.tryParse(json["publishedAt"] ?? ""),
            price: json["price"],
            starReview: json["star_review"],
            originallyPublished: json["originally_published"],
            pdfLink: json["pdf_link"],
            isEnabled: json["isEnabled"],
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
        "originally_published": originallyPublished,
        "pdf_link": pdfLink,
        "isEnabled": isEnabled,
    };
}

class Meta {
    Meta();

    factory Meta.fromJson(Map<String, dynamic> json) => Meta(
    );

    Map<String, dynamic> toJson() => {
    };
}
