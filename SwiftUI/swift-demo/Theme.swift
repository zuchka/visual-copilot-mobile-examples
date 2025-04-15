import SwiftUI

public enum Theme {
    public static let primaryBackground = Color(hex: "0B1739")
    public static let secondaryBackground = Color(hex: "081028")
    public static let accent = Color(hex: "CB3CFF")
    public static let messageBlue = Color(hex: "9A91FB")
    public static let textPrimary = Color.white
    public static let textSecondary = Color(hex: "AEB9E1")
    public static let border = Color(hex: "343B4F")
    
    public static let padding = EdgeInsets(top: 20, leading: 30, bottom: 20, trailing: 30)
    public static let messageSpacing: CGFloat = 12
    public static let cornerRadius: CGFloat = 10
}

extension Color {
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3:
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6:
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8:
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (255, 0, 0, 0)
        }
        self.init(
            .sRGB,
            red: Double(r) / 255,
            green: Double(g) / 255,
            blue:  Double(b) / 255,
            opacity: Double(a) / 255
        )
    }
}