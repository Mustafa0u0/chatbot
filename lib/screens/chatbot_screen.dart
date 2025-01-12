import 'package:aiu_chatbot/routes.dart';
import 'package:aiu_chatbot/screens/aboutus_screen.dart';
import 'package:aiu_chatbot/screens/feedback_screen.dart';
import 'package:aiu_chatbot/screens/profile_screen.dart';
import 'package:dialog_flowtter/dialog_flowtter.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class ChatbotScreen extends StatefulWidget {
  const ChatbotScreen({Key? key}) : super(key: key);

  @override
  _ChatbotScreenState createState() => _ChatbotScreenState();
}

class _ChatbotScreenState extends State<ChatbotScreen> {
  late DialogFlowtter dialogFlowtter;
  final TextEditingController _controller = TextEditingController();
  List<Map<String, dynamic>> messages = [];

  @override
  void initState() {
    super.initState();
    _initializeDialogFlow();
  }

  Future<void> _initializeDialogFlow() async {
    try {
      dialogFlowtter = await DialogFlowtter.fromFile(
        path: 'assets/dialog_flow_auth.json',
      );
    } catch (e) {
      print('DialogFlow initialization error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        title: Text(
          'Chatbot',
          style: GoogleFonts.poppins(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: const Color(0xff005546),
          ),
        ),
        backgroundColor: Colors.white,
      ),
      drawer: _buildDrawer(context),
      body: Column(
        children: [
          _buildChatHeader(),
          Expanded(child: _buildMessagesScreen()),
          _buildMessageInput(),
        ],
      ),
    );
  }

  Widget _buildDrawer(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          DrawerHeader(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xff00B98D), Color.fromARGB(255, 39, 58, 67)],
              ),
            ),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/Logo.png',
                    height: 80,
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'AIU Chatbot',
                    style: GoogleFonts.poppins(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
          _buildDrawerItem(
            context: context,
            icon: Icons.person_outline,
            title: 'Profile',
            onTap: () {
              Get.to(const ProfileScreen());
            },
          ),
          _buildDrawerItem(
            context: context,
            icon: Icons.feedback_outlined,
            title: 'Feedback',
            onTap: () {
              Get.to(FeedbackScreen());
            },
          ),
          _buildDrawerItem(
            context: context,
            icon: Icons.info_outline,
            title: 'About Us',
            onTap: () {
              Get.to(AboutUsScreen());
            },
          ),
          const Spacer(),
          const Divider(),
          _buildDrawerItem(
            context: context,
            icon: Icons.logout,
            title: 'Logout',
            onTap: () {
              _showLogoutDialog(context);
            },
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }

  Widget _buildDrawerItem({
    required BuildContext context,
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return ListTile(
      leading: Icon(icon, color: const Color(0xff00B98D)),
      title: Text(
        title,
        style: GoogleFonts.poppins(
          fontSize: 16,
          fontWeight: FontWeight.w500,
          color: Colors.black,
        ),
      ),
      onTap: onTap,
    );
  }

  Widget _buildChatHeader() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Container(
        padding: const EdgeInsets.all(16),
        color: Colors.lightBlue[50],
        child: Row(
          children: [
            Text(
              'Better method of creating & communicating',
              style: GoogleFonts.poppins(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: const Color(0xff005546),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMessagesScreen() {
    return ListView.builder(
      itemCount: messages.length,
      itemBuilder: (context, index) {
        final message = messages[index];
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Align(
            alignment: message['isUserMessage']
                ? Alignment.centerRight
                : Alignment.centerLeft,
            child: Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: message['isUserMessage']
                    ? const Color(0xff00B98D)
                    : Colors.grey[200],
                borderRadius: BorderRadius.circular(16),
              ),
              child: Text(
                message['text'] ?? '',
                style: GoogleFonts.poppins(
                  fontSize: 14,
                  color: message['isUserMessage'] ? Colors.white : Colors.black,
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildMessageInput() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            blurRadius: 10,
            color: Colors.grey.withOpacity(0.2),
            offset: const Offset(0, -1),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _controller,
              style: GoogleFonts.poppins(fontSize: 14),
              decoration: InputDecoration(
                hintText: 'Type a message...',
                hintStyle: GoogleFonts.poppins(color: Colors.grey),
                border: InputBorder.none,
              ),
            ),
          ),
          IconButton(
            onPressed: _sendMessage,
            icon: const Icon(Icons.send, color: Color(0xff00B98D)),
          ),
        ],
      ),
    );
  }

  void _sendMessage() async {
    final text = _controller.text.trim();
    if (text.isEmpty) return;

    setState(() {
      messages.add({'text': text, 'isUserMessage': true});
    });

    _controller.clear();

    try {
      final response = await dialogFlowtter.detectIntent(
        queryInput: QueryInput(
          text: TextInput(text: text),
        ),
      );
      final botMessage = response.message?.text?.text?[0] ?? 'No response';
      setState(() {
        messages.add({'text': botMessage, 'isUserMessage': false});
      });
    } catch (e) {
      print('Error sending message: $e');
    }
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
