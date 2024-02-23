class AppException implements Exception {
  String? message;
  String? prefix;

  AppException({this.message, this.prefix});

  @override
  String toString() {
    return 'AppException{message:$message,prefix:$prefix}';
  }
}

class FetchDataException extends AppException {
  FetchDataException(String msg)
      : super(
            message: msg,
            prefix: 'Error During Communication,please check your internet');
}

class BadRequestException extends AppException {
  BadRequestException(String msg)
      : super(
          message: msg,
          prefix: 'Please Check your Request Body'
        );
}
