import SwiftUI

struct ContentView: View {
    @State private var messageText = ""
    @State private var messages: [ChatMessage] = [
        ChatMessage(content: "Hello John! Hope you're doing well. I need your help with some reports, are you available for a call later today?", timestamp: Date(), isFromCurrentUser: false, type: .text),
        ChatMessage(content: "Thank you", timestamp: Date(), isFromCurrentUser: false, type: .text),
        ChatMessage(content: "Hey Sophie! How are you?", timestamp: Date(), isFromCurrentUser: true, type: .text),
        ChatMessage(content: "For sure, I'll be free after mid-day, let me know what time works for you", timestamp: Date(), isFromCurrentUser: true, type: .text),
        ChatMessage(content: "What about 2:00 PM? Works for you?", timestamp: Date(), isFromCurrentUser: false, type: .text),
        ChatMessage(content: "Here's the report", timestamp: Date(), isFromCurrentUser: false, type: .file(name: "analytics-reports.pdf")),
        ChatMessage(content: "Perfect, 2:00 PM works for me.", timestamp: Date(), isFromCurrentUser: true, type: .text),
        ChatMessage(content: "Great! Talk soon.", timestamp: Date(), isFromCurrentUser: false, type: .text),
        ChatMessage(content: "Did you get a chance to look at the document I sent yesterday?", timestamp: Date(), isFromCurrentUser: true, type: .text),
        ChatMessage(content: "Yes, I did. It looks good overall, just a few minor suggestions.", timestamp: Date(), isFromCurrentUser: false, type: .text),
        ChatMessage(content: "Okay, cool. Can you send them over?", timestamp: Date(), isFromCurrentUser: true, type: .text),
        ChatMessage(content: "Sure, sending them now.", timestamp: Date(), isFromCurrentUser: false, type: .text),
        ChatMessage(content: "Got it, thanks!", timestamp: Date(), isFromCurrentUser: true, type: .text),
        ChatMessage(content: "How about the weather today? Quite sunny!", timestamp: Date(), isFromCurrentUser: false, type: .text),
        ChatMessage(content: "Yeah, it's beautiful. Planning to go for a walk later.", timestamp: Date(), isFromCurrentUser: true, type: .text),
        ChatMessage(content: "Nice! Enjoy your walk.", timestamp: Date(), isFromCurrentUser: false, type: .text),
        ChatMessage(content: "Thanks, you too!", timestamp: Date(), isFromCurrentUser: true, type: .text)
    ]
    
    var body: some View {
        VStack(spacing: 0) {
            ChatHeader()
                .padding(.top, 20)
            
            Divider()
                .background(Theme.border)
                .padding(.top, 20)
            
            ScrollView {
                LazyVStack(spacing: Theme.messageSpacing) {
                    ForEach(messages) { message in
                        ChatBubble(message: message)
                    }
                }
                .padding(Theme.padding)
            }
            
            MessageInput(messageText: $messageText) {
                // Handle send message
                if !messageText.isEmpty {
                    messages.append(ChatMessage(
                        content: messageText,
                        timestamp: Date(),
                        isFromCurrentUser: true,
                        type: .text
                    ))
                    messageText = ""
                }
            }
        }
        .background(Theme.primaryBackground)
        .edgesIgnoringSafeArea(.bottom)
    }
}

#Preview {
    ContentView()
}