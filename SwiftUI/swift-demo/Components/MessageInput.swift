import SwiftUI

struct MessageInput: View {
    @Binding var messageText: String
    var onSend: () -> Void
    
    var body: some View {
        HStack(spacing: 20) {
            TextField("Type a message", text: $messageText)
                .foregroundColor(Theme.textPrimary)
            
            HStack(spacing: 8) {
                Button(action: {}) {
                    Image(systemName: "paperclip")
                        .foregroundColor(Theme.textPrimary)
                }
                
                Button(action: {}) {
                    Image(systemName: "photo")
                        .foregroundColor(Theme.textPrimary)
                }
                
                Button(action: onSend) {
                    Text("Send now")
                        .font(.system(size: 12))
                        .foregroundColor(Theme.textPrimary)
                        .padding(.horizontal, 8)
                        .padding(.vertical, 8)
                        .background(Theme.accent)
                        .cornerRadius(4)
                }
            }
        }
        .padding()
        .background(Theme.secondaryBackground)
    }
}