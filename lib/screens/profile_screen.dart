import 'package:aiu_chatbot/routes.dart';
import 'package:aiu_chatbot/widgets/custom_textfield.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String username = 'Loading...';
  String email = 'Loading...';

  final TextEditingController usernameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadUserProfile();
  }

  Future<void> _loadUserProfile() async {
    try {
      User? user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        DocumentSnapshot userDoc = await FirebaseFirestore.instance
            .collection('users')
            .doc(user.uid)
            .get();
        setState(() {
          username = userDoc['username'] ?? 'No Name';
          email = userDoc['email'] ?? 'No Email';
          usernameController.text = username;
          emailController.text = email;
        });
      }
    } catch (e) {
      setState(() {
        username = 'Error';
        email = 'Error';
      });
      Get.snackbar('Error', 'Failed to load user data: $e',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white);
    }
  }

  Future<void> _saveUserProfile() async {
    try {
      User? user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        bool isUpdated = false;

        if (usernameController.text.trim() != username) {
          await FirebaseFirestore.instance
              .collection('users')
              .doc(user.uid)
              .update({'username': usernameController.text.trim()});
          isUpdated = true;
        }

        if (emailController.text.trim() != email) {
          await user.updateEmail(emailController.text.trim());
          await FirebaseFirestore.instance
              .collection('users')
              .doc(user.uid)
              .update({'email': emailController.text.trim()});
          isUpdated = true;
        }

        if (isUpdated) {
          Get.snackbar('Success', 'Profile updated successfully!',
              snackPosition: SnackPosition.BOTTOM,
              backgroundColor: Colors.green,
              colorText: Colors.white);
          _loadUserProfile();
        } else {
          Get.snackbar('No Changes', 'No fields were updated.',
              snackPosition: SnackPosition.BOTTOM,
              backgroundColor: Colors.blue,
              colorText: Colors.white);
        }
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to save profile: $e',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Profile',
          style:
              GoogleFonts.poppins(color: const Color(0xff005546), fontSize: 22),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: ListView(
            children: [
              const SizedBox(height: 20),
              Center(
                child: Column(
                  children: [
                    CircleAvatar(
                      radius: 50,
                      backgroundColor: const Color(0xff00B98D),
                      child: const Icon(
                        Icons.person,
                        size: 60,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      username,
                      style: GoogleFonts.poppins(
                        color: const Color(0xff005546),
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      email,
                      style: GoogleFonts.poppins(
                        color: Colors.grey,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.2),
                      blurRadius: 10,
                      offset: const Offset(0, 5),
                    )
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Update Profile',
                      style: GoogleFonts.poppins(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: const Color(0xff005546),
                      ),
                    ),
                    const SizedBox(height: 15),
                    CustomTextField(
                      hintText: 'Update username',
                      controller: usernameController,
                      maxLines: 1,
                      onChanged: (value) {},
                    ),
                    const SizedBox(height: 10),
                    CustomTextField(
                      hintText: 'Update email',
                      controller: emailController,
                      maxLines: 1,
                      onChanged: (value) {},
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          onPressed: () {
                            _showLogoutDialog(context);
                          },
                          child: Text(
                            'Logout',
                            style: GoogleFonts.poppins(color: Colors.white),
                          ),
                        ),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xff00B98D),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          onPressed: _saveUserProfile,
                          child: Text(
                            'Save Changes',
                            style: GoogleFonts.poppins(color: Colors.white),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'Are you sure?',
            style: GoogleFonts.poppins(fontWeight: FontWeight.bold),
          ),
          content: Text(
            'Do you really want to logout?',
            style: GoogleFonts.poppins(),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(
                'Cancel',
                style: GoogleFonts.poppins(color: Colors.grey),
              ),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
              onPressed: () {
                FirebaseAuth.instance.signOut();
                Get.offAllNamed(AppRoutes.login);
              },
              child: Text(
                'Logout',
                style: GoogleFonts.poppins(color: Colors.white),
              ),
            ),
          ],
        );
      },
    );
  }
}
