import { Controller } from "@hotwired/stimulus";
// Connects to data-controller="map"
export default class extends Controller {
  static values = {
    apiKey: String,
    markers: Array,
    trip: Object,
  };

  async connect() {
    const start = this.tripValue.start_geolocation;
    const end = this.tripValue.end_geolocation;

    console.log(start);

    // Filter out start and end points
    const waypoints = this.markersValue.filter(
      (marker) => !marker.is_start_end
    );

    console.log(waypoints);

    // Extract coordinates from waypoints
    const waypointCoordinates = waypoints
      .map((marker) => `${marker.lng},${marker.lat}`)
      .join(";");

    //    console.log(waypointCoordinates);

    const coordinates = `${start.lon},${start.lat};${waypointCoordinates};${end.lon},${end.lat}`;

    mapboxgl.accessToken = this.apiKeyValue;

    const query = await fetch(
      `https://api.mapbox.com/directions/v5/mapbox/driving/${coordinates}?steps=true&geometries=geojson&overview=full&access_token=${mapboxgl.accessToken}`,
      { method: "GET" }
    );

    const json = await query.json();
    console.log(json);

    const data = json.routes[0];

    console.log(data);

    const route = data.geometry.coordinates;

    this.map = new mapboxgl.Map({
      container: this.element,
      style: "mapbox://styles/mapbox/navigation-day-v1",
    });

    this.map.on("load", () => {
      this.map.addSource("route", {
        type: "geojson",
        data: {
          type: "Feature",
          properties: {},
          geometry: {
            type: "LineString",
            coordinates: route,
          },
        },
      });

      const currentPath = window.location.pathname;

      // Define a regex pattern to match /trips/ followed by one or more digits
      const tripsPattern = /\/trips\/\d+/;

      // Define a regex pattern to match /trips/ followed by one or more digits and /edit
      const editPattern = /\/trips\/\d+\/edit/;

      if (tripsPattern.test(currentPath) && !editPattern.test(currentPath)) {
        this.map.addLayer({
          id: "route",
          type: "line",
          source: "route",
          layout: {
            "line-join": "round",
            "line-cap": "round",
          },
          paint: {
            "line-color": "#dc3545",
            "line-width": 8,
          },
        });
      }
    });

    this.#addMarkersToMap();
    this.#fitMapToMarkers();

    const instructions = document.getElementById("instructions");
    const steps = data.legs[0].steps;
    let tripInstructions = "";
    for (const step of steps) {
      tripInstructions += `<li>${step.maneuver.instruction}</li>`;
    }
    instructions.innerHTML = `<p><strong>Trip duration: ${Math.floor(
      data.duration / 60
    )} min  </strong></p><ol>${tripInstructions}</ol>`;
  }

  #fitMapToMarkers() {
    const bounds = new mapboxgl.LngLatBounds();
    this.markersValue.forEach((marker) =>
      bounds.extend([marker.lng, marker.lat])
    );
    this.map.fitBounds(bounds, { padding: 70, maxZoom: 35, duration: 0 });
  }

  #addMarkersToMap() {
    this.markersValue.forEach((marker) => {
      const popup = new mapboxgl.Popup().setHTML(marker.info_window);
      const customMarker = document.createElement("div");
      if (marker.is_start_end === true) {
        customMarker.className = "marker";
        customMarker.style.backgroundImage = `url('${marker.image_url}')`;
        customMarker.style.backgroundSize = "cover";
        customMarker.style.backgroundRepeat = "no-repeat";
        customMarker.style.width = "27px";
        customMarker.style.height = "41px";
        customMarker.classList.add("start_end_marker");
        new mapboxgl.Marker(customMarker)
          .setLngLat([marker.lng, marker.lat])
          .addTo(this.map);
      } else if (marker.stop_is_in_trip) {
        console.log("stop");
        customMarker.className = "marker";
        customMarker.style.backgroundImage = `url('${marker.image_url}')`;
        customMarker.style.backgroundSize = "cover";
        customMarker.style.backgroundRepeat = "no-repeat";
        customMarker.style.width = "27px";
        customMarker.style.height = "41px";
        customMarker.classList.add("start_end_marker");
        new mapboxgl.Marker(customMarker)
          .setLngLat([marker.lng, marker.lat])
          .setPopup(popup)
          .addTo(this.map);
      } else {
        customMarker.className = "marker";
        new mapboxgl.Marker()
          .setLngLat([marker.lng, marker.lat])
          .setPopup(popup)
          .addTo(this.map);
      }
    });
  }
  closePopup() {
    this.map.closePopup();
  }
}
