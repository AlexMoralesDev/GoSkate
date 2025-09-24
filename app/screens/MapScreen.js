import { StyleSheet } from "react-native";
import MapView, { Marker } from 'react-native-maps';
import { mockSpots } from "../data/mockData";

export default function MapScreen() {
  return (
    <MapView
      style={styles.map}
      initialRegion={{
        latitude: 34.10003,
        longitude: -118.33889,
        latitudeDelta: 0.0422,
        longitudeDelta: 0.0221,
      }}
    >
      {mockSpots.map((spot) => (
        <Marker
          key={spot.id}
          coordinate={spot.coordinates}
          title={spot.name}
          description={spot.description}
        />
      ))}
    </MapView>
  );
}

const styles = StyleSheet.create({
  map: {
    flex: 1,
  },
});