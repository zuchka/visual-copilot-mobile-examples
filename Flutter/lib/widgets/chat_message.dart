import 'package:flutter/material.dart';
import '../models/message.dart';
import '../utils/constants.dart';

class ChatMessage extends StatelessWidget {
  final Message message;
  final bool showAvatar;

  const ChatMessage({
    Key? key,
    required this.message,
    this.showAvatar = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isOtherSender = message.sender == MessageSender.other;

    return Row(
      mainAxisAlignment: isOtherSender 
          ? MainAxisAlignment.start 
          : MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (isOtherSender && showAvatar) _buildAvatar(),
        if (isOtherSender && !showAvatar) const SizedBox(width: 40),
        const SizedBox(width: 10),
        Flexible(
          child: Column(
            crossAxisAlignment: isOtherSender 
                ? CrossAxisAlignment.start 
                : CrossAxisAlignment.end,
            children: [
              _buildMessageContent(),
              const SizedBox(height: 4),
              _buildTimestamp(),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildAvatar() {
    return Stack(
      children: [
        CircleAvatar(
          radius: 20,
          backgroundImage: NetworkImage(message.senderAvatar ?? 'https://cdn.builder.io/api/v1/image/assets/TEMP/d7592323c21c065ea98811e2ff6bb1006d132a6c?placeholderIfAbsent=true'),
        ),
        Positioned(
          right: 0,
          bottom: 0,
          child: Container(
            width: 7,
            height: 7,
            decoration: BoxDecoration(
              color: AppColors.onlineColor,
              border: Border.all(
                color: AppColors.backgroundColor,
                width: 1,
              ),
              borderRadius: BorderRadius.circular(3.5),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildMessageContent() {
    if (message.isImage && message.imageUrl != null) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Image.network(
          message.imageUrl!,
          width: 260,
          height: 249,
          fit: BoxFit.cover,
        ),
      );
    } else if (message.fileAttachment != null) {
      return _buildFileAttachment();
    } else {
      return Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: message.sender == MessageSender.other
              ? AppColors.messageBubbleOther
              : AppColors.messageBubbleSelf,
          borderRadius: BorderRadius.circular(10),
        ),
        constraints: const BoxConstraints(maxWidth: 260),
        child: Text(
          message.text ?? '',
          style: const TextStyle(
            color: Colors.white,
            fontSize: 12,
            height: 1.5,
          ),
        ),
      );
    }
  }

  Widget _buildFileAttachment() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: message.sender == MessageSender.other
            ? AppColors.messageBubbleOther
            : AppColors.messageBubbleSelf,
        borderRadius: BorderRadius.circular(10),
      ),
      constraints: const BoxConstraints(maxWidth: 260),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.insert_drive_file,
            color: Colors.red.shade400,
            size: 14,
          ),
          const SizedBox(width: 8),
          Text(
            message.fileAttachment!.name,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTimestamp() {
    return Text(
      message.timestamp,
      style: const TextStyle(
        color: AppColors.subtitleColor,
        fontSize: 12,
      ),
    );
  }
}