import 'package:firebase_auth/firebase_auth.dart';
import 'package:florida_app_store/Constants/enums.dart';
import 'package:flutter/material.dart';
import 'package:florida_app_store/components/coustom_bottom_nav_bar.dart';
import '../add_item.dart';
import 'components/body.dart';

class HomeScreen extends StatefulWidget {
  static String routeName = "/home";

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool _isAdmin = false;

  final uid = FirebaseAuth.instance.currentUser?.uid;
  @override
  void initState() {
    isAdmin();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leadingWidth: 0,
        automaticallyImplyLeading: false,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: <Color>[Color(0xFFFF7950), Colors.red])),
        ),
        title: Row(
          children: [
            Text(
              'YN STORE',
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Dance',
                  fontSize: 35),
            ),
            Visibility(
              visible: _isAdmin,
              child: Container(
                child: IconButton(
                  onPressed: () {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => AddItem()));
                  },
                  icon: Icon(Icons.add_circle_outlined),
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
      body: Body(),
      bottomNavigationBar: CustomBottomNavBar(selectedMenu: MenuState.home),
    );
  }

  void isAdmin() {
    if (uid == "vpAtfKoWy4YlLr0M492vFENzLw42") {
      _isAdmin = true;
    }
  }
}
