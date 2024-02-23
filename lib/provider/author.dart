import 'package:flutter/material.dart';

import '../models/authormodel.dart';

class Author with ChangeNotifier {
  List<AuthorsData> _authors = [];

  List<AuthorsData> get items {
    return [..._authors];
  }

  set setitems(List<AuthorsData> newAuthors) {
    _authors = newAuthors ?? [];
  }

  void addAuthor(author) {
    print(author);
    _authors.clear();
    _authors.addAll(author!);
    //notifyListeners();
  }

  void removeAuthor(author) {
    print("List Author 1 = ${_authors.length}");
    _authors.removeAt(author);
    print("List Author 2 = ${_authors.length}");
    notifyListeners();
  }

  

  void updateAuthor(photo, name, bio, index) {
    _authors[index].attributes!.photo!.data!.attributes!.url = photo;
    _authors[index].attributes!.name = name;
    _authors[index].attributes!.shortBiography = bio;
    notifyListeners();
  }
}
