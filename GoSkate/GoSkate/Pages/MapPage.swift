import SwiftUI

struct MapPage: View {
    var body: some View {
        VStack {
            Text("Map")
                .font(.largeTitle)
                .fontWeight(.bold)
            
            Spacer()
        }
        .navigationTitle("Map")
    }
}

#Preview {
    MapPage()
}
