import 'package:dio/dio.dart';

import 'failure.dart';

class ErrorHandler implements Exception {
  late Failure failure;

  ErrorHandler.handle(dynamic error) {
    if (error is DioException) {
      // dio error is its an error from response of the api or from dio itself
      failure = _handleError(error);
    } else {
      failure = DataSource.unKnown.getFailure(message: failure.message);
    }
  }
}

Failure _handleError(DioException error) {
  switch (error.type) {
    case DioExceptionType.connectionTimeout:
      return DataSource.connectTimeout.getFailure();
    case DioExceptionType.sendTimeout:
      return DataSource.sendTimeOut.getFailure();
    case DioExceptionType.receiveTimeout:
      return DataSource.receiveTimeout.getFailure();
    case DioExceptionType.cancel:
      return DataSource.cancel.getFailure();
    case DioExceptionType.badResponse:
      if (error.response != null) {
        final resp = ErrorModel.fromJson(
            error.response!.data is Map ? error.response!.data : {});

        return DataSource.badResponse.getFailure(message: resp.message);
      }
      return DataSource.badResponse.getFailure();
    default:
      return DataSource.unKnown.getFailure();
  }
}

enum DataSource {
  success,
  noContent,
  badResponse,
  forbidden,
  unauthorized,
  notFound,
  internalServerError,
  connectTimeout,
  cancel,
  receiveTimeout,
  sendTimeOut,
  cacheError,
  noInternetConnection,
  unKnown
}

class ResponseCode {
  static const int success = 200; // success with data
  static const int noContent = 201; // success with no data (no content)
  static const int badResponse = 400; // failure api rejected request
  static const int unauthorized = 401; // failure, user is not authorized
  static const int forbidden = 403; // failure api rejected request
  static const int internalServerError = 500; // failure, crash in server side
  static const int notFound = 404; // failure, page not found
  //local status code
  static const int connectTimeOut = -1;
  static const int cancel = -2;
  static const int receiveTimeOut = -3;
  static const int sendTimeOut = -4;
  static const int cacheError = -5;
  static const int noInternetConnection = -6;
  static const int unKnown = -7;
}

class ResponseMessage {
  static const String success = 'Success'; // success with data
  static const String noContent =
      'Success'; // success with no data (no content)
  static const String badResponse = 'Failure: API rejected request';
  static const String unauthorized = 'Failure: User is not authorized';
  static const String forbidden = 'Failure: API rejected request';
  static const String internalServerError = 'Failure: Crash in server side';
  static const String notFound = 'Failure: Page not found';

  static const String connectTimeOut = 'Connection timeout';
  static const String cancel = 'Request canceled';
  static const String receiveTimeOut = 'Receive timeout';
  static const String sendTimeOut = 'Send timeout';
  static const String cacheError = 'Cache error';
  static const String noInternetConnection = 'فشل الاتصال بالانترنت';
  static const String unKnown = 'الخطأ غير معروف';
}

extension DataSourceExtension on DataSource {
  Failure getFailure({String? message}) {
    switch (this) {
      case DataSource.success:
        return Failure(ResponseCode.success, ResponseMessage.success);
      case DataSource.noContent:
        return Failure(ResponseCode.noContent, ResponseMessage.noContent);
      case DataSource.badResponse:
        return Failure(
            ResponseCode.badResponse, message ?? ResponseMessage.badResponse);
      case DataSource.forbidden:
        return Failure(ResponseCode.forbidden, ResponseMessage.forbidden);
      case DataSource.unauthorized:
        return Failure(ResponseCode.unauthorized, ResponseMessage.unauthorized);
      case DataSource.notFound:
        return Failure(ResponseCode.notFound, ResponseMessage.notFound);
      case DataSource.internalServerError:
        return Failure(ResponseCode.internalServerError,
            ResponseMessage.internalServerError);
      case DataSource.connectTimeout:
        return Failure(
            ResponseCode.connectTimeOut, ResponseMessage.connectTimeOut);
      case DataSource.cancel:
        return Failure(ResponseCode.cancel, ResponseMessage.cancel);
      case DataSource.receiveTimeout:
        return Failure(
            ResponseCode.receiveTimeOut, ResponseMessage.receiveTimeOut);
      case DataSource.sendTimeOut:
        return Failure(ResponseCode.sendTimeOut, ResponseMessage.sendTimeOut);
      case DataSource.cacheError:
        return Failure(ResponseCode.cacheError, ResponseMessage.cacheError);
      case DataSource.noInternetConnection:
        return Failure(ResponseCode.noInternetConnection,
            ResponseMessage.noInternetConnection);
      case DataSource.unKnown:
        return Failure(ResponseCode.unKnown, ResponseMessage.unKnown);
    }
  }
}

class ApiInternalStatus {
  static const int success = 0;
  static const int failure = 1;
}
