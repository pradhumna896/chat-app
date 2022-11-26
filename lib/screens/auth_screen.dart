import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:flutterchatapp/widget/auth_form.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({Key? key}) : super(key: key);

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

FirebaseAuth _auth = FirebaseAuth.instance;

class _AuthScreenState extends State<AuthScreen> {
  bool _isloading=false;
  void _submitAuthForm(
      String email,
       String username,
        String password,
         bool isLogin,
         BuildContext ctx
         ) async {
    var authResult;
    try {
      setState(() {
        _isloading=true;
      });
      if (isLogin) {
        authResult = await _auth.signInWithEmailAndPassword(
            email: email, password: password);
      } else {
        authResult = await _auth.createUserWithEmailAndPassword(
            email: email, password: password);
        await FirebaseFirestore.instance.collection("Users").doc(authResult.user.uid).set({
            "username":username,
            "email":email
        });    
      }
    } on PlatformException catch (err) {
      setState(() {
        _isloading=false;
      });
      var message = "An error occurred , please check your credentials!";
      if (err.message != null) {
        message = err.message.toString();
      }
      ScaffoldMessenger.of(ctx)
          .showSnackBar(
            SnackBar(content: Text(message)));
    } catch(err){
      setState(() {
        _isloading=false;
      });
      ScaffoldMessenger.of(ctx)
          .showSnackBar(
            SnackBar(content: Text(err.toString())));
      print(err);      
     
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme
      .of(context).backgroundColor,
      body: AuthForm(_submitAuthForm,_isloading),
    );
  }
}