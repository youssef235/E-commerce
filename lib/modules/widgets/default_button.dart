import 'package:flutter/material.dart';
import '../../Constants/constants.dart';

class DefaultButton extends StatelessWidget {
  Widget buttonWidget;
  Function() function;
  double width;
  Color backgroundColor;
  bool isUpperCase;
  double radius;
  DefaultButton({
    super.key,
    required this.buttonWidget,
    required this.function,
    this.width = double.infinity,
    this.backgroundColor = kPrimaryColor,
    this.isUpperCase = true,
    this.radius = 0.0,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: 50.0,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(radius),
        color: kPrimaryColor,
      ),
      child: MaterialButton(
        onPressed: function,
        child: buttonWidget,
      ),
    );
  }
}
