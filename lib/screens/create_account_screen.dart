import 'package:aiu_chatbot/controller/auth_controller.dart';
import 'package:aiu_chatbot/routes.dart';
import 'package:aiu_chatbot/widgets/custom_button.dart';
import 'package:aiu_chatbot/widgets/custom_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class CreateAccountScreen extends StatefulWidget {
  CreateAccountScreen({super.key});

  @override
  State<CreateAccountScreen> createState() => _CreateAccountScreenState();
}

class _CreateAccountScreenState extends State<CreateAccountScreen> {
  final TextEditingController usernameController = TextEditingController();

  final TextEditingController emailController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();

  final AuthController createAccountController = Get.put(AuthController());
  bool checkedValue = false;
  bool checkboxValue = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(12),
          children: [
            const SizedBox(height: 40),
            Align(
                alignment: Alignment.topRight,
                child: SvgPicture.asset('assets/Star.svg')),
            const SizedBox(height: 20),
            Text(
              'Create account',
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
              'Username',
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
              hintText: 'Your username',
              controller: usernameController,
              onChanged: (p0) {},
              maxLines: 1,
            ),
            const SizedBox(height: 20),
            Text(
              'Email',
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
            CustomTextField(
              hintText: 'Your password',
              controller: passwordController,
              isObscure: true,
              onChanged: (p0) {},
              maxLines: 1,
            ),
            SizedBox(height: 10),
            FormField<bool>(
              builder: (state) {
                return Column(
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Checkbox(
                            activeColor: Colors.black,
                            shape: CircleBorder(),
                            value: checkboxValue,
                            onChanged: (value) {
                              setState(() {
                                checkboxValue = value!;
                                state.didChange(value);
                              });
                            }),
                        Text(
                          "I accept the terms and privacy policy",
                          style: GoogleFonts.poppins(
                              color: Colors.black, fontSize: 14),
                        ),
                      ],
                    ),
                    Container(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        state.errorText ?? '',
                        textAlign: TextAlign.left,
                        style: GoogleFonts.poppins(
                          color: Colors.red,
                          fontSize: 12,
                        ),
                      ),
                    )
                  ],
                );
              },
              validator: (value) {
                if (!checkboxValue) {
                  return ' You need to accept the terms and privacy policy';
                } else {
                  return null;
                }
              },
            ),
            const SizedBox(height: 30),
            CustomButton(
              title: 'Sign Up',
              backgroundColor: const Color(0xFF00B98D),
              fontColor: Colors.white,
              onTap: () {
                createAccountController.signUp(
                  usernameController.text.trim(),
                  emailController.text.trim(),
                  passwordController.text.trim(),
                );
              },
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Already have an account?',
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
                    Get.toNamed(AppRoutes.login);
                  },
                  child: Text(
                    'Log in',
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
