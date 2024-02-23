import 'dart:convert';

BookRequest bookRequestFromJson(String str) => BookRequest.fromJson(json.decode(str));

String bookRequestToJson(BookRequest data) => json.encode(data.toJson());

class BookRequest {
    DataRequest? data;

    BookRequest({
        required this.data,
    });

    factory BookRequest.fromJson(Map<String, dynamic> json){
        return BookRequest(
            data: json["data"] == null ? null : DataRequest.fromJson(json["data"]),
        );
    }

    Map<String, dynamic> toJson() => {
        "data": data!.toJson(),
    };
}

class DataRequest {
    String? code;
    String? title;
    String? description;
    int? price;
    int? starReview;
    String? ibAuthor;
    String? thumbnail;

    DataRequest({
         this.code,
         this.title,
         this.description,
         this.price,
         this.starReview,
         this.ibAuthor,
         this.thumbnail,
    });

    factory DataRequest.fromJson(Map<String, dynamic> json) => DataRequest(
        code: json["code"],
        title: json["title"],
        description: json["description"],
        price: json["price"],
        starReview: json["star_review"],
        ibAuthor: json["ib_author"],
        thumbnail: json["thumbnail"],
    );

    Map<String, dynamic> toJson() => {
        "code": code,
        "title": title,
        "description": description,
        "price": price,
        "star_review": starReview,
        "ib_author": ibAuthor,
        "thumbnail": thumbnail,
    };
}
