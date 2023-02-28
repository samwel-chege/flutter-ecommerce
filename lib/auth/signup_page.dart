// ignore_for_file: prefer_const_constructors, prefer_typing_uninitialized_variables, empty_catches

import 'dart:convert';

import 'package:ecommerce/shop/product_page.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:progress_dialog_null_safe/progress_dialog_null_safe.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../API/api.dart';
import '../services/functions.dart';

import 'login_page.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);
  static const routeName = '/signup';

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  late TextEditingController username;
  late TextEditingController email;
  late TextEditingController password;

  var encodeddata;
  @override
  void initState() {
    super.initState();
    username = TextEditingController();
    email = TextEditingController();
    password = TextEditingController();
  }

  bool passhidden = true;

  passvisible() {
    setState(() {
      passhidden = !passhidden;
    });
  }

  token(var token) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();

    preferences.setString('token', token);
  }

  Future register(username, email, String password) async {
    try {
      ProgressDialog pr = ProgressDialog(context, isDismissible: false);
      pr.style(message: "Signing you up....");
      pr.show();
      String registerUrl = Api.apiUrl + Api.endpointSignup;
      var data = {"email": email, "name": username, "password": password};
      var responsedata = await httppostsignup(registerUrl, data, context);
      token(jsonEncode(responsedata["token"]));

      Future.delayed(
        Duration(seconds: 2),
        () {
          pr.hide();
        },
      );

      return responsedata;
    } catch (e) {}
  }

  final _signupkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 200,
                    width: 200,
                  ),
                ],
              ),
              Text(
                'Create Your Account',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400),
              ),
              SizedBox(
                height: 20,
              ),
              Form(
                key: _signupkey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Names',
                      style: TextStyle(color: Colors.black),
                    ),
                    TextFormField(
                      decoration: InputDecoration(hintText: "Enter name"),
                      controller: username,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      'Email',
                      style: TextStyle(color: Colors.black),
                    ),
                    TextFormField(
                      decoration: InputDecoration(hintText: "Enter your email"),
                      controller: email,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      'Password',
                      style: TextStyle(color: Colors.black),
                    ),
                    TextFormField(
                      keyboardType: TextInputType.text,
                      textInputAction: TextInputAction.done,
                      controller: password,
                      obscureText: passhidden,
                      style: const TextStyle(color: Colors.grey),
                      decoration: InputDecoration(
                        hintText: "Password",
                        fillColor: Colors.white,
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 5.0, horizontal: 10.0),
                        hintStyle: const TextStyle(color: Colors.grey),
                        enabledBorder: const OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Colors.grey, style: BorderStyle.solid)),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black),
                        ),
                        suffixIcon: IconButton(
                          icon: passhidden
                              ? Icon(
                                  Icons.visibility_off,
                                  color: Colors.blue,
                                )
                              : Icon(
                                  Icons.visibility,
                                  color: Colors.blue,
                                ),
                          onPressed: passvisible,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 30,
              ),
              SizedBox(
                width: double.infinity,
                height: 60,
                child: ElevatedButton(
                  onPressed: () {
                    register(username.text, email.text, password.text);
                  },
                  style:
                      ElevatedButton.styleFrom(backgroundColor: Colors.black),
                  child: Text('Signup'),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Already have an account?'),
                  TextButton(
                      onPressed: () {
                        Navigator.of(context).pushNamed(LoginScreen.routeName);
                      },
                      child: Text('Log in',
                          style: TextStyle(
                            decoration: TextDecoration.underline,
                            color: Colors.black,
                          )))
                ],
              )
            ],
          ),
        ),
      )),
    );
  }
}
