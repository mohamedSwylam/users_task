import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'network_constants.dart';

const String applicationJson = 'application/json';
const String contentType = 'content-type';
const String accept = 'accept';
const String authorization = 'authorization';
const String defaultLanguage = 'language';

class DioFactory {
  static Dio? dio;
  DioFactory();
  static Dio getDioo() {
    Duration timeOut = const Duration(seconds: 30);

    if (dio == null) {
      dio = Dio();
      dio!
        ..options.connectTimeout = timeOut
        ..options.receiveTimeout = timeOut;
      addDioInterceptor();
      return dio!;
    } else {
      return dio!;
    }
  }

  static void addDioInterceptor() {
    dio?.interceptors.add(
      PrettyDioLogger(
        requestBody: true,
        requestHeader: true,
        responseHeader: true,
      ),
    );
  }
  Future<Dio> getDio() async {
    Dio dio = Dio();
    dio.options = BaseOptions(
        baseUrl: NetworkConstants.baseUrl,
        receiveDataWhenStatusError: true,
        receiveTimeout:
            const Duration(milliseconds: NetworkConstants.apiTimeOut),
        sendTimeout: const Duration(milliseconds: NetworkConstants.apiTimeOut));

    dio.interceptors.add(PrettyDioLogger(
        requestHeader: true, requestBody: true, responseHeader: true));
    return dio;
  }

}
