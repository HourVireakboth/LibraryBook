import 'package:librarybook/data/network/network_api_service.dart';
import 'package:librarybook/models/imagemodel.dart';
import 'package:librarybook/res/app_url.dart';

class ImageRepository {
  final _apiService = NetworkApiService();
  Future<ImageModel> uploadImage(file) async {
    try {
      var response = await _apiService.upLoadImage(AppUrl.uploadImage, file);
      print('response service $response');
      return response;
    } catch (e) {
      rethrow;
    }
  }
}
