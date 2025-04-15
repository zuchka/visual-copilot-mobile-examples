import SwiftUI

struct ChatBubble: View {
    let message: ChatMessage
    
    var body: some View {
        HStack(alignment: .bottom, spacing: 0) {
            if !message.isFromCurrentUser {
                AsyncImage(url: URL(string: "https://cdn.builder.io/api/v1/image/assets/991ee9a0afad461fa9386316c87fe366/e6007796cc5b81abec5589425fd6ab5c8144a908?placeholderIfAbsent=true")) { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                } placeholder: {
                    Color.gray.opacity(0.3)
                }
                .frame(width: 32, height: 32)
                .clipShape(Circle())
                .padding(.trailing, 8)
                
                VStack(alignment: .leading, spacing: 4) {
                    switch message.type {
                    case .text:
                        Text(message.content)
                            .font(.system(size: 12))
                            .padding(12)
                            .background(Theme.secondaryBackground)
                            .foregroundColor(Theme.textPrimary)
                            .cornerRadius(Theme.cornerRadius)
                    case .image(let url):
                        AsyncImage(url: url) { image in
                            image.resizable()
                                .aspectRatio(contentMode: .fit)
                        } placeholder: {
                            ProgressView()
                        }
                        .cornerRadius(Theme.cornerRadius)
                    case .file(let name):
                        HStack(spacing: 4) {
                            Image(systemName: "doc")
                            Text(name)
                                .font(.system(size: 12))
                        }
                        .padding(12)
                        .background(Theme.secondaryBackground)
                        .foregroundColor(Theme.textPrimary)
                        .cornerRadius(Theme.cornerRadius)
                    }
                    
                    Text(message.timestamp.formatted(.dateTime.hour().minute()))
                        .font(.system(size: 10))
                        .foregroundColor(Theme.textSecondary)
                }
                
                Spacer()
            } else {
                Spacer()
                
                VStack(alignment: .trailing, spacing: 4) {
                    switch message.type {
                    case .text:
                        Text(message.content)
                            .font(.system(size: 12))
                            .padding(12)
                            .background(Theme.messageBlue)
                            .foregroundColor(Theme.textPrimary)
                            .cornerRadius(Theme.cornerRadius)
                    case .image(let url):
                        AsyncImage(url: url) { image in
                            image.resizable()
                                .aspectRatio(contentMode: .fit)
                        } placeholder: {
                            ProgressView()
                        }
                        .cornerRadius(Theme.cornerRadius)
                    case .file(let name):
                        HStack(spacing: 4) {
                            Image(systemName: "doc")
                            Text(name)
                                .font(.system(size: 12))
                        }
                        .padding(12)
                        .background(Theme.messageBlue)
                        .foregroundColor(Theme.textPrimary)
                        .cornerRadius(Theme.cornerRadius)
                    }
                    
                    Text(message.timestamp.formatted(.dateTime.hour().minute()))
                        .font(.system(size: 10))
                        .foregroundColor(Theme.textSecondary)
                }
            }
        }
        .padding(.horizontal, 4)
        .padding(.vertical, 2)
    }
}