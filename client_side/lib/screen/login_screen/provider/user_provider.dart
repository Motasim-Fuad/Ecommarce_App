import 'package:flutter_login/flutter_login.dart';
import 'package:sad/models/api_response.dart';
import 'package:sad/utility/snack_bar_helper.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../core/data/data_provider.dart';
import '../../../models/user.dart';
import '../../../services/http_services.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../../../utility/constants.dart';


class UserProvider extends ChangeNotifier {
  HttpService service = HttpService();
  final DataProvider _dataProvider;
  final box = GetStorage();

  UserProvider(this._dataProvider);

  Future<String> login(LoginData data) async{
    try{
      Map<String,dynamic> user = {"name":data.name!.toLowerCase(),"password":data.password};
      final response = await service.addItem(endpointUrl: "users/login", itemData: user);
      print(response.statusCode);
      if(response.statusCode == 200){
        final ApiResponse<User> apiResponse =
          ApiResponse<User>.fromJson(response.body,(json)=>User.fromJson(json as Map<String,dynamic>));
        if(apiResponse.success == true){
          SnackBarHelper.showSuccessSnackBar(apiResponse.message);
          User? user = apiResponse.data;
          saveLoginInfo(user);
          return 'Login Success';
        }else{
          SnackBarHelper.showErrorSnackBar("Login Failed: ${apiResponse.message}");
          return 'Login Failed';
        }
      }else{
        SnackBarHelper.showErrorSnackBar("Error ${response.body["message"]}");
        return 'Login Failed';
      }
    }catch(error){
      SnackBarHelper.showErrorSnackBar("Login Failed: $error");
      return 'An error occurred';
    }
  }

  Future<String> register(SignupData data) async{
    try{
      Map user = {"name":data.name!.toLowerCase(),"password":data.password};
      final response = await service.addItem(endpointUrl: "users/register", itemData: user);
      print("status: ${response.statusCode}");
      if(response.statusCode == 200){
        ApiResponse apiResponse = ApiResponse.fromJson(response.body, null);
        if(apiResponse.success == true){
          // SnackBarHelper.showSuccessSnackBar(apiResponse.message);
          return 'Register Success';
        }else{
          SnackBarHelper.showErrorSnackBar("Register Failed: ${apiResponse.message}");
          return 'Register Failed';
        }
      }else{
        SnackBarHelper.showErrorSnackBar("Error ${response.body["message"]}");
        return 'Register Failed';
      }
    }catch(error){
      SnackBarHelper.showErrorSnackBar("Register Failed: $error");
      return 'An error occurred';
    }
  }

  Future<void> saveLoginInfo(User? loginUser) async {
    await box.write(USER_INFO_BOX, loginUser?.toJson());
    Map<String, dynamic>? userJson = box.read(USER_INFO_BOX);
  }

  User? getLoginUsr() {
    Map<String, dynamic>? userJson = box.read(USER_INFO_BOX);
    User? userLogged = User.fromJson(userJson ?? {});
    return userLogged;
  }

  logOutUser() async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString("userId", '');

    // box.remove(USER_INFO_BOX);
    // Get.offAll(const LoginScreen());
  }
}
