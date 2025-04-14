import { Text, View, Pressable, StyleSheet } from "react-native";
import { useRouter } from "expo-router";

export default function Index() {
  const router = useRouter();

  return (
    <View style={styles.container}>
      <Pressable
        style={styles.button}
        onPress={() => router.push("/chat/sophie")}
      >
        <Text style={styles.buttonText}>Open Chat with Sophie</Text>
      </Pressable>
    </View>
  );
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    justifyContent: "center",
    alignItems: "center",
    backgroundColor: "#0B1739",
  },
  button: {
    backgroundColor: "#CB3CFF",
    padding: 16,
    borderRadius: 8,
  },
  buttonText: {
    color: "#FFF",
    fontSize: 16,
    fontWeight: "500",
  },
});
