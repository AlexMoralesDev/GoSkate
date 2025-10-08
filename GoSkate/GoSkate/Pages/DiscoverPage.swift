import SwiftUI

struct DiscoverPage: View {
    var body: some View {
        VStack {
            Text("Discover")
                .font(.largeTitle)
                .fontWeight(.bold)
            
            Spacer()
        }
        .navigationTitle("Discover")
    }
}

#Preview {
    DiscoverPage()
}
