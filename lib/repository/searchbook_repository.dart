import 'package:librarybook/models/serachmodel.dart';
import 'package:librarybook/res/app_url.dart';

import '../data/network/network_api_service.dart';

class SearchBookRepository {
  final _apiService = NetworkApiService();

  Future<BookSearchModel> searchBook(search) async {
    try {
      dynamic response = await _apiService.getApiResponse(
          '${AppUrl.searchUrl}?filters[title][\$containsi]=$search&populate=*');
      return response = BookSearchModel.fromJson(response);
    } catch (error) {
      rethrow;
    }
  }
}
