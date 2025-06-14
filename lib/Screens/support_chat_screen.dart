import 'package:flutter/material.dart';

class SupportChatScreen extends StatefulWidget {
  const SupportChatScreen({super.key});

  @override
  State<SupportChatScreen> createState() => _SupportChatScreenState();
}

class _SupportChatScreenState extends State<SupportChatScreen> {
  final List<Map<String, String>> _messages = [
    {'sender': 'bot', 'text': 'Hi! This is SupportBot. How can I help you today?'},
    {'sender': 'user', 'text': 'Hello, I want to know how to pay the runner after my task is done.'},
    {'sender': 'bot', 'text': 'Great question! Once your runner marks the task as completed, you will be prompted to review and confirm the completion.'},
    {'sender': 'user', 'text': 'What happens after I confirm the task is done?'},
    {'sender': 'bot', 'text': 'After you confirm, the payment will be released to the runner automatically. No extra steps are needed from your side.'},
  ];
  final TextEditingController _controller = TextEditingController();

  void _sendMessage() {
    final text = _controller.text.trim();
    if (text.isNotEmpty) {
      setState(() {
        _messages.add({'sender': 'user', 'text': text});
        _controller.clear();
      });
      Future.delayed(const Duration(milliseconds: 600), () {
        setState(() {
          _messages.add({'sender': 'bot', 'text': _getBotReply(text)});
        });
      });
    }
  }

  String _getBotReply(String userMessage) {
    // Simple prototype logic
    if (userMessage.toLowerCase().contains('hello') || userMessage.toLowerCase().contains('hi')) {
      return 'Hello! How can I assist you?';
    } else if (userMessage.toLowerCase().contains('pay')) {
      return 'You can pay the runner by confirming the task completion. The payment will be released automatically.';
    } else if (userMessage.toLowerCase().contains('confirm')) {
      return 'After you confirm the task is done, the runner will receive their payment.';
    } else if (userMessage.toLowerCase().contains('bye')) {
      return 'Goodbye! If you need more help, just type your message.';
    } else {
      return 'Thank you for your message. Our support team will get back to you soon.';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Support Chat')),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                final isBot = _messages[index]['sender'] == 'bot';
                return Align(
                  alignment: isBot ? Alignment.centerLeft : Alignment.centerRight,
                  child: Container(
                    margin: const EdgeInsets.symmetric(vertical: 4),
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: isBot ? Colors.green[50] : Colors.blue[100],
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(_messages[index]['text'] ?? ''),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(12, 0, 12, 24), // More space at the bottom
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: Color(0xFFE0E0E0), width: 1.2),
                borderRadius: BorderRadius.circular(16),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _controller,
                      decoration: const InputDecoration(
                        hintText: 'Type your message...',
                        border: InputBorder.none,
                        isDense: true,
                        contentPadding: EdgeInsets.symmetric(vertical: 8),
                      ),
                      onSubmitted: (_) => _sendMessage(),
                    ),
                  ),
                  const SizedBox(width: 8),
                  IconButton(
                    icon: const Icon(Icons.send, color: Colors.blue),
                    onPressed: _sendMessage,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
} 