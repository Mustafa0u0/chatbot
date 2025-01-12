import 'package:aiu_chatbot/routes.dart';
import 'package:aiu_chatbot/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: ListView(
            padding: const EdgeInsets.all(12),
            children: [
              SizedBox(height: 40),
              Image.asset(
                'assets/Logo.png',
                height: 250,
              ),
              SizedBox(height: 20),
              Text(
                'AIU Chatbot',
                textAlign: TextAlign.center,
                style: GoogleFonts.poppins(
                  fontSize: 32,
                  fontWeight: FontWeight.w700,
                ),
              ),
              SizedBox(height: 10),
              Text(
                'Welcome to AIU Chatbot – your friendly companion for all your AIU needs!',
                textAlign: TextAlign.center,
                style: GoogleFonts.poppins(fontSize: 17),
              ),
              SizedBox(height: 40),
              CustomButton(
                title: 'Sign In',
                backgroundColor: Color(0xFF00B98D),
                fontColor: Colors.white,
                onTap: () {
                  Get.toNamed(AppRoutes.login);
                },
              ),
              SizedBox(height: 20),
              GestureDetector(
                onTap: () {
                  Get.toNamed(AppRoutes.createAccount);
                },
                child: Container(
                  width: 341,
                  height: 56,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all()),
                  child: Text(
                    'Create account',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.poppins(
                      textStyle: const TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
