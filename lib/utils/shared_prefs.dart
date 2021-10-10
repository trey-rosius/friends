import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
class SharedPrefsUtils extends ChangeNotifier{
  static const String userid ="userId";
  Future<SharedPreferences> _prefs;
  SharedPrefsUtils.instance() :_prefs = SharedPreferences.getInstance();

  Future<void>saveUserId(String userId){

   return  _prefs.then((SharedPreferences sharedPreferences) {
      sharedPreferences.setString(userid, userId);
    });
  }


Future<String?>getUserId(){
  return  _prefs.then((SharedPreferences sharedPreferences) {
    String? userId = sharedPreferences.getString(userid);
    return userId;
  });
}
Future<void>deleteAllKeys(){
   return  _prefs.then((SharedPreferences sharedPreferences){
      sharedPreferences.clear();
    });
}

}