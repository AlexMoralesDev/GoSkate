import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            DiscoverPage()
                .tabItem {
                    Label("Discover", systemImage: "sparkles")
                }
            
            CreatePage()
                .tabItem {
                    Label("Create", systemImage: "plus.circle")
                }
            
            MapPage()
                .tabItem {
                    Label("Map", systemImage: "map")
                }
            
            ProfilePage()
                .tabItem {
                    Label("Profile", systemImage: "person.circle")
                }
        }
    }
}

#Preview {
    ContentView()
}
