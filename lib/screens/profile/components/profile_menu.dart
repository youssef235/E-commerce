// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:florida_app_store/Constants/constants.dart';

class ProfileMenu extends StatelessWidget {
  const ProfileMenu({
    Key? key,
    required this.text,
    required this.icon,
    this.press,
  }) : super(key: key);

  final String text, icon;
  final VoidCallback? press;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Container(
        decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(15)),
            gradient: LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: <Color>[
                  Color.fromARGB(255, 255, 131, 123),
                  Color.fromARGB(255, 255, 154, 124),
                ])),
        child: TextButton(
          style: TextButton.styleFrom(
            foregroundColor: Colors.white,
            padding: EdgeInsets.all(20),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            //  backgroundColor: Color.fromARGB(255, 165, 92, 177),
          ),
          onPressed: press,
          child: Row(
            children: [
              SvgPicture.asset(
                icon,
                color: Colors.white,
                width: 22,
              ),
              SizedBox(width: 20),
              Expanded(child: Text(text)),
              Icon(Icons.arrow_forward_ios),
            ],
          ),
        ),
      ),
    );
  }
}
