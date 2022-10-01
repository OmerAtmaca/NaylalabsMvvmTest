import 'package:flutter/material.dart';
import 'package:tryproject/mvvm/login.dart';
import '../core/shared_manager.dart';
import '../view/main_menu.dart';
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

  Future userLoginToPage(String email, String password) async {
  
  var response=await loginService.fetchUserLogin(email,password);
  if (response!=null) {
    navigateToHome();
  }
  
  }

  void navigateToHome() {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => const MainManuView()));
  }
  



}
