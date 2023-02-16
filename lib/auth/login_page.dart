import 'dart:convert';

import 'package:ecommerce/auth/signup_page.dart';
import 'package:flutter/material.dart';
import 'package:progress_dialog_null_safe/progress_dialog_null_safe.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../shop/product_page.dart';

import '../API/api.dart';
import '../services/functions.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);
  static const routeName = '/login';
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late TextEditingController email;

  late TextEditingController username;

  late TextEditingController password;
  // late Validation val;
  @override
  void initState() {
    super.initState();
    email = TextEditingController();
    username = TextEditingController();
    password = TextEditingController();
  }

  bool passhidden = true;

  passvisible() {
    setState(() {
      passhidden = !passhidden;
    });
  }

  token(token) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();

    preferences.setString('token', token);
  }

  bool unchecked = false;

  SnackBar snackBar(message, color) {
    return SnackBar(
        duration: const Duration(seconds: 4),
        backgroundColor: color,
        content: Text(
          message,
          style: const TextStyle(fontSize: 18),
        ));
  }

  Future login(email, username, password) async {
    ProgressDialog pr = ProgressDialog(context, isDismissible: false);
    pr.style(message: 'Logging you in...');
    try {
      pr.show();
      String loginUrl = Api.apiUrl + Api.endpointLogin;

      var data = {"email": email, "name": username, "password": password};

      var responsedata = await httppostlogin(loginUrl, data, context);

      token(jsonEncode(responsedata["token"]));

      Future.delayed(
        Duration(seconds: 2),
        () {
          pr.hide();
        },
      );
    } catch (e) {}
  }

  final _logformkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
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
                    // child: Image.asset('assets/images/logo.png'),
                  ),
                ],
              ),
              Text(
                'Login to your account ',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.w600),
              ),
              SizedBox(
                height: 30,
              ),
              Form(
                key: _logformkey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Name',
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
                    SizedBox(
                      height: 80,
                      child: TextFormField(
                        keyboardType: TextInputType.text,
                        textInputAction: TextInputAction.done,
                        controller: password,
                        // validator: val.passwordval,
                        obscureText: passhidden,
                        style: const TextStyle(color: Colors.grey),
                        decoration: InputDecoration(
                          hintText: "Password",
                          fillColor: Colors.white,
                          hintStyle: const TextStyle(color: Colors.grey),
                          enabledBorder: const OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Colors.grey,
                                  style: BorderStyle.solid)),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.black,
                            ),
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
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: double.infinity,
                height: 45,
                child: ElevatedButton(
                  onPressed: () {
                    // if (_logformkey.currentState!.validate()) {

                    login(email.text, username.text, password.text);
                    // }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    foregroundColor: Colors.white,
                  ),
                  child: const Text('Login'),
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Don\'t have an account?'),
                  TextButton(
                      onPressed: () {
                        Navigator.of(context).pushNamed(SignUpScreen.routeName);
                      },
                      child: Text(
                        'Sign up',
                        style: TextStyle(
                            decoration: TextDecoration.underline,
                            color: Colors.black),
                      ))
                ],
              )
            ],
          ),
        ),
      )),
    );
  }
}
