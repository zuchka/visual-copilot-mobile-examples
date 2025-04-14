import { View, StyleSheet, FlatList } from "react-native";
import { SafeAreaProvider } from "react-native-safe-area-context";
import { useLocalSearchParams } from "expo-router";
import ChatHeader from "../../components/chat/ChatHeader";
import MessageBubble from "../../components/chat/MessageBubble";
import ChatInput from "../../components/chat/ChatInput";
import { useState } from "react";

export interface Message {
  id: string;
  text: string;
  time: string;
  isUser: boolean;
  type: "text" | "file" | "image";
  fileUrl?: string;
  fileName?: string;
}

const initialMessages: Message[] = [
  {
    id: "1",
    text: "Hello John! Hope you're doing well. I need your help with some reports, are you available for a call later today?",
    time: "10:40 AM",
    isUser: false,
    type: "text",
  },
  {
    id: "2",
    text: "Thank you",
    time: "10:40 AM",
    isUser: false,
    type: "text",
  },
  {
    id: "3",
    text: "Hey Sophie! How are you?",
    time: "11:41 AM",
    isUser: true,
    type: "text",
  },
  {
    id: "4",
    text: "For sure, I'll be free after mid-day, let me know what time works for you",
    time: "11:41 AM",
    isUser: true,
    type: "text",
  },
  {
    id: "5",
    text: "What about 2:00 PM? Works for you?",
    time: "11:45 AM",
    isUser: false,
    type: "text",
  },
  {
    id: "6",
    type: "image",
    text: "",
    time: "11:46 AM",
    isUser: true,
    fileUrl:
      "https://cdn.builder.io/api/v1/image/assets/991ee9a0afad461fa9386316c87fe366/ab3feea9acab663e7cc555db178af0b6cee40586?placeholderIfAbsent=true",
  },
  {
    id: "7",
    type: "file",
    text: "",
    time: "11:47 AM",
    isUser: false,
    fileUrl:
      "https://cdn.builder.io/api/v1/image/assets/991ee9a0afad461fa9386316c87fe366/12c8adebf1b24bf5dfd218609929c2931585d47c?placeholderIfAbsent=true",
    fileName: "analytics-reports.pdf",
  },
];

export default function ChatScreen() {
  const { id } = useLocalSearchParams();
  const [messages, setMessages] = useState<Message[]>(initialMessages);

  const handleSendMessage = (text: string) => {
    if (!text.trim()) return;

    const newMessage: Message = {
      id: Date.now().toString(),
      text,
      time: new Date().toLocaleTimeString([], {
        hour: "2-digit",
        minute: "2-digit",
      }),
      isUser: true,
      type: "text",
    };

    setMessages((prev) => [...prev, newMessage]);
  };

  return (
    <SafeAreaProvider>
      <View style={styles.container}>
        <ChatHeader
          name="Sophie Moore"
          username="@sophiemoore"
          avatarUrl="https://cdn.builder.io/api/v1/image/assets/991ee9a0afad461fa9386316c87fe366/e6007796cc5b81abec5589425fd6ab5c8144a908?placeholderIfAbsent=true"
        />
        <FlatList
          data={messages}
          keyExtractor={(item) => item.id}
          renderItem={({ item }) => <MessageBubble message={item} />}
          style={styles.messageList}
          contentContainerStyle={styles.messageListContent}
        />
        <ChatInput onSend={handleSendMessage} />
      </View>
    </SafeAreaProvider>
  );
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    backgroundColor: "#0B1739",
  },
  messageList: {
    flex: 1,
    paddingHorizontal: 30,
  },
  messageListContent: {
    paddingVertical: 20,
    gap: 9,
  },
});
