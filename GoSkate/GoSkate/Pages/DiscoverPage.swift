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
                
                FeaturedSection(spot: sampleSpots[0])
                
                NearbySection(spots: Array(sampleSpots.prefix(4)))
                
                PopularSection(spots: Array(sampleSpots.suffix(3)))
                
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

struct FeaturedSection: View {
    let spot: SkateSpot
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("FEATURED")
                .font(.system(size: 14, weight: .black, design: .default))
                .tracking(2)
                .foregroundColor(Color(hex: "3F4B3B"))
                .padding(.horizontal)
            
            FeaturedSpotCard(spot: spot)
                .padding(.horizontal)
        }
    }
}

struct FeaturedSpotCard: View {
    let spot: SkateSpot
    
    var body: some View {
        ZStack(alignment: .bottomLeading) {
            // Ramp shape background
            Rectangle()
                .fill(
                    LinearGradient(
                        colors: [
                            Color(hex: "44633F"),
                            Color(hex: "5A9367")
                        ],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                )
                .frame(height: 200)
                .overlay(
                    // Ramp lines
                    VStack(spacing: 0) {
                        Spacer()
                        Rectangle()
                            .fill(Color(hex: "3F4B3B").opacity(0.3))
                            .frame(height: 2)
                        Spacer()
                        Rectangle()
                            .fill(Color(hex: "3F4B3B").opacity(0.3))
                            .frame(height: 2)
                        Spacer()
                    }
                )
            
            // Angled cut at top right (coping)
            Path { path in
                path.move(to: CGPoint(x: UIScreen.main.bounds.width - 100, y: 0))
                path.addLine(to: CGPoint(x: UIScreen.main.bounds.width , y: 0))
                path.addLine(to: CGPoint(x: UIScreen.main.bounds.width, y: 40))
            }
            .fill(Color(hex: "3F4B3B"))
            
            // Content
            VStack(alignment: .leading, spacing: 10) {
                HStack {
                    Image(systemName: spot.category.icon)
                        .font(.system(size: 11, weight: .bold))
                    Text(spot.category.rawValue.uppercased())
                        .font(.system(size: 10, weight: .black))
                        .tracking(1)
                }
                .padding(.horizontal, 10)
                .padding(.vertical, 6)
                .background(Color(hex: "5CAB7D"))
                .foregroundColor(Color(hex: "3F4B3B"))
                .overlay(
                    Rectangle()
                        .stroke(Color(hex: "3F4B3B"), lineWidth: 1.5)
                )
                
                Spacer()
                
                VStack(alignment: .leading, spacing: 6) {
                    Text(spot.name.uppercased())
                        .font(.system(size: 22, weight: .black, design: .default))
                        .tracking(1)
                    
                    HStack(spacing: 16) {
                        HStack(spacing: 4) {
                            Image(systemName: "star.fill")
                                .font(.system(size: 11))
                            Text(String(format: "%.1f", spot.rating))
                                .font(.system(size: 13, weight: .bold))
                        }
                        
                        Rectangle()
                            .fill(Color(hex: "5CAB7D"))
                            .frame(width: 2, height: 12)
                        
                        HStack(spacing: 4) {
                            Image(systemName: "location.fill")
                                .font(.system(size: 11))
                            Text(spot.distance)
                                .font(.system(size: 13, weight: .bold))
                        }
                    }
                    .foregroundColor(Color(hex: "5CAB7D"))
                }
            }
            .foregroundColor(.white)
            .padding(16)
        }
        .overlay(
            Rectangle()
                .stroke(Color(hex: "3F4B3B"), lineWidth: 3)
        )
    }
}

struct NearbySection: View {
    let spots: [SkateSpot]
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack {
                Text("NEARBY")
                    .font(.system(size: 14, weight: .black, design: .default))
                    .tracking(2)
                    .foregroundColor(Color(hex: "3F4B3B"))
                Spacer()
                Button("VIEW ALL →") {}
                    .font(.system(size: 11, weight: .heavy))
                    .foregroundColor(Color(hex: "5A9367"))
            }
            .padding(.horizontal)
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 12) {
                    ForEach(spots) { spot in
                        NearbySpotCard(spot: spot)
                    }
                }
                .padding(.horizontal)
            }
        }
    }
}

