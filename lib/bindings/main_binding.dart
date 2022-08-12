// import 'package:eshoperapp/network/api_repository_impl.dart';
import 'package:eshoperapp/network/api_repository_impl.dart';
import 'package:eshoperapp/network/local_repository_impl.dart';
import 'package:eshoperapp/repository/api_repository.dart';
// import 'package:eshoperapp/repository/api_repository.dart';
import 'package:eshoperapp/repository/local_repository.dart';
import 'package:get/get.dart';

class MainBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LocalRepositoryInterface>(() => LocalRepositoryImpl());
    Get.lazyPut<ApiRepositoryInterface>(() => ApiRepositoryImpl());
  }
}
