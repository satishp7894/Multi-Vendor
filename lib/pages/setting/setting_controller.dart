import 'package:eshoperapp/repository/api_repository.dart';
import 'package:eshoperapp/repository/local_repository.dart';
import 'package:get/state_manager.dart';

class SettingController extends GetxController {
  final LocalRepositoryInterface localRepositoryInterface;
  final ApiRepositoryInterface apiRepositoryInterface;

  SettingController(
      {required this.localRepositoryInterface,
      required this.apiRepositoryInterface});
}
