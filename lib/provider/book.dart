import 'package:flutter/material.dart';
import 'package:librarybook/models/bookmodel.dart';

class Book with ChangeNotifier {
  List<BookData> _books = [];
  List<BookData> book = [];

  List<BookData> get items {
    return [..._books.toSet().toList()];
  }

  set setitems(List<BookData> newBook) {
    _books = newBook ?? [];
  }

  void addBook(book, refresh) {
    print(book);
    if (refresh) {
      _books.clear();
    }
    _books.addAll(book!);
    //notifyListeners();
  }

  void removeBook(book) {
    print("List Author 1 = ${_books.length}");
    _books.removeAt(book);
    print("List Author 2 = ${_books.length}");
    notifyListeners();
  }

  void updatenBook(
      photo, title, des, bookcode, bookprice, author, rateing, index) {
    print("photo = $photo");
    _books[index].attributes?.thumbnail?.data?.attributes?.url = photo;
    _books[index].attributes!.title = title;
    _books[index].attributes!.description = des;
    _books[index].attributes!.code = bookcode;
    _books[index].attributes!.price = bookprice;
    _books[index].attributes!.ibAuthor?.data?.attributes?.name = author;
    _books[index].attributes!.starReview = int.parse(rateing);
    notifyListeners();
  }
}
