import 'package:librarybook/data/response/status.dart';
import 'package:librarybook/models/bookmodel.dart';

class ApiReponse<T> {
  Status? status;
  T? data;
  String? message;
  ApiReponse();
  ApiReponse.loading() : status = Status.LOADING;
  ApiReponse.completed(this.data) : status = Status.COMPLETED;
  ApiReponse.error(this.message) : status = Status.ERROR;

  @override
  String toString() {
    return 'ApiReponse{status:$status,date:$data,message:$message}';
  }
}
