import 'package:aiu_chatbot/main.dart';
import 'package:aiu_chatbot/screens/chatbot_screen.dart';
import 'package:aiu_chatbot/screens/create_account_screen.dart';
import 'package:aiu_chatbot/screens/login_screen.dart';
import 'package:aiu_chatbot/screens/welcome_screen.dart';
import 'package:get/get.dart';

class AppRoutes {
  static const String welcome = '/';
  static const String login = '/login';
  static const String createAccount = '/CreateAccount';
  static const String chatbot = '/chatbot';

  static List<GetPage> routes = [
    GetPage(name: welcome, page: () => const WelcomeScreen()),
    GetPage(name: login, page: () => LoginScreen()),
    GetPage(name: createAccount, page: () => CreateAccountScreen()),
    GetPage(name: chatbot, page: () => ChatbotScreen()),
  ];
}
