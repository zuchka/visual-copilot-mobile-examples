import Foundation

struct ChatMessage: Identifiable {
    let id = UUID()
    let content: String
    let timestamp: Date
    let isFromCurrentUser: Bool
    let type: MessageType
    
    enum MessageType {
        case text
        case image(URL)
        case file(name: String)
    }
}