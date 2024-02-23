import 'package:flutter/material.dart';
import 'package:librarybook/data/response/api_repsonse.dart';
import 'package:librarybook/models/bookmodel.dart';
import 'package:librarybook/repository/book_repository.dart';

class BookViewModel extends ChangeNotifier {
  final _bookRepo = BookRepository();
  // ApiReponse<BookModel> apiResponse = ApiReponse();

  // setApiReponse(ApiReponse<BookModel> response) {
  //   apiResponse = response;
  //   notifyListeners();
  // }

  var apiResponse = ApiReponse();

  setApiReponse(response) {
    apiResponse = response;
    notifyListeners();
  }
  

  Future<dynamic> getAllBooks() async {
    await _bookRepo
        .getAllBook()
        .then((response) => setApiReponse(ApiReponse.completed(response)))
        .onError((error, stackTrace) =>
            setApiReponse(ApiReponse.error(error.toString())));
    print(apiResponse);
  }

  Future<dynamic> getBookPage(page, limit) async {
    await _bookRepo
        .getBookPage(page, limit)
        .then((books) => setApiReponse(ApiReponse.completed(books)))
        .onError((error, stackTrace) =>
            setApiReponse(ApiReponse.error(error.toString())));
    print(apiResponse);
  }

  Future<dynamic> postBook(requestModel) async {
    await _bookRepo
        .postBook(requestModel)
        .then((value) => setApiReponse(ApiReponse.completed(value)))
        .onError((error, stackTrace) =>
            setApiReponse(ApiReponse.error(error.toString())));
    print("bookRepo = ${_bookRepo}");
  }

  Future<dynamic> putBook(requestModel, id) async {
    await _bookRepo
        .putBook(requestModel, id)
        .then((value) => setApiReponse(ApiReponse.completed(value)))
        .onError((error, stackTrace) =>
            setApiReponse(ApiReponse.error(error.toString())));
  }

  Future<dynamic> deleteBook(id) async {
    setApiReponse(ApiReponse.loading());
    await _bookRepo
        .deleleBook(id)
        .then((value) => setApiReponse(ApiReponse.completed(value)))
        .onError((error, stackTrace) =>
            setApiReponse(ApiReponse.error(error.toString())));
  }
}
