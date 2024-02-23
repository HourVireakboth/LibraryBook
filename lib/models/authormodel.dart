import 'dart:convert';

AuthorModel authorModelFromJson(String str) => AuthorModel.fromJson(json.decode(str));

String authorModelToJson(AuthorModel data) => json.encode(data.toJson());

class AuthorModel {
    List<AuthorsData> data;

    AuthorModel({
        required this.data,
    });

    factory AuthorModel.fromJson(Map<String, dynamic> json){
        return AuthorModel(
            data: json["data"] == null ? [] : List<AuthorsData>.from(json["data"]!.map((x) => AuthorsData.fromJson(x))),
        );
    }

    Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
    };
}

class AuthorsData {
    int? id;
    AuthorAttributes? attributes;

    AuthorsData({
        required this.id,
        required this.attributes,
    });
    factory AuthorsData.fromJson(Map<String, dynamic> json){
        return AuthorsData(
            id: json["id"],
            attributes: json["attributes"] == null ? null : AuthorAttributes.fromJson(json["attributes"]),
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
    Photo? photo;

    AuthorAttributes({
        required this.name,
        required this.shortBiography,
        required this.createdAt,
        required this.updatedAt,
        required this.photo,
    });

    factory AuthorAttributes.fromJson(Map<String, dynamic> json){
        return AuthorAttributes(
            name: json["name"],
            shortBiography: json["short_biography"],
            createdAt: DateTime.tryParse(json["createdAt"] ?? ""),
            updatedAt: DateTime.tryParse(json["updatedAt"] ?? ""),
            photo: json["photo"] == null ? null : Photo.fromJson(json["photo"]),
        );
    }

    Map<String, dynamic> toJson() => {
        "name": name,
        "short_biography": shortBiography,
        "createdAt": createdAt!.toIso8601String(),
        "updatedAt": updatedAt!.toIso8601String(),
        "photo": photo!.toJson(),
    };
}

class Photo {
    Data? data;

    Photo({
        required this.data,
    });

    factory Photo.fromJson(Map<String, dynamic> json){
        return Photo(
            data: json["data"] == null ? null : Data.fromJson(json["data"]),
        );
    }

    Map<String, dynamic> toJson() => {
        "data": data!.toJson(),
    };
}

class Data {
    int? id;
    DataAttributes? attributes;

    Data({
        required this.id,
        required this.attributes,
    });

    factory Data.fromJson(Map<String, dynamic> json){
        return Data(
            id: json["id"],
            attributes: json["attributes"] == null ? null : DataAttributes.fromJson(json["attributes"]),
        );
    }

    Map<String, dynamic> toJson() => {
        "id": id,
        "attributes": attributes!.toJson(),
    };
}

class DataAttributes {
    String url;

    DataAttributes({
        required this.url,
    });

    factory DataAttributes.fromJson(Map<String, dynamic> json) => DataAttributes(
        url: json["url"],
    );

    Map<String, dynamic> toJson() => {
        "url": url,
    };
}
