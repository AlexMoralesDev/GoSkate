import SwiftUI

struct CreatePage: View {
    var body: some View {
        VStack {
            Text("Create")
                .font(.largeTitle)
                .fontWeight(.bold)
            
            Spacer()
        }
        .navigationTitle("Create")
    }
}

#Preview {
    CreatePage()
}
