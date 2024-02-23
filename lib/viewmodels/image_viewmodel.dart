import 'package:flutter/material.dart';
import 'package:librarybook/data/response/api_repsonse.dart';
import 'package:librarybook/models/imagemodel.dart';
import 'package:librarybook/repository/image_repository.dart';

class ImageViewModel extends ChangeNotifier {
  var imageRepository = ImageRepository();
  // var apiResponse = ApiReponse.loading();

  // setApiResponse(response) {
  //   apiResponse = response;
  //   notifyListeners();
  // }
  ApiReponse<ImageModel> imageResponse = ApiReponse.loading();
  setImageResponse(ApiReponse<ImageModel> reponse) {
    imageResponse = reponse;
    notifyListeners();
  }

  Future<dynamic> uploadImage(file) async {
    await imageRepository
        .uploadImage(file)
        .then((value) => setImageResponse(ApiReponse.completed(value)))
        .onError((error, stackTrace) =>
            setImageResponse(ApiReponse.error(error.toString())));
    print(imageRepository);
  }
}
