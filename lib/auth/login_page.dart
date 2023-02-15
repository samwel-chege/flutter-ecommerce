import 'dart:convert';

import 'package:ecommerce/auth/signup_page.dart';
import 'package:flutter/material.dart';

import '../shop/product_page.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);
  static const routeName = '/login';
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late TextEditingController email;

  late TextEditingController phone;
  late TextEditingController phonereset;

  late TextEditingController password;
  // late Validation val;
  @override
  void initState() {
    super.initState();
    email = TextEditingController();
    phone = TextEditingController();
    phonereset = TextEditingController();
    password = TextEditingController();
  }

  bool passhidden = true;

  passvisible() {
    setState(() {
      passhidden = !passhidden;
    });
  }

  bool unchecked = false;

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
                      'Email',
                      style: TextStyle(color: Colors.black),
                    ),
                    TextFormField(
                      decoration: InputDecoration(hintText: "Enter name"),
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
                        // obscureText: passhidden,
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
                    if (_logformkey.currentState!.validate()) {
                      Navigator.of(context).pushNamed(ProductPage.routeName);
                      // login(phonenumber.text, password.text);
                    }
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
