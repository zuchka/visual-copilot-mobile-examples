enum MessageSender {
  self,
  other,
}

class FileAttachment {
  final String name;
  final String type;

  FileAttachment({
    required this.name,
    required this.type,
  });
}

class Message {
  final String id;
  final String? text;
  final String? imageUrl;
  final FileAttachment? fileAttachment;
  final MessageSender sender;
  final String? senderName;
  final String? senderAvatar;
  final String timestamp;
  final bool isRead;
  final bool isImage;

  Message({
    required this.id,
    this.text,
    this.imageUrl,
    this.fileAttachment,
    required this.sender,
    this.senderName,
    this.senderAvatar,
    required this.timestamp,
    required this.isRead,
    this.isImage = false,
  });
}