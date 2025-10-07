import { useState } from "react";
import { View, Text, TouchableOpacity, StyleSheet } from "react-native";
import { Ionicons } from "@expo/vector-icons";

type Page = "home" | "create" | "map" | "profile";

interface NavItem {
  id: Page;
  label: string;
  icon: keyof typeof Ionicons.glyphMap;
}

export default function NavigationBar() {
  const [activePage, setActivePage] = useState<Page>("home");

  const navItems: NavItem[] = [
    { id: "home", label: "Home", icon: "home" },
    { id: "create", label: "Create", icon: "add-circle" },
    { id: "map", label: "Map", icon: "map" },
    { id: "profile", label: "Profile", icon: "person" },
  ];

  return (
    <View style={styles.container}>
      {/* Page Content */}
      <View style={styles.content}>
        <View style={styles.card}>
          <Text style={styles.title}>
            {navItems
              .find((item) => item.id === activePage)
              ?.label.toUpperCase()}
          </Text>
          <Text style={styles.description}>
            This is the {activePage} page content. Use the bottom navigation to
            switch pages.
          </Text>
        </View>
      </View>

      {/* Bottom Navigation Bar */}
      <View style={styles.navbar}>
        <View style={styles.navContainer}>
          {navItems.map((item) => (
            <TouchableOpacity
              key={item.id}
              onPress={() => setActivePage(item.id)}
              style={styles.navButton}
            >
              <Ionicons
                name={item.icon}
                size={28}
                color={activePage === item.id ? "#DC2626" : "#FFFFFF"}
                style={activePage === item.id && styles.iconActive}
              />
              <Text
                style={[
                  styles.label,
                  activePage === item.id && styles.labelActive,
                ]}
              >
                {item.label.toUpperCase()}
              </Text>
            </TouchableOpacity>
          ))}
        </View>
      </View>
    </View>
  );
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    backgroundColor: "#000000",
  },
  content: {
    flex: 1,
    padding: 16,
    paddingTop: 60,
    paddingBottom: 100,
  },
  card: {
    backgroundColor: "#18181B",
    borderRadius: 8,
    borderWidth: 2,
    borderColor: "#DC2626",
    padding: 24,
  },
  title: {
    fontSize: 32,
    fontWeight: "900",
    color: "#FFFFFF",
    marginBottom: 16,
    letterSpacing: -0.5,
  },
  description: {
    fontSize: 16,
    color: "#D1D5DB",
    fontWeight: "500",
  },
  navbar: {
    position: "absolute",
    bottom: 0,
    left: 0,
    right: 0,
    backgroundColor: "#000000",
    borderTopWidth: 4,
    borderTopColor: "#DC2626",
  },
  navContainer: {
    flexDirection: "row",
    justifyContent: "space-around",
    alignItems: "center",
    height: 80,
    paddingHorizontal: 8,
  },
  navButton: {
    flex: 1,
    alignItems: "center",
    justifyContent: "center",
    paddingVertical: 8,
  },
  icon: {
    fontSize: 28,
    marginBottom: 4,
  },
  iconActive: {
    transform: [{ scale: 1.1 }],
  },
  label: {
    fontSize: 10,
    fontWeight: "900",
    color: "#FFFFFF",
    letterSpacing: 1,
  },
  labelActive: {
    color: "#DC2626",
  },
});
