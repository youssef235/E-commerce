import 'package:firebase_auth/firebase_auth.dart';
import 'package:florida_app_store/screens/orders.dart';
import 'package:florida_app_store/screens/sign_in/sign_in_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'profile_menu.dart';
import 'profile_pic.dart';

class Body extends StatefulWidget {
  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  bool _isAdmin = false;
  final uid = FirebaseAuth.instance.currentUser?.uid;

  @override
  void initState() {
    isAdmin();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(vertical: 20),
      child: Column(
        children: [
          ProfilePic(),
          SizedBox(height: 20),
          ProfileMenu(
            text: "My Account",
            icon: "assets/icons/User Icon.svg",
            press: () => {
              if (_isAdmin == true)
                {
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (context) => Orders()))
                }
            },
          ),
          ProfileMenu(
            text: "Notifications",
            icon: "assets/icons/Bell.svg",
            press: () {},
          ),
          ProfileMenu(
            text: "Settings",
            icon: "assets/icons/Settings.svg",
            press: () {},
          ),
          ProfileMenu(
            text: "Help Center",
            icon: "assets/icons/Question mark.svg",
            press: () {},
          ),
          ProfileMenu(
            text: "Log Out",
            icon: "assets/icons/Log out.svg",
            press: () async {
              // await GoogleSignIn().signOut();
              FirebaseAuth.instance.signOut();
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => SignInScreen()));
            },
          ),
        ],
      ),
    );
  }

  void isAdmin() {
    if (uid == "vpAtfKoWy4YlLr0M492vFENzLw42") {
      setState(() {
        _isAdmin = true;
      });
    }
  }
}
