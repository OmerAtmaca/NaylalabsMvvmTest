
import 'package:shared_preferences/shared_preferences.dart';


class SharedManager {
  static SharedManager? _instance;

SharedPreferences? prefs;

  SharedManager._init();

  static SharedManager get instance => _instance??SharedManager._init();

  Future<SharedPreferences> get _prefInst async => prefs??await SharedPreferences.getInstance();

  Future<SharedPreferences> init() async {
   return prefs = await SharedPreferences.getInstance();
  }

  Future<bool> saveStringValue(SharedKeys key, String value) async {
    var prefss=await _prefInst;
    return  prefss.setString(key.toString(), value);
  }

  
  Future<String?> getStringValue(SharedKeys key)  async {
    var prefss=await _prefInst;
    return prefss.getString(key.toString());

    
  }
   Future<bool> saveBoolValue(SharedKeys key, bool value) async {
    var prefss=await _prefInst;
    return  prefss.setBool(key.toString(), value);
  }

  
  Future<bool?> getBoolValue(SharedKeys key)  async {
    var prefss=await _prefInst;
    return prefss.getBool(key.toString());

    
  }


}

enum SharedKeys { TOKEN, PICTURE,ISCLICK }
