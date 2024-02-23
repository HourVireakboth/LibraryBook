import 'package:flutter/material.dart';

import '../data/response/api_repsonse.dart';
import '../models/serachmodel.dart';
import '../repository/searchbook_repository.dart';

class SearchBookViewModel extends ChangeNotifier {
  final _searchbookrespository = SearchBookRepository();
  ApiReponse<BookSearchModel> apiResponse = ApiReponse();
  searchBooksResponse(ApiReponse<BookSearchModel> response) {
    apiResponse = response;
    notifyListeners();
  }

  Future<dynamic> searchBooks(search) async {
    await _searchbookrespository
        .searchBook(search)
        .then((books) => searchBooksResponse(ApiReponse.completed(books)))
        .onError((error, stackTrace) =>
            searchBooksResponse(ApiReponse.error(error.toString())));
  }
}
