import 'dart:convert';
import 'dart:io';
import 'package:tryproject/model/story_comments_model.dart';
import '../model/stories_model.dart';
import '../core/shared_manager.dart';
import 'package:http/http.dart' as http;
import '../model/user_request_model.dart';
import '../model/user_response_model.dart';

class LoginService {
  final List<Data> listData = [];

  final String _loginPath = "auth/login";
  final String _stories = "stories";
  final String _loginURL = "https://api.superstars.co/api/";

  Future fetchUserLogin(String email, String password) async {
    final response = await fetchPostLogin(
        UserRequestModel(email: email, password: password));
    if (response != null) {
      SharedManager.instance
          .saveStringValue(SharedKeys.TOKEN, response.data!.token ?? "");

      SharedManager.instance
          .saveStringValue(SharedKeys.PICTURE, response.data!.profilePic ?? "");
    } else {
      return Exception('login error');
    }
  }

  Future<UserResponseModel?> fetchPostLogin(UserRequestModel model) async {
    try {
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
      
    } catch (_) {
      
    }
    
    return null;
  }

  Future<StoriesModel?> fetchGetStories(String token) async {
    try {
      final response = await http.get(Uri.parse(_loginURL + _stories),
        headers: {'Authorization': token});

    //  final jsonResponselist=jsonResponse['data'];
    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(response.body);
      return StoriesModel.fromJson(jsonResponse);
    } 
    } catch (_) {
      
    }
    return null;
  }

  Future<List<CommentData>?> fetchGetStoriesComment(String userId) async {
    try {
      var token = await SharedManager.instance.getStringValue(SharedKeys.TOKEN);
    final response = await http
        .get(Uri.parse(_loginURL + 'stories/' + userId + '/comments'), headers: {'Authorization': token.toString()});

    if (response.statusCode == 200) {
      final responseBody = jsonDecode(response.body);
      final jsonResponse = StoryComment.fromJson(responseBody);
      final responseData = jsonResponse.data;

      return responseData;
    }
    } catch (_) {
      
    }
     return null;
  }

  Future<List<Data>?> fetchUserGetLogin() async {
    
    try {
      var token = await SharedManager.instance.getStringValue(SharedKeys.TOKEN);
      final response = await fetchGetStories(token ?? "");
      if (response != null) {
        if (response.statusCode == 200) {
          if (response.data != null) {
            return response.data;
          }
        }
      }
      throw Exception(response);
    } catch (_) {
     
    }
    return null;
  }
}
