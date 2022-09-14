import 'dart:io';

import 'package:flutter/material.dart';
import '../pickers/user_image_picker.dart';

class AuthForm extends StatefulWidget {
  AuthForm(this.submitFn, this.isLoading);

  final void Function(
    String email,
    String password,
    String username,
    File image,
    bool isLogin,
    BuildContext context,
  ) submitFn;
  final bool isLoading;

  @override
  State<AuthForm> createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  final _formKey = GlobalKey<FormState>();
  bool _isLogin = true;
  String _userEmail = '';
  String _userName = '';
  String _userPassword = '';
  File _userImageFile;

  void _pickedImage(File image) {
    _userImageFile = image;
  }

  void _trySubmit() {
    final isValid = _formKey.currentState.validate();
    FocusScope.of(context).unfocus();

    if (_userImageFile == null && !_isLogin) {
      Scaffold.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Please Pick An Image',
            textAlign: TextAlign.center,
          ),
          duration: Duration(seconds: 3),
          backgroundColor: Theme.of(context).errorColor,
        ),
      );
      return;
    }

    if (isValid) {
      _formKey.currentState.save();
      widget.submitFn(
        _userEmail.trim(),
        _userPassword.trim(),
        _userName.trim(),
        _userImageFile,
        _isLogin,
        context,
      );

      //...

    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: AnimatedContainer(
        duration: Duration(milliseconds: 300),
        height: _isLogin ? 315 : 520,
        child: Card(
          elevation: 5,
          margin: EdgeInsets.all(25),
          child: SingleChildScrollView(
            padding: EdgeInsets.all(15),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  AnimatedContainer(
                    duration: Duration(milliseconds: 300),
                    height: _isLogin ? 0 : 150,
                    child:
                        _isLogin ? Container() : UserImagePicker(_pickedImage),
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Email Address'),
                    key: ValueKey('email'),
                    onSaved: (value) {
                      _userEmail = value;
                    },
                    validator: (value) {
                      if (value.isEmpty || !value.contains('@')) {
                        return 'Please enter a valid email address';
                      }
                      return null;
                    },
                    keyboardType: TextInputType.emailAddress,
                  ),
                  AnimatedContainer(
                    duration: Duration(milliseconds: 300),
                    height: _isLogin ? 0 : 60,
                    child: !_isLogin
                        ? TextFormField(
                            decoration: InputDecoration(labelText: 'Username'),
                            key: ValueKey('username'),
                            onSaved: (value) {
                              _userName = value;
                            },
                            validator: (value) {
                              if (value.isEmpty || value.length < 4) {
                                return 'Please enter at least 4 characters';
                              }
                              return null;
                            },
                          )
                        : Container(),
                  ),
                  Container(
                    height: 0,
                    width: 0,
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Password'),
                    key: ValueKey('password'),
                    onSaved: (value) {
                      _userPassword = value;
                    },
                    validator: (value) {
                      if (value.isEmpty || value.length < 7) {
                        return 'Password must be at least 7 characteres long';
                      }
                      return null;
                    },
                    obscureText: true,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  if (widget.isLoading) CircularProgressIndicator(),
                  if (!widget.isLoading)
                    RaisedButton(
                      child: Text(_isLogin ? 'Login' : 'Signup '),
                      onPressed: _trySubmit,
                    ),
                  if (!widget.isLoading)
                    FlatButton(
                      textColor: Theme.of(context).primaryColor,
                      child: Text(_isLogin
                          ? 'Create New Acount'
                          : 'I already have an acount'),
                      onPressed: () {
                        setState(() {
                          _isLogin = !_isLogin;
                        });
                      },
                    ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
