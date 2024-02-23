import 'package:http/http.dart';
import 'package:librarybook/data/network/network_api_service.dart';
import 'package:librarybook/models/bookmodel.dart';
import 'package:librarybook/models/request/bookrequest.dart';
import 'package:librarybook/models/response/bookresponse.dart';
import 'package:librarybook/res/app_url.dart';

class BookRepository {
  final _apiService = NetworkApiService();
  Future<BookModel> getAllBook() async {
    try {
      dynamic response = await _apiService.getApiResponse(AppUrl.getAllBook);
      print(response);
      return response = BookModel.fromJson(response);
    } catch (e) {
      rethrow;
    }
  }

  Future<BookModel> getBookPage(page, limit) async {
    try {
      dynamic response = await _apiService.getApiResponse(
          '${AppUrl.getBookPage}?pagination%5Bpage%5D=$page&pagination%5BpageSize%5D=$limit&populate=%2A');
      print(response);
      return response = BookModel.fromJson(response);
    } catch (e) {
      rethrow;
    }
  }

  Future<dynamic> postBook(requestModel) async {
    try {
      var bookModel = BookRequest(data: requestModel);
      dynamic response =
          await _apiService.postApi(AppUrl.postBook, bookModel.toJson());
      print(response);
      print(BookResponse.fromJson(response));
      return response = BookResponse.fromJson(response);
    } catch (e) {
      rethrow;
    }
  }

  Future<dynamic> putBook(requestModel, id) async {
    try {
      var bookModel = BookRequest(data: requestModel);
      var url = '${AppUrl.postBook}/$id';
      dynamic response = await _apiService.putApi(url, bookModel.toJson());
      print(response);
      print(BookResponse.fromJson(response));
      return response = BookResponse.fromJson(response);
    } catch (e) {
      rethrow;
    }
  }

  Future<dynamic> deleleBook(id) async {
    try {
      var url = '${AppUrl.postBook}/$id';
      dynamic response = await _apiService.deleteApi(url);
      return response;
    } catch (e) {
      rethrow;
    }
  }
}
