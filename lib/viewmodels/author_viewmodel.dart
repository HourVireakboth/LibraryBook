import 'package:flutter/material.dart';
import 'package:librarybook/data/response/api_repsonse.dart';
import 'package:librarybook/models/authormodel.dart';
import 'package:librarybook/models/serachmodel.dart';
import 'package:librarybook/repository/author_repository.dart';

class AuthorViewModel with ChangeNotifier {
  final _authorRepo = AuthorRepository();
  var apiResponse = ApiReponse();

  setApiReponse(response) {
    apiResponse = response;
    notifyListeners();
  }

  //ApiReponse<AuthorModel> apiResponse = ApiReponse();

  // setApiReponse(ApiReponse<AuthorModel> response) {
  //   apiResponse = response;
  //   notifyListeners();
  // }

  Future<dynamic> getAllAuthor() async {
    await _authorRepo
        .getAuthor()
        .then((response) => setApiReponse(ApiReponse.completed(response)))
        .onError((error, stackTrace) =>
            setApiReponse(ApiReponse.error(error.toString())));
    print(setApiReponse);
  }

  Future<dynamic> postAuthor(requestModel) async {
    await _authorRepo
        .postAuthor(requestModel)
        .then((value) => setApiReponse(ApiReponse.completed(value)))
        .onError((error, stackTrace) =>
            setApiReponse(ApiReponse.error(error.toString())));
    print("authRepo = ${_authorRepo}");
  }

  Future<dynamic> putAuthor(requestModel, id) async {
    await _authorRepo
        .putAuthor(requestModel, id)
        .then((value) => setApiReponse(ApiReponse.completed(value)))
        .onError((error, stackTrace) =>
            setApiReponse(ApiReponse.error(error.toString())));
  }

  Future<dynamic> deleteAuthor(id) async {
    setApiReponse(ApiReponse.loading());
    await _authorRepo
        .deleleAuthor(id)
        .then((value) => setApiReponse(ApiReponse.completed(value)))
        .onError((error, stackTrace) =>
            setApiReponse(ApiReponse.error(error.toString())));
  }

  // List<AuthorsData> _authors = [];

  // List<AuthorsData> get items {
  //   return [..._authors];
  // }

  // set setitems(List<AuthorsData> newAuthors) {
  // _authors = newAuthors ?? [];
  // }


  // void addAuthor(author) {
  //   print(author);
  //   _authors.addAll(author!);
  //   //notifyListeners();
  // }

  // void removeAuthor(author) {
  //   print("List Author 1 = ${items.length}");
  //   items.removeAt(author);
  //   notifyListeners();
  // }
}
