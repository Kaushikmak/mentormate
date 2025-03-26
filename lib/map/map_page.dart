import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapPage extends StatefulWidget {
  const MapPage({super.key});

  @override
  State<MapPage> createState() => _MapPageState();
}

class LocationInfo {
  final LatLng position;
  final String description;

  LocationInfo(this.position, this.description);
}

class _MapPageState extends State<MapPage> {
  static const LatLng _initialPosition = LatLng(21.125, 79.0525);
  late GoogleMapController _mapController;

  // Enhanced data structure with descriptions
  final Map<String, LocationInfo> _locations = {
    "EEE Department": LocationInfo(
      LatLng(21.122595555632284, 79.05243270159112),
      "Electrical and Electronics Engineering Department",
    ),
    "Library": LocationInfo(
      LatLng(21.123456, 79.054321),
      "Central library with study areas and extensive collection of books",
    ),
    "CSE Department": LocationInfo(
      LatLng(21.124567, 79.053210),
      "Computer Science Engineering Department",
    ),
    "Hostel Block": LocationInfo(
      LatLng(21.125678, 79.052111),
      "Student accommodation",
    ),
    "Auditorium": LocationInfo(
      LatLng(21.126789, 79.051000),
      "Main auditorium for events and ceremonies",
    ),
    "Sports Complex": LocationInfo(
      LatLng(21.127890, 79.050123),
      "Sports facilities including indoor and outdoor courts",
    ),
  };

  // Markers list
  final Set<Marker> _markers = {};
  final TextEditingController _searchController = TextEditingController();
  List<String> _filteredLocations = [];
  bool _showSuggestions = false;

  @override
  void initState() {
    super.initState();
    _addMarkers();
  }

  void _addMarkers() {
    _locations.forEach((name, locationInfo) {
      _markers.add(
        Marker(
          markerId: MarkerId(name),
          position: locationInfo.position,
          infoWindow: InfoWindow(
            title: name,
            snippet: locationInfo.description,
          ),
        ),
      );
    });
  }

  void _navigateToLocation(String locationName) {
    if (_locations.containsKey(locationName)) {
      final LatLng target = _locations[locationName]!.position;
      _mapController.animateCamera(CameraUpdate.newLatLngZoom(target, 20));
      _searchController.text = locationName;
      setState(() {
        _showSuggestions = false;
      });
      _markers.forEach((marker) {
        if (marker.markerId.value == locationName) {
          _mapController.showMarkerInfoWindow(marker.markerId);
        }
      });
    }
  }

  void _filterLocations(String query) {
    if (query.isEmpty) {
      setState(() {
        _filteredLocations = [];
        _showSuggestions = false;
      });
      return;
    }

    setState(() {
      _filteredLocations = _locations.keys
          .where((location) => location.toLowerCase().contains(query.toLowerCase()))
          .toList();
      _showSuggestions = _filteredLocations.isNotEmpty;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          GoogleMap(
            initialCameraPosition: CameraPosition(
              target: _initialPosition,
              zoom: 17,
            ),
            markers: _markers,
            mapType: MapType.normal,
            onMapCreated: (controller) => _mapController = controller,
            onTap: (_) {
              setState(() {
                _showSuggestions = false;
              });
              FocusScope.of(context).unfocus();
            },
          ),
          Positioned(
            top: MediaQuery.of(context).padding.top + 10,
            left: 10,
            right: 10,
            child: Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black26,
                        blurRadius: 5,
                        offset: Offset(0, 2),
                      ),
                    ],
                  ),
                  child: TextField(
                    controller: _searchController,
                    decoration: InputDecoration(
                      hintText: "Search for a location...",
                      prefixIcon: Icon(Icons.search),
                      border: InputBorder.none,
                      contentPadding:
                      EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                      suffixIcon: _searchController.text.isNotEmpty
                          ? IconButton(
                        icon: Icon(Icons.clear),
                        onPressed: () {
                          _searchController.clear();
                          setState(() {
                            _filteredLocations = [];
                            _showSuggestions = false;
                          });
                        },
                      )
                          : null,
                    ),
                    onChanged: _filterLocations,
                    onSubmitted: (value) {
                      if (_filteredLocations.isNotEmpty) {
                        _navigateToLocation(_filteredLocations.first);
                      }
                    },
                  ),
                ),
                if (_showSuggestions)
                  Container(
                    margin: EdgeInsets.only(top: 5),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black26,
                          blurRadius: 5,
                          offset: Offset(0, 2),
                        ),
                      ],
                    ),
                    constraints: BoxConstraints(
                      maxHeight: 200,
                    ),
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: _filteredLocations.length,
                      itemBuilder: (context, index) {
                        final locationName = _filteredLocations[index];
                        return ListTile(
                          title: Text(locationName),
                          subtitle: Text(
                            _locations[locationName]!.description,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          onTap: () {
                            _navigateToLocation(locationName);
                          },
                        );
                      },
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }
}
