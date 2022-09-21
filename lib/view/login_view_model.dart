import 'package:flutter/material.dart';
import 'package:tryproject/view/login.dart';
import '../core/shared_manager.dart';
import '../home/main_menu.dart';
import '../model/user_request_model.dart';
import '../services/login_service.dart';

abstract class LoginViewModel extends State<Login> {
  
  late final LoginService loginService;
  
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loginService = LoginService();
  }

  Future fetchUserLogin(String email, String password) async {
    final response = await loginService
        .fetchPostLogin(UserRequestModel(email: email, password: password));
    if (response != null) {
      SharedManager.instance.saveToken(response.data!.token ?? "");
      SharedManager.instance.savePicture(response.data!.profilePic ?? "");


      navigateToHome();
    } else {
      return Exception('login error');
    }
  }

  void navigateToHome() {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => const MainManuView()));
  }
  


}
