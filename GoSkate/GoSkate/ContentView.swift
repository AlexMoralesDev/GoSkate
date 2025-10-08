import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            Page1()
                .tabItem {
                    Label("Home", systemImage: "house.fill")
                }
            
            Page2()
                .tabItem {
                    Label("Search", systemImage: "magnifyingglass")
                }
            
            Page3()
                .tabItem {
                    Label("Settings", systemImage: "gear")
                }
        }
    }
}

struct Page1: View {
    var body: some View {
        VStack {
            Text("Home Page")
                .font(.largeTitle)
        }
    }
}

struct Page2: View {
    var body: some View {
        VStack {
            Text("Search Page")
                .font(.largeTitle)
        }
    }
}

struct Page3: View {
    var body: some View {
        VStack {
            Text("Settings Page")
                .font(.largeTitle)
        }
    }
}

#Preview {
    ContentView()
}
