import 'package:eshoperapp/constants/app_costants.dart';
import 'package:eshoperapp/models/check_login.dart';
import 'package:eshoperapp/models/user.dart';
import 'package:eshoperapp/repository/local_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

const _pref_token = 'TOKEN';
const _pref_username = 'USERNAME';
const _pref_name = 'NAME';

class LocalRepositoryImpl extends LocalRepositoryInterface {
  @override
  clearAllData() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.clear();
  }

  @override
  Future<String?> getToken() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getString(_pref_token);
  }

  @override
  Future<CheckLoginData> getUser() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    final prefCustomerId = sharedPreferences.getString(AppConstants.prefCustomerId!);
    final prefCustomerName = sharedPreferences.getString(AppConstants.prefCustomerName!);
    final prefGender = sharedPreferences.getString(AppConstants.prefGender!);
    final prefMobile = sharedPreferences.getString(AppConstants.prefMobile!);
    final prefEmail = sharedPreferences.getString(AppConstants.prefEmail!);
    final prefPassword = sharedPreferences.getString(AppConstants.prefPassword!);
    final prefShowPassword = sharedPreferences.getString(AppConstants.prefShowPassword!);
    // final prefCreatedBy = sharedPreferences.getString(AppConstants.prefCreatedBy!);
    // final prefModifiedBy = sharedPreferences.getString(AppConstants.prefModifiedBy!);
    final prefCreated = sharedPreferences.getString(AppConstants.prefCreated!);
    final prefModified = sharedPreferences.getString(AppConstants.prefModified!);
    final prefIsActive = sharedPreferences.getString(AppConstants.prefIsActive!);

    final checkLoginData = CheckLoginData(
      customerId: prefCustomerId,
      customerName: prefCustomerName,
      gender: prefGender,
      mobile: prefMobile,
      email: prefEmail,
      password: prefPassword,
      showPassword: prefShowPassword,
      // createdBy: prefCreatedBy,
      // modifiedBy: prefModifiedBy,
      created: prefCreated,
      modified: prefModified,
      isActive: prefIsActive,

    );
    return checkLoginData;
  }

  @override
  Future<CheckLoginData?> saveUser(CheckLoginData? checkLoginData) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString(AppConstants.prefCustomerId!, checkLoginData!.customerId!);
    sharedPreferences.setString(AppConstants.prefCustomerName!, checkLoginData.customerName!);
    sharedPreferences.setString(AppConstants.prefGender!, checkLoginData.gender!);
    sharedPreferences.setString(AppConstants.prefMobile!, checkLoginData.mobile!);
    sharedPreferences.setString(AppConstants.prefEmail!, checkLoginData.email!);
    sharedPreferences.setString(AppConstants.prefPassword!, checkLoginData.password!);
    sharedPreferences.setString(AppConstants.prefShowPassword!, checkLoginData.showPassword!);
    // sharedPreferences.setString(AppConstants.prefCreatedBy!, checkLoginData.createdBy!);
    // sharedPreferences.setString(AppConstants.prefModifiedBy!, checkLoginData.modifiedBy!);
    sharedPreferences.setString(AppConstants.prefCreated!, checkLoginData.created!);
    sharedPreferences.setString(AppConstants.prefModified!, checkLoginData.modified!);
    sharedPreferences.setString(AppConstants.prefIsActive!, checkLoginData.isActive!);
    return checkLoginData;
  }

  @override
  Future<void> saveToken(String? token) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString(_pref_token, token!);
  }
}
