import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:flutterchatapp/widget/auth_form.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({Key? key}) : super(key: key);

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}
FirebaseAuth _auth = FirebaseAuth.instance;
class _AuthScreenState extends State<AuthScreen> {
  void _submitAuthForm(
       String email,
       String password, 
       String username,
       bool isLogin) async{
        var authResult;
        if(isLogin){
         authResult = await _auth.signInWithEmailAndPassword(
          email: email,
          password: password);

        }else{
          authResult = await _auth.createUserWithEmailAndPassword(
            email: email,
            password: password);

        }
       }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: AuthForm(_submitAuthForm),
    );
  }
}
