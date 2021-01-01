import 'package:shared_preferences/shared_preferences.dart';

class Database {
  SharedPreferences prefs;
  List<String> kusername;
  List<String> kpassword;
  List<String> kemail;
  String kcurrentuser;

  String userskey = "Username";
  String passwordkey = "Password";
  String emailkey = "Email";
  String currentuserkey = "CurrentUser";

  List<String> kfiles;
}

List<String> mfiles = [];

String k = null;
