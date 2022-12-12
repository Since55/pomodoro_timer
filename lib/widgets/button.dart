import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  final String text;
  final Color? buttonColor;
  final void Function() onTap;

  const Button({
    super.key,
    this.buttonColor,
    required this.text,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onTap,
      style: ButtonStyle(
        elevation: MaterialStateProperty.all(0),
        backgroundColor: MaterialStateProperty.all(buttonColor),
        shape: MaterialStateProperty.all(const BeveledRectangleBorder())
      ),
      child: SizedBox(
        height: 50,
        child: Center(
          child: Text(
            text,
            style: const TextStyle(
              fontSize: 32,
              color: Colors.white,
              fontWeight: FontWeight.w300,
            ),
          ),
        ),
      ),
    );
  }
}
