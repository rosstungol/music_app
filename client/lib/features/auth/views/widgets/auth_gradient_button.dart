import 'package:flutter/material.dart';

import '../../../../core/theme/app_palette.dart';

class AuthGradientButton extends StatelessWidget {
  final String buttonText;
  final VoidCallback onTap;
  const AuthGradientButton({
    super.key,
    required this.buttonText,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [
            Palette.gradient1,
            Palette.gradient2,
          ],
          begin: Alignment.bottomLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(8),
      ),
      child: ElevatedButton(
        onPressed: onTap,
        style: ElevatedButton.styleFrom(
          fixedSize: const Size(395, 55),
          backgroundColor: Palette.transparentColor,
          shadowColor: Palette.transparentColor,
        ),
        child: Text(
          buttonText,
          style: const TextStyle(
            fontSize: 17,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
