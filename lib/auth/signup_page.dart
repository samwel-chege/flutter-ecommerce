// ignore_for_file: prefer_const_constructors, prefer_typing_uninitialized_variables, empty_catches

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

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
  // late Validation val;

  var encodeddata;
  @override
  void initState() {
    super.initState();
    username = TextEditingController();
    email = TextEditingController();
    password = TextEditingController();

    // val = Validation();
  }

  bool passhidden = true;

  passvisible() {
    setState(() {
      passhidden = !passhidden;
    });
  }

  userid(var id) async {
    // SharedPreferences preferences = await SharedPreferences.getInstance();

    // preferences.setString('user_id', id);
  }

  userdata(var userdata) async {
    // SharedPreferences preferences = await SharedPreferences.getInstance();

    // preferences.setString('userdata', userdata);
  }

  // var category;
  // @override
  // void didChangeDependencies() {
  //   super.didChangeDependencies();
  //   category = ModalRoute.of(context)!.settings.arguments;
  // }

  // Future register(username, email, password) async {
  //   try {
  //     String registerUrl = Api.api_url_auth + Api.endpoint_signup;
  //     var data = {
  //       "token": Api.auth_key,
  //       "names": username,
  //       "password": password
  //     };
  //     var responsedata = await httppostsignup(registerUrl, data, context);
  //     var res = responsedata["user_id"];

  //     encodeddata = res;
  //   } catch (e) {}
  // }

  final _signupkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: background,
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
                'Create Your Account',
                style: TextStyle(
                    // color: textcolordark,
                    fontSize: 20,
                    fontWeight: FontWeight.w400),
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
                    // CustomFormTextField(
                    //     validator: val.nameval,
                    //     controller: username,
                    //     hintText: "Enter your name"),
                    TextFormField(
                      decoration: InputDecoration(hintText: "Enter name"),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      'Phone',
                      style: TextStyle(color: Colors.black),
                    ),
                    // CustomFormTextField(
                    //     validator: val.mobileval,
                    //     controller: phone,
                    //     hintText: "Enter your email "),
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
                    TextFormField(
                      keyboardType: TextInputType.text,
                      textInputAction: TextInputAction.done,
                      controller: password,
                      // validator: val.passwordval,
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
                    if (_signupkey.currentState!.validate()) {
                      // register(username.text, category, phone.text,
                    }
                  },
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.black
                      // foregroundColor: Colors.white,
                      ),
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
