import 'package:perfection_task/core/di/dependcy_injection.dart';

import '../../../core/networking/dio_factory.dart';
import '../../../core/networking/network_info.dart';

abstract class BaseRepository {
  late NetworkInfo networkInfo;
  late DioFactory dio;

  BaseRepository(){
    networkInfo=getIt.get<NetworkInfo>();
    dio=getIt.get<DioFactory>();
  }
}