import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AboutUsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'About Us',
          style:
              GoogleFonts.poppins(color: const Color(0xff005546), fontSize: 22),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            // About Chatbot Section
            Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'About AIU Chatbot',
                      style: GoogleFonts.poppins(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: const Color(0xff005546),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      'AIU Chatbot is your personal virtual assistant designed to provide seamless support for students, faculty, and staff at AIU. With features ranging from general inquiries to real-time assistance, we aim to enhance your experience at AIU.',
                      style: GoogleFonts.poppins(
                          fontSize: 14, color: Colors.grey[700]),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Group Project Details Section
            Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Group Project Details',
                      style: GoogleFonts.poppins(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: const Color(0xff005546),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      'Group Leader:',
                      style: GoogleFonts.poppins(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      'Mustafa Yahya (ID: AIU22102272)',
                      style: GoogleFonts.poppins(
                          fontSize: 14, color: Colors.grey[700]),
                    ),
                    const SizedBox(height: 15),
                    Text(
                      'Group Members:',
                      style: GoogleFonts.poppins(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(height: 10),
                    // Group Member List
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildGroupMemberCard('Moe Arkar Zaw', 'AIU23102104'),
                        _buildGroupMemberCard(
                            'Ibrahima Kindy Diallo', 'AIU22102020'),
                        _buildGroupMemberCard(
                            'SHAH S Moh Rahim Shah', 'AIU22102354'),
                        _buildGroupMemberCard(
                            'M. Arif Ardelian', 'AIU22102275'),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildGroupMemberCard(String name, String id) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.symmetric(vertical: 6),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            CircleAvatar(
              backgroundColor: const Color(0xff00B98D),
              child: Text(
                name[0],
                style: GoogleFonts.poppins(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                Text(
                  id,
                  style: GoogleFonts.poppins(
                    fontSize: 12,
                    color: Colors.grey[700],
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
