import 'package:campus_assistance/screens/loginscreen.dart';
import 'package:flutter/material.dart';

import 'home.dart';

class Auth extends StatelessWidget {
  final Map data;
  const Auth({required Key key, required this.data}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    print('Auth built');
    if (data['username'] == null) {
      return LoginScreen();
    }
    return Main();
  }
}
