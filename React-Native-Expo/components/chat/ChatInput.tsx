import {
  View,
  TextInput,
  Image,
  Pressable,
  StyleSheet,
  Text,
} from "react-native";
import { useState } from "react";

interface ChatInputProps {
  onSend: (message: string) => void;
}

export default function ChatInput({ onSend }: ChatInputProps) {
  const [message, setMessage] = useState("");

  const handleSend = () => {
    if (!message.trim()) return;
    onSend(message);
    setMessage("");
  };

  return (
    <View style={styles.container}>
      <TextInput
        style={styles.input}
        placeholder="Type a message"
        placeholderTextColor="#FFF"
        value={message}
        onChangeText={setMessage}
      />
      <View style={styles.actions}>
        <Pressable>
          <Image
            source={{
              uri: "https://cdn.builder.io/api/v1/image/assets/991ee9a0afad461fa9386316c87fe366/fe3439786163edaf4cd27cda8f7f0a4c6f0879db?placeholderIfAbsent=true",
            }}
            style={styles.icon}
          />
        </Pressable>
        <Pressable>
          <Image
            source={{
              uri: "https://cdn.builder.io/api/v1/image/assets/991ee9a0afad461fa9386316c87fe366/b2015707e3d89ce0d4af5ed1736140a531daf516?placeholderIfAbsent=true",
            }}
            style={styles.icon}
          />
        </Pressable>
        <Pressable style={styles.sendButton} onPress={handleSend}>
          <Text style={styles.sendButtonText}>Send now</Text>
        </Pressable>
      </View>
    </View>
  );
}

const styles = StyleSheet.create({
  container: {
    backgroundColor: "#081028",
    padding: 15,
    paddingHorizontal: 25,
    flexDirection: "row",
    alignItems: "center",
    justifyContent: "space-between",
    gap: 20,
  },
  input: {
    flex: 1,
    color: "#FFF",
    fontSize: 12,
  },
  actions: {
    flexDirection: "row",
    alignItems: "center",
    gap: 8,
  },
  icon: {
    width: 14,
    height: 14,
  },
  sendButton: {
    backgroundColor: "#CB3CFF",
    borderRadius: 4,
    paddingVertical: 8,
    paddingHorizontal: 8,
  },
  sendButtonText: {
    color: "#FFF",
    fontSize: 12,
  },
});
