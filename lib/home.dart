import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gx_file_picker/gx_file_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:your_drive/database.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Database db = Database();

  String selected_file;
  Future<String> pickfile() async {
    var result = await FilePicker.getFilePath();
    if (result != null) {
      selected_file = result;
      var index = selected_file.lastIndexOf('/');
      return selected_file = selected_file.substring(index + 1);
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();

    done();
  }

  void done() async {
    await db.prefs.setString(db.currentuserkey, db.kcurrentuser);
    await db.prefs.setStringList(db.kcurrentuser, mfiles);
    k = db.kcurrentuser;
  }

  @override
  void deactivate() {
    super.deactivate();
    done();
  }

  Future<String> getdata() async {
    db.prefs = await SharedPreferences.getInstance();

    db.kusername = db.prefs.getStringList(db.userskey);
    db.kpassword = db.prefs.getStringList(db.passwordkey);
    db.kemail = db.prefs.getStringList(db.emailkey);
    db.kcurrentuser = db.prefs.getString(db.currentuserkey);
    db.kfiles = db.prefs.getStringList(db.kcurrentuser);
    return db.kcurrentuser;
  }

  void logout() async {
    k = null;
    await db.prefs.setString(db.currentuserkey, "");
  }

  void add(String s) async {
    db.prefs = await SharedPreferences.getInstance();
    db.kcurrentuser = db.prefs.getString(db.currentuserkey);
    db.kfiles = db.prefs.getStringList(db.kcurrentuser);
    db.kfiles.add(s);
    await db.prefs.setStringList(db.kcurrentuser, db.kfiles);
  }

  @override
  Widget build(BuildContext context) {
    var device = MediaQuery.of(context);
    getdata();
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.white,
        body: Home1(),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () async {
            var s = await pickfile();
            // setState(() {
            //   List<String> a = files['hsinha610'];
            //   a.add(s);
            // });
            if (s != null) {
              setState(() {
                mfiles.add(s);
                add(s);
              });
            }
          },
          label: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Text("Upload"),
              SizedBox(
                width: 2,
              ),
              FaIcon(
                FontAwesomeIcons.file,
                size: 20,
              ),
            ],
          ),
          backgroundColor: Colors.redAccent[200],
        ),
        appBar: AppBar(
          title: Text(
            "Your Drive",
            style: TextStyle(
                color: Colors.redAccent[200],
                fontWeight: FontWeight.bold,
                fontSize: 25),
          ),
          backgroundColor: Colors.white,
          actions: <Widget>[
            Padding(
              padding: const EdgeInsets.only(right: 30),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  FutureBuilder(
                    future: getdata(),
                    builder: (context, snap) {
                      if (snap.connectionState != ConnectionState.done) {
                        return CircularProgressIndicator();
                      } else {
                        return Text(
                          "User: ${snap.data.toString() ?? ""}",
                          style: TextStyle(
                              color: Colors.redAccent[200],
                              fontWeight: FontWeight.bold,
                              fontSize: 15),
                        );
                      }
                    },
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.pushReplacementNamed(context, '/');
                    },
                    child: Text(
                      " LogOut ",
                      style: TextStyle(
                          backgroundColor: Colors.redAccent[200],
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 14),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Home1 extends StatefulWidget {
  @override
  _Home1State createState() => _Home1State();
}

class _Home1State extends State<Home1> {
  Database db = Database();
  @override
  void initState() {
    super.initState();
  }

  Future<void> getdata() async {
    db.prefs = await SharedPreferences.getInstance();
    db.kcurrentuser = db.prefs.getString(db.currentuserkey);
    db.kfiles = db.prefs.getStringList(db.kcurrentuser);
  }

  @override
  Widget build(BuildContext context) {
    getdata();
    if (mfiles.length == null) {
      return Container(
        child: FaIcon(
          FontAwesomeIcons.reddit,
          color: Colors.redAccent,
        ),
      );
    } else {
      return ListView.builder(
        itemBuilder: (context, index) {
          int i = mfiles[index].lastIndexOf(".");
          return ListTile(
            title: Text(
              mfiles[index].substring(0, i),
            ),
            subtitle: Text(mfiles[index].substring(i + 1)),
            trailing: mfiles[index].substring(i + 1) == "jpg"
                ? FaIcon(FontAwesomeIcons.image)
                : mfiles[index].substring(i + 1) == "mp4"
                    ? FaIcon(FontAwesomeIcons.video)
                    : mfiles[index].substring(i + 1) == "m4a"
                        ? FaIcon(FontAwesomeIcons.fileAudio)
                        : FaIcon(FontAwesomeIcons.file),
          );
        },
        itemCount: mfiles == null ? 0 : mfiles.length,
      );
    }
  }
}
