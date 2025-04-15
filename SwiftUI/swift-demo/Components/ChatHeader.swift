import SwiftUI

struct ChatHeader: View {
    var body: some View {
        HStack {
            HStack(spacing: 8) {
                AsyncImage(url: URL(string: "https://cdn.builder.io/api/v1/image/assets/991ee9a0afad461fa9386316c87fe366/e6007796cc5b81abec5589425fd6ab5c8144a908?placeholderIfAbsent=true")) { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                } placeholder: {
                    Color.gray.opacity(0.3)
                }
                .frame(width: 40, height: 40)
                .clipShape(Circle())

                VStack(alignment: .leading, spacing: 4) {
                    Text("Sophie Moore")
                        .foregroundColor(Theme.textPrimary)
                        .font(.system(size: 16, weight: .medium))

                    Text("@sophiemoore")
                        .foregroundColor(Theme.textSecondary)
                        .font(.system(size: 12))
                }
            }

            Spacer()

            Button(action: {}) {
                HStack(spacing: 6) {
                    Image(systemName: "phone.fill")
                        .resizable()
                        .frame(width: 12, height: 12)
                    Text("Call Sophie")
                        .font(.system(size: 12))
                }
                .foregroundColor(Theme.textPrimary)
                .padding(.horizontal, 8)
                .padding(.vertical, 8)
                .background(Theme.accent)
                .cornerRadius(4)
            }
        }
        .padding(.horizontal)
    }
}