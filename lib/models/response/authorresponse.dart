import 'dart:convert';

import 'dart:convert';

AuthorResponse authorResponseFromJson(String str) => AuthorResponse.fromJson(json.decode(str));

String authorResponseToJson(AuthorResponse data) => json.encode(data.toJson());

class AuthorResponse {
    Data? data;
    Meta? meta;

    AuthorResponse({
        required this.data,
        required this.meta,
    });

    factory AuthorResponse.fromJson(Map<String, dynamic> json){ 
        return AuthorResponse(
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
    String? name;
    String? shortBiography;
    DateTime? createdAt;
    DateTime? updatedAt;

    Attributes({
        required this.name,
        required this.shortBiography,
        required this.createdAt,
        required this.updatedAt,
    });

    factory Attributes.fromJson(Map<String, dynamic> json){ 
        return Attributes(
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
    Meta();

    factory Meta.fromJson(Map<String, dynamic> json) => Meta(
    );

    Map<String, dynamic> toJson() => {
    };
}
