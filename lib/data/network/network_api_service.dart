import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:librarybook/data/app_exception.dart';
import 'package:librarybook/models/imagemodel.dart';

class NetworkApiService {
  dynamic responeJson;
  dynamic responeSearchJson;

  Future<dynamic> getApiResponse(String url) async {
    try {
      final response = await http.get(Uri.parse(url));
      responeJson = returnResponse(response);
    } on SocketException {
      throw FetchDataException('Not internet connection');
    }
    return responeJson;
  }
  
  Future<dynamic> postApi(String url, requestModel) async {
    var headers = {'Content-Type': 'application/json'};
    var request = http.Request('POST', Uri.parse(url));
    request.body = json.encode(requestModel);
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();
    print(response);
    if (response.statusCode == 200) {
      var res = await response.stream.bytesToString();
      return json.decode(res);
      //print(await response.stream.bytesToString());
    } else {
      print(response.reasonPhrase);
    }
  }

  Future<dynamic> putApi(String url, requestModel) async {
    var headers = {'Content-Type': 'application/json'};
    var request = http.Request('PUT', Uri.parse(url));
    request.body = json.encode(requestModel);
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();
    print('Staus Code = ${response.statusCode}');
    if (response.statusCode == 200) {
      var res = await response.stream.bytesToString();
      return json.decode(res);
      //print(await response.stream.bytesToString());
    } else {
      print(response.reasonPhrase);
    }
  }

  Future<dynamic> deleteApi(String url) async {
    var request = http.Request('DELETE', Uri.parse(url));
    var response = await request.send();
    if (response.statusCode == 200) {
      print('delete success');
      return true;
    } else {
      print(response.reasonPhrase);
      return false;
    }
  }

  Future<dynamic> getAuthorResponse(String url) async {
    try {
      final response = await http.get(Uri.parse(url));
      responeJson = responeJson(response);
    } on SocketException {
      throw FetchDataException('Not internet conection');
    }
    return responeJson;
  }

  Future upLoadImage(String url, file) async {
    var request = http.MultipartRequest('POST', Uri.parse(url));
    request.files.add(await http.MultipartFile.fromPath('files', file));

    var response = await request.send();
    var res = await response.stream.bytesToString();
    //print('response = ${res}');
    var images = imageModelFromJson(res);
    print('arter request send ${images.length}');
    print('ater request send ${images[0].url}');
    return images[0];
  }

  returnResponse(http.Response response) {
    switch (response.statusCode) {
      case 200:
        return jsonDecode(response.body);
      case 404:
        throw BadRequestException('please check your model request');
    }
  }

  returnResponseSearch(http.Response response) {
    switch (response.statusCode) {
      case 200:
        dynamic responseSearch = jsonDecode(response.body);
        print('values: $responeSearchJson');
        return responseSearch;
      case 404:
        throw BadRequestException('please check your model request');
      default:
        throw FetchDataException('Warning Error has occuring');
    }
  }
}
