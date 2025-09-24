import { StyleSheet, Text, View } from "react-native";import { createBottomTabNavigator } from '@react-navigation/bottom-tabs';
import HomeScreen from '../screens/HomeScreen';
import ProfileScreen from '../screens/ProfileScreen';
import MapScreen from '../screens/MapScreen';
import SpotsScreen from '../screens/SpotsScreen';

const Tab = createBottomTabNavigator();

export default function BottomTabNavigator() {
  return (
      <Tab.Navigator>
        <Tab.Screen name="Home" component={HomeScreen} />
        <Tab.Screen name="Spots" component={SpotsScreen} />
        <Tab.Screen name="Map" component={MapScreen} />
        <Tab.Screen name= "Profile" component={ProfileScreen} />
      </Tab.Navigator>
  );
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    justifyContent: "center",
    alignItems: "center",
  },
}); 