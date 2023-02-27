import 'dart:convert';

import 'package:ecommerce/auth/login_page.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfilePage extends StatefulWidget {
  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  var user = {};
  bool isloading = true;
  @override
  void initState() {
    getuser().then(
      (value) {
        setState(() {
          user = value;
          isloading = false;
        });
      },
    );
    super.initState();
  }

  Future getuser() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    var user = pref.getString("user");
    return jsonDecode(user as String);
  }

  @override
  Widget build(BuildContext context) {
    return isloading == false
        ? Scaffold(
            backgroundColor: Color(0xffF9F9F9),
            body: SafeArea(
              top: true,
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.only(
                      left: 16.0, right: 16.0, top: kToolbarHeight),
                  child: Column(
                    children: <Widget>[
                      CircleAvatar(
                        maxRadius: 48,
                        backgroundImage: NetworkImage(
                            'https://cdn2.iconfinder.com/data/icons/communication-489/24/account_profile_user_contact_person_avatar_placeholder-512.png'),
                        backgroundColor: Colors.transparent,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          user["name"],
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(vertical: 16.0),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(8),
                                topRight: Radius.circular(8),
                                bottomLeft: Radius.circular(8),
                                bottomRight: Radius.circular(8)),
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.yellow,
                                  blurRadius: 4,
                                  spreadRadius: 1,
                                  offset: Offset(0, 1))
                            ]),
                        height: 150,
                        child: Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: <Widget>[
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  IconButton(
                                    icon:
                                        Image.asset('assets/icons/wallet.png'),
                                    onPressed: () {},
                                    // onPressed:()=> Navigator.of(context).push(
                                    //     MaterialPageRoute(
                                    //         builder: (_) => WalletPage())),
                                  ),
                                  Text(
                                    'Wallet',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  )
                                ],
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  IconButton(
                                    icon: Image.asset('assets/icons/truck.png'),
                                    onPressed: () {},
                                    // onPressed: () => Navigator.of(context).push(
                                    //   MaterialPageRoute(builder: (_) => TrackingPage())),
                                  ),
                                  Text(
                                    'Shipped',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  )
                                ],
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  IconButton(
                                    icon: Image.asset('assets/icons/card.png'),
                                    onPressed: () {},
                                    // onPressed:()=> Navigator.of(context).push(
                                    //     MaterialPageRoute(
                                    //         builder: (_) => PaymentPage())),
                                  ),
                                  Text(
                                    'Payment',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  )
                                ],
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  IconButton(
                                    icon: Image.asset(
                                        'assets/icons/contact_us.png'),
                                    onPressed: () {},
                                  ),
                                  Text(
                                    'Support',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      ListTile(
                        title: Text('Settings'),
                        subtitle: Text('Privacy'),
                        leading: Icon(Icons.settings),
                        trailing:
                            Icon(Icons.chevron_right, color: Colors.yellow),
                        // onTap: () => Navigator.of(context).push(
                        //     MaterialPageRoute(builder: (_) => SettingsPage())),
                      ),
                      Divider(),
                      ListTile(
                        title: Text('FAQ'),
                        subtitle: Text('Questions and Answer'),
                        leading: Image.asset('assets/icons/faq.png'),
                        trailing:
                            Icon(Icons.chevron_right, color: Colors.yellow),
                        // onTap: () => Navigator.of(context).push(
                        //     MaterialPageRoute(builder: (_) => FaqPage())),
                      ),
                      Divider(),
                      ListTile(
                        title: Text('Logout'),
                        leading: Icon(Icons.logout),
                        onTap: () async {
                          SharedPreferences preference =
                              await SharedPreferences.getInstance();
                          await preference.clear().then((value) =>
                              Navigator.of(context)
                                  .pushReplacementNamed(LoginScreen.routeName));
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          )
        : const Scaffold(body: Center(child: CircularProgressIndicator()));
  }
}
