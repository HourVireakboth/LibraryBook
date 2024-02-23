import 'package:librarybook/data/network/network_api_service.dart';
import 'package:librarybook/models/authormodel.dart';
import 'package:librarybook/models/request/authorequest.dart';
import 'package:librarybook/models/response/authorresponse.dart';
import 'package:librarybook/res/app_url.dart';

class AuthorRepository {
  final _apiService = NetworkApiService();
  Future<AuthorModel> getAuthor() async {
    try {
      dynamic reponse = await _apiService.getApiResponse(AppUrl.getAllAuthor);
      print(reponse);
      return reponse = AuthorModel.fromJson(reponse);
    } catch (e) {
      rethrow;
    }
  }

  Future<dynamic> postAuthor(requestModel) async {
    try {
      var authorModel = AuthorRequest(data: requestModel);
      dynamic response =
          await _apiService.postApi(AppUrl.postAuthor, authorModel.toJson());
      print(response);
      print(AuthorResponse.fromJson(response));
      return response = AuthorResponse.fromJson(response) ; //
    } catch (e) {
      rethrow;
    }
  }

  Future<dynamic> putAuthor(requestModel, id) async {
    try {
      var authorModel = AuthorRequest(data: requestModel);
      var url = '${AppUrl.postAuthor}/$id';
      dynamic response = await _apiService.putApi(url, authorModel.toJson());
      print(response);
      print(AuthorResponse.fromJson(response));
      return response = AuthorResponse.fromJson(response);
    } catch (e) {
      rethrow;
    }
  }

  Future<dynamic> deleleAuthor(id) async {
    try {
      var url = '${AppUrl.postAuthor}/$id';
      dynamic response = await _apiService.deleteApi(url);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  
}
