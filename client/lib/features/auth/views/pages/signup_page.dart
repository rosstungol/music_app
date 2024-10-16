import 'package:client/core/theme/app_pallete.dart';
import 'package:client/features/auth/views/widgets/auth_gradient_button.dart';
import 'package:client/features/auth/views/widgets/custom_field.dart';
import 'package:flutter/material.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Sign Up',
              style: TextStyle(fontSize: 50, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 32),
            const CustomField(
              hintText: 'Name',
            ),
            const SizedBox(height: 16),
            const CustomField(
              hintText: 'Email',
            ),
            const SizedBox(height: 16),
            const CustomField(hintText: 'Password'),
            const SizedBox(height: 20),
            const AuthGradientButton(),
            const SizedBox(height: 20),
            RichText(
              text: TextSpan(
                text: 'Already have an account? ',
                style: Theme.of(context).textTheme.titleMedium,
                children: const [
                  TextSpan(
                    text: 'Sign in',
                    style: TextStyle(
                      color: Pallete.gradient2,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
