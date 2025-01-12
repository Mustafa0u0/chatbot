import 'package:aiu_chatbot/routes.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Rx<User?> firebaseUser = Rx<User?>(null);

  @override
  void onInit() {
    firebaseUser.bindStream(_auth.authStateChanges());
    super.onInit();
  }

  Future<void> resetPassword(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
      Get.snackbar(
        "Password Reset",
        "A password reset email has been sent to $email.",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );
    } catch (e) {
      Get.snackbar(
        "Error",
        "Failed to send password reset email: ${e.toString()}",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  // Sign-up method with username, email, and password
  Future<void> signUp(String username, String email, String password) async {
    try {
      // Show loading indicator
      Get.defaultDialog(
        title: 'Please Wait',
        content: CircularProgressIndicator(),
      );

      // Create a new user with email and password
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Add user information (username) to Firestore
      await _firestore.collection('users').doc(userCredential.user!.uid).set({
        'username': username,
        'email': email,
        'uid': userCredential.user!.uid,
      });

      // Remove loading indicator
      Get.back();

      // Navigate to the home screen
      Get.offAllNamed(AppRoutes.login);
    } on FirebaseAuthException catch (e) {
      // Remove loading indicator
      Get.back();

      String errorMessage;

      switch (e.code) {
        case 'email-already-in-use':
          errorMessage =
              'The email address is already in use by another account.';
          break;
        case 'invalid-email':
          errorMessage =
              'The email address is not valid. Please enter a correct email.';
          break;
        case 'weak-password':
          errorMessage =
              'The password is too weak. Please enter a stronger password.';
          break;
        default:
          errorMessage = 'An unknown error occurred. Please try again.';
          break;
      }

      // Show specific error messages
      Get.snackbar('Sign-up Error', errorMessage);
    } catch (e) {
      // Remove loading indicator
      Get.back();
      Get.snackbar(
          'Sign-up Error', 'An unexpected error occurred: ${e.toString()}');
    }
  }

  // Sign-in method
  Future<void> signIn(String email, String password) async {
    try {
      // Show loading indicator
      Get.defaultDialog(
        title: 'Please Wait',
        content: CircularProgressIndicator(),
      );

      // Attempt to sign in with email and password
      await _auth.signInWithEmailAndPassword(email: email, password: password);

      // Remove loading indicator
      Get.back();

      // Navigate to the home screen
      Get.offAllNamed(AppRoutes.chatbot);
    } on FirebaseAuthException catch (e) {
      // Remove loading indicator
      Get.back();

      String errorMessage;

      switch (e.code) {
        case 'invalid-email':
          errorMessage =
              'The email address is not valid. Please enter a correct email.';
          break;
        case 'user-not-found':
          errorMessage =
              'No user found with this email. Please check your email or sign up.';
          break;
        case 'wrong-password':
          errorMessage = 'Incorrect password. Please try again.';
          break;
        case 'user-disabled':
          errorMessage =
              'This account has been disabled. Please contact support.';
          break;
        default:
          errorMessage = 'An unknown error occurred. Please try again.';
          break;
      }

      // Show specific error messages
      Get.snackbar('Sign-in Error', errorMessage);
    } catch (e) {
      // Remove loading indicator
      Get.back();
      Get.snackbar(
          'Sign-in Error', 'An unexpected error occurred: ${e.toString()}');
    }
  }

  // Sign-out method
  Future<void> signOut() async {
    await _auth.signOut();
    Get.offAllNamed(AppRoutes.login); // Navigate to the login screen
  }
}
