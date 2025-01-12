import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';

class FeedbackScreen extends StatelessWidget {
  final TextEditingController feedbackController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Feedback',
          style:
              GoogleFonts.poppins(color: const Color(0xff005546), fontSize: 22),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'We value your feedback!',
              style: GoogleFonts.poppins(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: const Color(0xff005546),
              ),
            ),
            const SizedBox(height: 10),
            Text(
              'Please write to us:',
              style: GoogleFonts.poppins(fontSize: 14, color: Colors.grey),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: feedbackController,
              maxLines: 5,
              decoration: InputDecoration(
                hintText: 'Your Feedback',
                hintStyle: GoogleFonts.poppins(color: Colors.grey),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  _sendEmail(feedbackController.text.trim(), context);
                  feedbackController
                      .clear(); // Clear the feedback after submission
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xff00B98D),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Text(
                  'Submit',
                  style: GoogleFonts.poppins(color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _sendEmail(String feedback, BuildContext context) async {
    String username = 'mustafa.yahya@student.aiu.edu.my';
    String password = 'wetu cudj ylbb zywg';

    List<String> recipients = [
      'mustafa.r2018@gmail.com',
      'marifardelian@gmail.com',
      'moe.zaw@student.aiu.edu.my',
      'rahim.shah@student.aiu.edu.my',
      'ibrahima.diallo@student.aiu.edu.my',
    ];

    // Configure SMTP server
    final smtpServer = gmail(username, password);

    // Create the message
    final message = Message()
      ..from = Address(username, 'AIU Chatbot Feedback')
      ..recipients.addAll(recipients) // Add all recipients
      ..subject = 'New Feedback from AIU Chatbot'
      ..text = 'You received new feedback:\n\n$feedback';

    try {
      final sendReport = await send(message, smtpServer);
      print('Feedback sent: ${sendReport.toString()}');
      _showSnackBar(context, 'Feedback sent successfully!', Colors.green);
    } on MailerException catch (e) {
      print('Error occurred while sending email: $e');
      _showSnackBar(
          context, 'Failed to send feedback. Please try again.', Colors.red);
    }
  }

  void _showSnackBar(BuildContext context, String message, Color color) {
    final snackBar = SnackBar(
      content: Text(
        message,
        style: GoogleFonts.poppins(color: Colors.white),
      ),
      backgroundColor: color,
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
