import 'package:easy_join/utils/customColors.dart';
import 'package:flutter/material.dart';

class CustomTextButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String buttonText;
  final Color textColor;
  const CustomTextButton({
    super.key,
    required this.onPressed,
    required this.buttonText,
    required this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      child: Text(
      buttonText,style: TextStyle(
      fontFamily: "ubuntu",
      fontSize: 16,
      fontWeight: FontWeight.bold,
      color: textColor,
    ),
    ),
      style: ButtonStyle(
        overlayColor: MaterialStateProperty.all(Colors.transparent), // Tıklanma rengi yok
        splashFactory: NoSplash.splashFactory, // Splash efekti yok
      ),
    );
  }
}
