import SwiftUI

struct ProfilePage: View {
    var body: some View {
        VStack {
            Text("Profile")
                .font(.largeTitle)
                .fontWeight(.bold)
            
            Spacer()
        }
        .navigationTitle("Profile")
    }
}

#Preview {
    ProfilePage()
}
