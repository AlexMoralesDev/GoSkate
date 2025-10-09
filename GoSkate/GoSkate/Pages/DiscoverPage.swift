import SwiftUI

struct DiscoverPage: View {
    @State private var searchText = ""
    @State private var selectedCategory: SpotCategory = .all
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                

                SearchBar(searchText: $searchText)
                    .padding(.horizontal)
                
                CategoryFilter(selectedCategory: $selectedCategory)
                
                
            }
            .padding(.vertical, 20)
        }
        .background(Color(hex: "F5F5F0"))
        .navigationTitle("Discover")
        .navigationBarTitleDisplayMode(.large)
    }
}

struct SearchBar: View {
    @Binding var searchText: String
    
    var body: some View {
        HStack {
            Image(systemName: "magnifyingglass")
                .foregroundColor(Color(hex: "5A9367"))
            TextField("Search skate spots...", text: $searchText)
                .foregroundColor(Color(hex: "3F4B3B"))
        }
        .padding()
        .background(Color(hex: "5CAB7D").opacity(0.15))
        .overlay(
            Rectangle()
                .stroke(Color(hex: "44633F"), lineWidth: 2)
        )
    }
}

struct CategoryFilter: View {
    @Binding var selectedCategory: SpotCategory
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 10) {
                ForEach(SpotCategory.allCases, id: \.self) { category in
                    CategoryButton(
                        category: category,
                        isSelected: selectedCategory == category
                    ) {
                        selectedCategory = category
                    }
                }
            }
            .padding(.horizontal)
        }
    }
}

struct CategoryButton: View {
    let category: SpotCategory
    let isSelected: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            HStack(spacing: 6) {
                Image(systemName: category.icon)
                    .font(.system(size: 12, weight: .bold))
                Text(category.rawValue.uppercased())
                    .font(.system(size: 11, weight: .black, design: .default))
                    .tracking(1)
            }
            .padding(.horizontal, 14)
            .padding(.vertical, 10)
            .background(
                ZStack {
                    if isSelected {
                        Color(hex: "44633F")
                    } else {
                        Color.white
                    }
                    // Rail edge effect
                    Rectangle()
                        .fill(Color(hex: "3F4B3B"))
                        .frame(height: 3)
                        .offset(y: 15)
                }
            )
            .foregroundColor(isSelected ? Color(hex: "5CAB7D") : Color(hex: "3F4B3B"))
            .overlay(
                Rectangle()
                    .stroke(Color(hex: "3F4B3B"), lineWidth: 2)
            )
        }
    }
}



// Custom Shapes
struct Parallelogram: Shape {
    var skew: CGFloat
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let offset = rect.height * skew
        
        path.move(to: CGPoint(x: rect.minX + offset, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.maxX - offset, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY))
        path.closeSubpath()
        
        return path
    }
}


extension Color {
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 6: // RGB
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB
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

// Models
enum SpotCategory: String, CaseIterable {
    case all = "All"
    case park = "Park"
    case street = "Street"
    case bowl = "Bowl"
    case stairs = "Stairs"
    case rails = "Rails"
    
    var icon: String {
        switch self {
        case .all: return "square.grid.2x2"
        case .park: return "figure.skating"
        case .street: return "road.lanes"
        case .bowl: return "circle.circle"
        case .stairs: return "stairs"
        case .rails: return "minus"
        }
    }
}

struct SkateSpot: Identifiable {
    let id = UUID()
    let name: String
    let category: SpotCategory
    let rating: Double
    let distance: String
    let reviews: Int
}

struct RecentActivity: Identifiable {
    let id = UUID()
    let user: String
    let action: String
    let time: String
    let icon: String
}

// Sample Data
let sampleSpots = [
    SkateSpot(name: "Downtown Skatepark", category: .park, rating: 4.8, distance: "0.5 mi", reviews: 124),
    SkateSpot(name: "City Hall Plaza", category: .street, rating: 4.5, distance: "1.2 mi", reviews: 89),
    SkateSpot(name: "Riverside Bowl", category: .bowl, rating: 4.9, distance: "2.1 mi", reviews: 156),
    SkateSpot(name: "Lincoln High 12 Stair", category: .stairs, rating: 4.3, distance: "0.8 mi", reviews: 67),
    SkateSpot(name: "Harbor Rails", category: .rails, rating: 4.6, distance: "1.5 mi", reviews: 93)
]

let sampleActivities = [
    RecentActivity(user: "Jake Martinez", action: "posted a new clip at Downtown Skatepark", time: "2 hours ago", icon: "video.fill"),
    RecentActivity(user: "Sarah Chen", action: "reviewed City Hall Plaza", time: "5 hours ago", icon: "star.fill"),
    RecentActivity(user: "Mike Johnson", action: "added Riverside Bowl to favorites", time: "1 day ago", icon: "heart.fill")
]

#Preview {
    NavigationView {
        DiscoverPage()
    }
}
