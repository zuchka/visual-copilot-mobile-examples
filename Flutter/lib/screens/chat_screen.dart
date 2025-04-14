import 'package:flutter/material.dart';
import '../models/message.dart';
import '../widgets/chat_message.dart';
import '../widgets/message_input.dart';
import '../utils/constants.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final ScrollController _scrollController = ScrollController();
  final List<Message> _messages = [
    Message(
      id: '1',
      text: "Hello John! Hope you're doing well. I need your help with some reports, are you available for a call later today?",
      sender: MessageSender.other,
      senderName: 'Sophie Moore',
      senderAvatar: 'https://cdn.builder.io/api/v1/image/assets/TEMP/d7592323c21c065ea98811e2ff6bb1006d132a6c?placeholderIfAbsent=true',
      timestamp: '10:40 AM',
      isRead: true,
    ),
    Message(
      id: '2',
      text: "Thank you",
      sender: MessageSender.other,
      senderName: 'Sophie Moore',
      senderAvatar: 'https://cdn.builder.io/api/v1/image/assets/TEMP/d7592323c21c065ea98811e2ff6bb1006d132a6c?placeholderIfAbsent=true',
      timestamp: '10:40 AM',
      isRead: true,
    ),
    Message(
      id: '3',
      text: "Hey Sophie! How are you?",
      sender: MessageSender.self,
      timestamp: '11:41 AM',
      isRead: true,
    ),
    Message(
      id: '4',
      text: "For sure, I'll be free after mid-day, let me know what time works for you",
      sender: MessageSender.self,
      timestamp: '11:41 AM',
      isRead: true,
    ),
    Message(
      id: '5',
      text: "What about 2:00 PM? Works for you?",
      sender: MessageSender.other,
      senderName: 'Sophie Moore',
      senderAvatar: 'https://cdn.builder.io/api/v1/image/assets/TEMP/d7592323c21c065ea98811e2ff6bb1006d132a6c?placeholderIfAbsent=true',
      timestamp: '11:45 AM',
      isRead: true,
    ),
    Message(
      id: '6',
      imageUrl: 'https://cdn.builder.io/api/v1/image/assets/TEMP/66b75211fffd7821083d3c6c3c8db06fb9859174?placeholderIfAbsent=true',
      sender: MessageSender.self,
      timestamp: '11:46 AM',
      isRead: true,
      isImage: true,
    ),
    Message(
      id: '7',
      fileAttachment: FileAttachment(
        name: 'analytics-reports.pdf',
        type: 'pdf',
      ),
      sender: MessageSender.other,
      senderName: 'Sophie Moore',
      senderAvatar: 'https://cdn.builder.io/api/v1/image/assets/TEMP/d7592323c21c065ea98811e2ff6bb1006d132a6c?placeholderIfAbsent=true',
      timestamp: '11:47 AM',
      isRead: true,
    ),
  ];

  void _handleSendMessage(String text) {
    if (text.trim().isEmpty) return;
    
    setState(() {
      _messages.add(
        Message(
          id: DateTime.now().millisecondsSinceEpoch.toString(),
          text: text,
          sender: MessageSender.self,
          timestamp: '${DateTime.now().hour}:${DateTime.now().minute.toString().padLeft(2, '0')}',
          isRead: false,
        ),
      );
    });

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(),
            const Divider(
              height: 1,
              thickness: 1,
              color: AppColors.dividerColor,
            ),
            Expanded(
              child: _buildMessageList(),
            ),
            MessageInput(onSendMessage: _handleSendMessage),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Stack(
                children: [
                  const CircleAvatar(
                    radius: 20,
                    backgroundImage: NetworkImage('https://cdn.builder.io/api/v1/image/assets/TEMP/d7592323c21c065ea98811e2ff6bb1006d132a6c?placeholderIfAbsent=true'),
                  ),
                  Positioned(
                    right: 0,
                    bottom: 0,
                    child: Container(
                      width: 8,
                      height: 8,
                      decoration: BoxDecoration(
                        color: AppColors.onlineColor,
                        border: Border.all(
                          color: AppColors.backgroundColor,
                          width: 1.5,
                        ),
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(width: 10),
              const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Sophie Moore',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Text(
                    '@sophiemoore',
                    style: TextStyle(
                      color: AppColors.subtitleColor,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ],
          ),
          ElevatedButton.icon(
            onPressed: () {},
            icon: const Icon(Icons.phone, size: 14, color: Colors.white),
            label: const Text(
              'Call Sophie',
              style: TextStyle(
                fontSize: 12,
                color: Colors.white,
              ),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primaryColor,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(4),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMessageList() {
    return ListView.builder(
      controller: _scrollController,
      padding: const EdgeInsets.all(20),
      itemCount: _messages.length,
      itemBuilder: (context, index) {
        final message = _messages[index];
        final showAvatar = message.sender == MessageSender.other;
        
        // Group messages by sender
        final isFirstInGroup = index == 0 || 
            _messages[index - 1].sender != message.sender;
            
        return Padding(
          padding: const EdgeInsets.only(bottom: 16),
          child: ChatMessage(
            message: message,
            showAvatar: showAvatar && isFirstInGroup,
          ),
        );
      },
    );
  }
}