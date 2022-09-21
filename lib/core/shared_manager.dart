import 'package:shared_preferences/shared_preferences.dart';


class SharedManager    {
static SharedManager? _instance;

SharedPreferences? _prefs;

static SharedManager get instance=>_instance??SharedManager._init();



Future<SharedPreferences> get _prefInst async => _prefs??await SharedPreferences.getInstance(); 

SharedManager._init();
     
   
 
      // call this method from iniState() function of mainApp().
        Future<SharedPreferences?> init() async {
       return _prefs=await _prefInst;
        
      }
      Future<void> clearInit() async {
        var pref=await _prefInst;
        
          await pref.clear();
          
      
    
      }

 
    Future<bool> saveToken(String token) async {
    var pref=await _prefInst;
      pref.setString(CacheManagerKey.TOKEN.toString(), token);
    return true;
  }
     Future<String?> getToken() async {
 var pref=await _prefInst;

  return pref.getString(CacheManagerKey.TOKEN.toString());

   }
    Future<bool> savePicture(String picture) async {
    var pref=await _prefInst;
      pref.setString(ProfilPictureKey.PICTURE.toString(), picture);
    return true;
  }
     Future<String?> getPicture() async {
 var pref=await _prefInst;

  return pref.getString(ProfilPictureKey.PICTURE.toString());

   }
}




enum CacheManagerKey{TOKEN}
enum ProfilPictureKey{PICTURE}