struct NearbySpotCard: View {
    let spot: SkateSpot
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            // Stair step design
            ZStack(alignment: .topLeading) {
                Rectangle()
                    .fill(Color(hex: "5A9367"))
                    .frame(width: 150, height: 100)
                
                // Step effect
                VStack(spacing: 0) {
                    HStack(spacing: 0) {
                        Spacer()
                        Rectangle()
                            .fill(Color(hex: "44633F"))
                            .frame(width: 50, height: 25)
                    }
                    HStack(spacing: 0) {
                        Spacer()
                        Rectangle()
                            .fill(Color(hex: "3F4B3B"))
                            .frame(width: 25, height: 25)
                    }
                }
                
                Image(systemName: spot.category.icon)
                    .font(.system(size: 28, weight: .bold))
                    .foregroundColor(.white.opacity(0.9))
                    .padding(12)
            }
            .overlay(
                Rectangle()
                    .stroke(Color(hex: "3F4B3B"), lineWidth: 2)
            )
            
            VStack(alignment: .leading, spacing: 6) {
                Text(spot.name.uppercased())
                    .font(.system(size: 11, weight: .black))
                    .tracking(0.5)
                    .lineLimit(2)
                    .foregroundColor(Color(hex: "3F4B3B"))
                
                HStack(spacing: 6) {
                    Image(systemName: "star.fill")
                        .font(.system(size: 9))
                        .foregroundColor(Color(hex: "5A9367"))
                    Text(String(format: "%.1f", spot.rating))
                        .font(.system(size: 10, weight: .bold))
                        .foregroundColor(Color(hex: "44633F"))
                    
                    Spacer()
                    
                    Text(spot.distance)
                        .font(.system(size: 9, weight: .bold))
                        .foregroundColor(Color(hex: "5A9367"))
                }
            }
            .padding(10)
            .background(Color.white)
            .overlay(
                Rectangle()
                    .stroke(Color(hex: "3F4B3B"), lineWidth: 2)
            )
        }
        .frame(width: 150)
    }
}
struct PopularSection: View {
    let spots: [SkateSpot]
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack {
                Text("POPULAR THIS WEEK")
                    .font(.system(size: 14, weight: .black, design: .default))
                    .tracking(2)
                    .foregroundColor(Color(hex: "3F4B3B"))
                Spacer()
                Button("VIEW ALL →") {}
                    .font(.system(size: 11, weight: .heavy))
                    .foregroundColor(Color(hex: "5A9367"))
            }
            .padding(.horizontal)
            
            VStack(spacing: 10) {
                ForEach(spots) { spot in
                    PopularSpotRow(spot: spot)
                        .padding(.horizontal)
                }
            }
        }
    }
}

struct PopularSpotRow: View {
    let spot: SkateSpot
    
    var body: some View {
        HStack(spacing: 0) {
            // Ledge block
            ZStack {
                Rectangle()
                    .fill(Color(hex: "5CAB7D"))
                    .frame(width: 65, height: 65)
                
                // Top ledge surface
                Rectangle()
                    .fill(Color(hex: "44633F"))
                    .frame(width: 65, height: 8)
                    .offset(y: -28.5)
                
                Image(systemName: spot.category.icon)
                    .font(.system(size: 24, weight: .bold))
                    .foregroundColor(Color(hex: "3F4B3B"))
            }
            .overlay(
                Rectangle()
                    .stroke(Color(hex: "3F4B3B"), lineWidth: 2)
            )
            
            VStack(alignment: .leading, spacing: 6) {
                Text(spot.name.uppercased())
                    .font(.system(size: 12, weight: .black))
                    .tracking(0.5)
                    .foregroundColor(Color(hex: "3F4B3B"))
                
                HStack(spacing: 10) {
                    HStack(spacing: 4) {
                        Image(systemName: "star.fill")
                            .font(.system(size: 9))
                            .foregroundColor(Color(hex: "5A9367"))
                        Text(String(format: "%.1f", spot.rating))
                            .font(.system(size: 10, weight: .bold))
                            .foregroundColor(Color(hex: "44633F"))
                    }
                    
                    Rectangle()
                        .fill(Color(hex: "44633F"))
                        .frame(width: 1.5, height: 10)
                    
                    HStack(spacing: 4) {
                        Image(systemName: "location.fill")
                            .font(.system(size: 9))
                        Text(spot.distance)
                            .font(.system(size: 10, weight: .bold))
                    }
                    .foregroundColor(Color(hex: "44633F"))
                }
                
                Text("\(spot.reviews) REVIEWS")
                    .font(.system(size: 8, weight: .black))
                    .tracking(0.5)
                    .foregroundColor(Color(hex: "5A9367"))
            }
            .padding(.horizontal, 12)
            
            Spacer()
            
            // Arrow
            Image(systemName: "chevron.right")
                .font(.system(size: 12, weight: .bold))
                .foregroundColor(Color(hex: "44633F"))
                .padding(.trailing, 12)
        }
        .frame(height: 65)
        .background(Color.white)
        .overlay(
            Rectangle()
                .stroke(Color(hex: "3F4B3B"), lineWidth: 2)
        )
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
