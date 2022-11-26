import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class AuthForm extends StatefulWidget {
  const AuthForm({Key? key}) : super(key: key);

  @override
  State<AuthForm> createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  final _formKey = GlobalKey<FormState>();
  var _islogin = true;
  String _userEmail="";
  String _userName = '';
  String _userPassword = "";


  void _trySubmit(){
    final isValid = _formKey.currentState!.validate();
    FocusScope.of(context).unfocus();
    if(isValid){
      _formKey.currentState!.save();
      print(_userEmail);
      print(_userName);
      print(_userPassword);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        margin: EdgeInsets.all(20),
        child: SingleChildScrollView(
            child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
              child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                validator: ((value) {
                  if(value!.isEmpty || !value.contains("@")){
                    return 'Please enter a valid email address';
                  }
                  return null;
                }),
                onSaved: (newValue) {
                  _userEmail= newValue!;
                },
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(label: Text("Email Address")),
              ),
              if(!_islogin)
              TextFormField(
                 onSaved: (newValue) {
                  _userName= newValue!;
                },
                validator: (value) {
                  if(value!.isEmpty || value.length<4){
                    return "Please enter at least 4 charecters";
                  }
                  return null;
                },
                decoration: InputDecoration(label: Text("Username")),
              ),
              TextFormField(
                 onSaved: (newValue) {
                  _userPassword= newValue!;
                },
                validator: ((value) {
                   if(value!.isEmpty || value.length<7){
                    return 'Password must be at least 7 characters long.';
                  }
                  return null;
                
                }),
                obscureText: true,
                decoration: InputDecoration(label: Text("Password")),
              ),
              SizedBox(
                height: 12,
              ),
              ElevatedButton(onPressed: _trySubmit, child: Text(_islogin?"Login":"SignUp")),
              TextButton(onPressed: (){
                setState(() {
                  _islogin= !_islogin;
                });
              }, child: Text(_islogin?"Create new Account":"I already have an account"))
            ],
          )),
        )),
      ),
    );
  }
}
