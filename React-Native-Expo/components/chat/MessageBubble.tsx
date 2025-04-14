import { View, Text, Image, StyleSheet } from "react-native";
import type { Message } from "../../app/chat/[id]";

interface MessageBubbleProps {
  message: Message;
}

export default function MessageBubble({ message }: MessageBubbleProps) {
  const renderContent = () => {
    switch (message.type) {
      case "text":
        return (
          <View
            style={[
              styles.bubble,
              message.isUser ? styles.userBubble : styles.otherBubble,
            ]}
          >
            <Text style={styles.messageText}>{message.text}</Text>
          </View>
        );
      case "image":
        return (
          <Image
            source={{ uri: message.fileUrl }}
            style={styles.imageMessage}
            resizeMode="contain"
          />
        );
      case "file":
        return (
          <View style={styles.fileBubble}>
            <View style={styles.fileContent}>
              <Image
                source={{ uri: message.fileUrl }}
                style={styles.fileIcon}
              />
              <Text style={styles.fileName}>{message.fileName}</Text>
            </View>
          </View>
        );
    }
  };

  return (
    <View
      style={[
        styles.container,
        message.isUser ? styles.userContainer : styles.otherContainer,
      ]}
    >
      {!message.isUser && message.type === "text" && (
        <Image source={{ uri: "https://cdn.builder.io/api/v1/image/assets/991ee9a0afad461fa9386316c87fe366/b514d010f374a0b2685a945947cb7b0671480cb6?placeholderIfAbsent=true" }} style={styles.avatar} />
      )}
      <View style={styles.messageContainer}>
        {renderContent()}
        <Text style={styles.timestamp}>{message.time}</Text>
      </View>
    </View>
  );
}

const styles = StyleSheet.create({
  container: {
    flexDirection: "row",
    marginVertical: 5,
    gap: 10,
  },
  userContainer: {
    justifyContent: "flex-end",
  },
  otherContainer: {
    justifyContent: "flex-start",
  },
  messageContainer: {
    maxWidth: "80%",
  },
  bubble: {
    borderRadius: 10,
    padding: 16,
  },
  userBubble: {
    backgroundColor: "#9A91FB",
  },
  otherBubble: {
    backgroundColor: "#081028",
  },
  messageText: {
    color: "#FFF",
    fontSize: 12,
    lineHeight: 18,
  },
  timestamp: {
    color: "#AEB9E1",
    fontSize: 12,
    marginTop: 8,
    textAlign: "right",
  },
  avatar: {
    width: 32,
    height: 32,
    borderRadius: 16,
    marginTop: "auto",
  },
  imageMessage: {
    width: 260,
    height: 250,
    borderRadius: 10,
  },
  fileBubble: {
    backgroundColor: "#081028",
    borderRadius: 10,
    padding: 16,
  },
  fileContent: {
    flexDirection: "row",
    alignItems: "center",
    gap: 4,
  },
  fileIcon: {
    width: 14,
    height: 14,
  },
  fileName: {
    color: "#FFF",
    fontSize: 12,
  },
});
