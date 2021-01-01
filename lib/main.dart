import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'database.dart';
import 'home.dart';
import 'login_page.dart';
import 'sign_up_page.dart';

void main() async {
  var mySystemTheme = SystemUiOverlayStyle.light.copyWith(
      statusBarColor: Colors.redAccent[100],
      systemNavigationBarColor: Colors.redAccent[100],
      statusBarIconBrightness: Brightness.dark,
      systemNavigationBarDividerColor: Colors.blue);

  SystemChrome.setSystemUIOverlayStyle(mySystemTheme);

  WidgetsFlutterBinding.ensureInitialized();
  Database db = Database();
  db.prefs = await SharedPreferences.getInstance();

  if (db.prefs.getString("firstTime") == null) {
    await db.prefs.setStringList(db.userskey, [""]);
    await db.prefs.setStringList(db.emailkey, [""]);
    await db.prefs.setStringList(db.passwordkey, [""]);
    await db.prefs.setString(db.currentuserkey, "");
    await db.prefs.setString("firstTime", "No");
  }

  print(db.prefs.getString(db.currentuserkey));

  runApp(App());
}

class App extends StatelessWidget {
  Database db = Database();

  void getdata() async {
    db.prefs = await SharedPreferences.getInstance();

    k = db.prefs.getString(db.currentuserkey);

    print(db.prefs.getString(db.currentuserkey) + "1");
  }

  @override
  Widget build(BuildContext context) {
    getdata();
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: k == null ? '/' : '/home',
      routes: {
        '/': (BuildContext context) => LoginPage(),
        '/signup': (BuildContext context) => SignUpPage(),
        '/home': (BuildContext context) => Home(),
        '/login': (BuildContext context) => LoginPage(),
      },
    );
  }
}
