import 'package:campus_assistance/providers/loginProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'auth.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  dynamic name = prefs.get('name');
  dynamic imageUrl = prefs.get('imageUrl');
  dynamic username = prefs.get('username');
  dynamic password = prefs.get('password');
  dynamic lnctu = prefs.get('lnctu');
  dynamic branch = prefs.get('branch');
  dynamic semester = prefs.get('semester');
  dynamic gender = prefs.get('gender');
  Map data = {
    'name': name,
    'imageUrl': imageUrl,
    'username': username,
    'password': password,
    'lnctu': lnctu,
    'branch': branch,
    'semester': semester,
    'gender': gender
  };
  var key;
  runApp(
    Provider(
        create: (_) => LoginProvider(data),
        child: MaterialApp(
            theme: ThemeData.dark(),
            home: Auth(
              data: data,
              key: key,
            ))),
  );
}
