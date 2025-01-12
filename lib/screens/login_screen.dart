import 'package:aiu_chatbot/controller/auth_controller.dart';
import 'package:aiu_chatbot/routes.dart';
import 'package:aiu_chatbot/widgets/custom_button.dart';
import 'package:aiu_chatbot/widgets/custom_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  final TextEditingController emailController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();

  final AuthController authController = Get.put(AuthController());
  void _showForgotPasswordDialog(BuildContext context) {
    final TextEditingController emailController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          'Forgot Password',
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.bold,
          ),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Enter your email address to reset your password.',
              style: GoogleFonts.poppins(fontSize: 14),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: emailController,
              decoration: InputDecoration(
                labelText: 'Email',
                border: OutlineInputBorder(),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context); // Close dialog
            },
            child: Text(
              'Cancel',
              style: GoogleFonts.poppins(color: Colors.black),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              final email = emailController.text.trim();
              if (email.isNotEmpty) {
                authController.resetPassword(email);
                Navigator.pop(context); // Close dialog
              } else {
                Get.snackbar(
                  'Error',
                  'Please enter your email address.',
                  snackPosition: SnackPosition.BOTTOM,
                  backgroundColor: Colors.red,
                  colorText: Colors.white,
                );
              }
            },
            child: Text(
              'Reset Password',
              style: GoogleFonts.poppins(color: Colors.black),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(14),
          children: [
            const SizedBox(height: 40),
            Align(
                alignment: Alignment.topRight,
                child: SvgPicture.asset('assets/Star.svg')),
            const SizedBox(height: 20),
            Text(
              'Log in',
              textAlign: TextAlign.start,
              style: GoogleFonts.poppins(
                textStyle: const TextStyle(
                  color: Colors.black,
                  fontSize: 30,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            const SizedBox(height: 40),
            Text(
              'Email address',
              textAlign: TextAlign.start,
              style: GoogleFonts.poppins(
                textStyle: const TextStyle(
                  color: Colors.black,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            const SizedBox(height: 10),
            CustomTextField(
              hintText: 'Your email',
              controller: emailController,
              onChanged: (p0) {},
              maxLines: 1,
            ),
            const SizedBox(height: 20),
            Text(
              'Password',
              textAlign: TextAlign.start,
              style: GoogleFonts.poppins(
                textStyle: const TextStyle(
                  color: Colors.black,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            const SizedBox(height: 10),
            CustomTextField(
              maxLines: 1,
              hintText: 'Your password',
              controller: passwordController,
              isObscure: true,
              onChanged: (p0) {},
            ),
            const SizedBox(height: 5),
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () {
                  _showForgotPasswordDialog(context);
                },
                child: Text(
                  'Forgot password?',
                  style: GoogleFonts.poppins(
                    textStyle: const TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 40),
            CustomButton(
              title: 'Log in',
              backgroundColor: const Color(0xFF00B98D),
              fontColor: Colors.white,
              onTap: () {
                authController.signIn(emailController.text.trim(),
                    passwordController.text.trim());
              },
            ),
            const SizedBox(height: 40),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Don’t have an account?',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.poppins(
                    textStyle: const TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    Get.toNamed(AppRoutes.createAccount);
                  },
                  child: Text(
                    'Sign up',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.poppins(
                      textStyle: const TextStyle(
                        color: Colors.black,
                        fontSize: 14,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
