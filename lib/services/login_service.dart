import 'dart:convert';
import 'dart:io';
import '../model/stories_model.dart';
import '../core/shared_manager.dart';
import 'package:http/http.dart' as http;
import '../model/user_request_model.dart';
import '../model/user_response_model.dart';

class LoginService   {
  final String _loginPath = "auth/login";
  final String _stories = "stories";
  final String _loginURL = "https://api.superstars.co/api/";



  Future<UserResponseModel?> fetchPostLogin(UserRequestModel model) async {
    final response = await http.post(
      Uri.parse(_loginURL + _loginPath),
      body: jsonEncode(model),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    if (response.statusCode == HttpStatus.ok) {
      return UserResponseModel.fromJson(jsonDecode(response.body));
    }
    return null;
  }

  Future<StoriesModel?> fetchGetStories(String token) async {
    final response = await http.get(Uri.parse(_loginURL + _stories),
        headers: {'Authorization': token});

    //  final jsonResponselist=jsonResponse['data'];
    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(response.body);
      return StoriesModel.fromJson(jsonResponse);
    } else {
      return throw Exception('Failed to create album.');
    }
  }

  Future<List<Data>?> fetchUserGetLogin() async {

   
    var token = await SharedManager.instance.getToken() ?? "";
    
    final response = await fetchGetStories(token);

    try {
      if (response != null) {
        // story=response;
        if (response.statusCode == 200) {
          return response.data;
        }
      }
      throw Exception(response);
    } catch (e) {
       Exception(e);
     return Future.error(e);
    }
  }

 
}
