import 'package:flutter/material.dart';
import 'package:lipslay_flutter_frontend/constants/appColors.dart';

class ChatbotPage extends StatefulWidget {
  const ChatbotPage({super.key});

  @override
  State<ChatbotPage> createState() => _ChatbotPageState();
}

class _ChatbotPageState extends State<ChatbotPage> {
  final TextEditingController _textController = TextEditingController();
  final List<ChatMessage> _messages = []; // List to store chat messages

  @override
  void initState() {
    super.initState();

    // Add welcome message from bot
    _messages.add(
      const ChatMessage(
        text:
            'Hi! 👋 I\'m Lipslay Bot. Welcome to Lipslay Spa — your personal gateway to relaxation, rejuvenation, and radiant Beauty. Whether you\'re here to unwind after a long day, pamper yourself with luxurious treatments, or explore our curated wellness services, we’re thrilled to have you. Our professional team is dedicated to delivering serenity and care through every detail, from soothing massages to revitalizing skin therapies. If you need assistance with booking, learning about our services, or simply want self-care tips — I’m here to help. Let your journey to bliss begin right here',
        isUser: false,
      ),
    );
  }

  // Simple chatbot logic
  String _getBotResponse(String userMessage) {
    userMessage = userMessage.toLowerCase().trim(); // Make it case-insensitive

    if (userMessage.contains('hello') || userMessage.contains('hi')) {
      return 'Hello there! How can I assist you today?';
    } else if (userMessage.contains('booking')) {
      return 'For booking appointments, please go to the Calendar/Booking tab in the main navigation.';
    } else if (userMessage.contains('services')) {
      return 'We offer various services including Ladies Salon, Gents Salon, SPA, and more. What are you interested in?';
    } else if (userMessage.contains('thank you') ||
        userMessage.contains('thanks')) {
      return 'You\'re welcome! Is there anything else I can help with?';
    } else if (userMessage.contains('wishlist')) {
      return 'You can add your favorite items or services to your Wishlist for later.';
    } else if (userMessage.contains('contact')) {
      return 'You can contact us via WhatsApp or by calling our customer service. Check the homepage for details.';
    } else if (userMessage.contains('time') ||
        userMessage.contains('hours') ||
        userMessage.contains('timing')) {
      return 'Our standard hours are 9 AM to 9 PM, but specific service availability may vary. Please check the booking section.';
    }
    return 'I am a simple bot. I can answer questions about bookings, services, or general inquiries. Could you please rephrase?';
  }

  void _handleSubmitted(String text) {
    if (text.isEmpty) return; // Don't send empty messages
    _textController.clear();

    // Add user message
    setState(() {
      _messages.insert(0, ChatMessage(text: text, isUser: true));
    });

    // Get bot response after a short delay for a "typing" effect
    Future.delayed(const Duration(milliseconds: 500), () {
      setState(() {
        _messages.insert(
          0,
          ChatMessage(text: _getBotResponse(text), isUser: false),
        );
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Lipslay Chatbot',
          style: TextStyle(color: AppColors.black),
        ),
        backgroundColor: AppColors.secondaryDark, // Pink color
        iconTheme: const IconThemeData(
          color: AppColors.black,
        ), // White back arrow
      ),
      body: Column(
        children: [
          Flexible(
            child: ListView.builder(
              padding: const EdgeInsets.all(8.0),
              reverse: true, // To show latest messages at the bottom
              itemCount: _messages.length,
              itemBuilder: (_, int index) => _messages[index],
            ),
          ),
          const Divider(height: 1.0),
          Container(
            decoration: BoxDecoration(color: Theme.of(context).cardColor),
            child: _buildTextComposer(),
          ),
        ],
      ),
    );
  }

  Widget _buildTextComposer() {
    return IconTheme(
      data: IconThemeData(color: Theme.of(context).colorScheme.secondary),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Row(
          children: [
            Flexible(
              child: TextField(
                controller: _textController,
                onSubmitted: _handleSubmitted,
                decoration: const InputDecoration.collapsed(
                  hintText: 'Send a message',
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 4.0),
              child: IconButton(
                icon: const Icon(Icons.send),
                onPressed: () => _handleSubmitted(_textController.text),
                color: const Color(0xFFE91E63), // Pink send button
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Widget to display individual chat messages
class ChatMessage extends StatelessWidget {
  const ChatMessage({required this.text, required this.isUser, super.key});

  final String text;
  final bool isUser;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10.0),
      child: Row(
        mainAxisAlignment:
            isUser ? MainAxisAlignment.end : MainAxisAlignment.start,
        children: [
          if (!isUser) // Bot avatar/icon
            const Padding(
              padding: EdgeInsets.only(right: 8.0),
              child: CircleAvatar(
                backgroundColor: Color(0xFFF48FB1), // Light pink for bot
                child: Icon(
                  Icons.smart_toy,
                  color: AppColors.white,
                ), // <--- CHANGED HERE
              ),
            ),
          Flexible(
            child: Container(
              padding: const EdgeInsets.all(12.0),
              decoration: BoxDecoration(
                color:
                    isUser
                        ? AppColors
                            .accentColor // Pink for user
                        : AppColors
                            .grey200, // Pink for user, light grey for bot
                borderRadius: BorderRadius.circular(15.0),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.grey.withOpacity(0.2),
                    spreadRadius: 1,
                    blurRadius: 3,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Text(
                text,
                style: TextStyle(
                  color: isUser ? AppColors.white : AppColors.black87,
                ),
              ),
            ),
          ),
          if (isUser) // User avatar/icon
            const Padding(
              padding: EdgeInsets.only(left: 8.0),
              child: CircleAvatar(
                backgroundColor:
                    AppColors.primarypageWhite, // Lighter pink for user
                child: Icon(Icons.person, color: AppColors.white),
              ),
            ),
        ],
      ),
    );
  }
}
