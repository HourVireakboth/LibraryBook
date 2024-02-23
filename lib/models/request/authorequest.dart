import 'dart:convert';

AuthorRequest authorRequestFromJson(String str) => AuthorRequest.fromJson(json.decode(str));

String authorRequestToJson(AuthorRequest data) => json.encode(data.toJson());

class AuthorRequest {
    DataRequestAuthor? data;

    AuthorRequest({
        required this.data,
    });

    factory AuthorRequest.fromJson(Map<String, dynamic> json){ 
        return AuthorRequest(
            data: json["data"] == null ? null : DataRequestAuthor.fromJson(json["data"]),
        );
    }

    Map<String, dynamic> toJson() => {
        "data": data!.toJson(),
    };
}

class DataRequestAuthor {
    String? name;
    String? shortBiography;
    String? photo;

    DataRequestAuthor({
        required this.name,
        required this.shortBiography,
        required this.photo,
    });

    factory DataRequestAuthor.fromJson(Map<String, dynamic> json) => DataRequestAuthor(
        name: json["name"],
        shortBiography: json["short_biography"],
        photo: json["photo"],
    );

    Map<String, dynamic> toJson() => {
        "name": name,
        "short_biography": shortBiography,
        "photo": photo,
    };
}