import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutterchatapp/widget/user_image_picker.dart';
import 'package:image_picker/image_picker.dart';

class AuthForm extends StatefulWidget {
  AuthForm(this.submitfn, this.isLoading);
  final bool isLoading;
  final void Function(
    String email, 
    String password,
    String userName,
    XFile image,
      bool isLogin, BuildContext ctx) submitfn;

  @override
  State<AuthForm> createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  final _formKey = GlobalKey<FormState>();
  var _islogin = true;
  String _userEmail = "";
  String _userName = '';
  String _userPassword = "";
  XFile? _userImageFile;
  void _pickedImage(XFile image) {
    _userImageFile = image;
  }

  void 
  _trySubmit() {
    final isValid = _formKey.currentState!.validate();
    FocusScope.of(context).unfocus();
    if (_userImageFile == null && !_islogin) {
      Scaffold.of(context)
          .showSnackBar(SnackBar(content: Text("Please pick an image")));
      return;
    }
    if (isValid && _userImageFile != null) {
      _formKey.currentState!.save();
      widget.submitfn(
        _userEmail.trim(),
        _userName.trim(),
        _userPassword.trim(),
        _userImageFile!,
        _islogin,
        context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        margin:const EdgeInsets.all(20),
        child: SingleChildScrollView(
            child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (!_islogin) UserImagePicker(_pickedImage),
                  TextFormField(
                    key: ValueKey("email address"),
                    validator: ((value) {
                      if (value!.isEmpty || !value.contains("@")) {
                        return 'Please enter a valid email address';
                      }
                      return null;
                    }),
                    onSaved: (newValue) {
                      _userEmail = newValue!;
                    },
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(label: Text("Email Address")),
                  ),
                  if (!_islogin)
                    TextFormField(
                      key: ValueKey("name"),
                      onSaved: (newValue) {
                        _userName = newValue!;
                      },
                      validator: (value) {
                        if (value!.isEmpty || value.length < 4) {
                          return "Please enter at least 4 charecters";
                        }
                        return null;
                      },
                      decoration: InputDecoration(label: Text("Username")),
                    ),
                  TextFormField(
                    key: ValueKey("Password"),
                    onSaved: (newValue) {
                      _userPassword = newValue!;
                    },
                    validator: ((value) {
                      if (value!.isEmpty || value.length < 7) {
                        return 'Password must be at least 7 characters long.';
                      }
                      return null;
                    }),
                    obscureText: true,
                    decoration: const InputDecoration(label: Text("Password")),
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  if (widget.isLoading) const CircularProgressIndicator(),
                  if (!widget.isLoading)
                    ElevatedButton(
                        onPressed: _trySubmit,
                        child: Text(_islogin ? "Login" : "SignUp")),
                  TextButton(
                      onPressed: () {
                        setState(() {
                          print(_islogin);
                          _islogin = !_islogin;
                        });
                      },
                      child: Text(_islogin
                          ? "Create new Account"
                          : "I already have an account"))
                ],
              )),
        )),
      ),
    );
  }
}
