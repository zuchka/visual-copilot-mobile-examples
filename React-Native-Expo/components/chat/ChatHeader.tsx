import { View, Text, Image, StyleSheet, Pressable } from "react-native";
import { SafeAreaView } from "react-native-safe-area-context";
import { Feather } from "@expo/vector-icons";

interface ChatHeaderProps {
  name: string;
  username: string;
  avatarUrl: string;
}

export default function ChatHeader({
  name,
  username,
  avatarUrl,
}: ChatHeaderProps) {
  return (
    <SafeAreaView style={styles.safeArea}>
      <View style={styles.container}>
        <View style={styles.content}>
          <View style={styles.userInfo}>
            <Image source={{ uri: avatarUrl }} style={styles.avatar} />
            <View style={styles.textContainer}>
              <Text style={styles.name}>{name}</Text>
              <Text style={styles.username}>{username}</Text>
            </View>
          </View>
          <Pressable style={styles.callButton}>
            <Feather name="phone" size={12} color="white" />
            <Text style={styles.callButtonText}>Call Sophie</Text>
          </Pressable>
        </View>
      </View>
    </SafeAreaView>
  );
}

const styles = StyleSheet.create({
  safeArea: {
    backgroundColor: "#0B1739",
  },
  container: {
    paddingVertical: 16,
    paddingHorizontal: 20,
    backgroundColor: "#0B1739",
  },
  content: {
    flexDirection: "row",
    justifyContent: "space-between",
    alignItems: "center",
  },
  userInfo: {
    flexDirection: "row",
    alignItems: "center",
    gap: 8,
  },
  avatar: {
    width: 40,
    height: 40,
    borderRadius: 20,
  },
  textContainer: {
    gap: 4,
    alignItems: "flex-start",
  },
  name: {
    color: "#FFF",
    fontSize: 16,
    fontWeight: "500",
    textAlign: "left",
  },
  username: {
    color: "#AEB9E1",
    fontSize: 12,
    textAlign: "left",
  },
  callButton: {
    flexDirection: "row",
    alignItems: "center",
    backgroundColor: "#CB3CFF",
    borderRadius: 4,
    paddingVertical: 8,
    paddingHorizontal: 12,
    gap: 6,
  },
  callButtonText: {
    color: "#FFF",
    fontSize: 12,
    fontWeight: "500",
  },
});
