import 'dart:collection';
import 'dart:convert' as convert;

import 'package:awesome_dialog/awesome_dialog.dart';

import 'package:flutter/material.dart';
import 'package:flutter_google_places/flutter_google_places.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_api_headers/google_api_headers.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:http/http.dart';
import 'package:travelapp/modules/map/placesdetails.dart';

import '../../models/map_style.dart';
import '../../widgets/components.dart';
import 'destinationstosearch.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({Key? key}) : super(key: key);
  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  ///initalizations
  Map<MarkerId, Marker> markers = {};
  List<Polyline> mylines = [];
  List<Destination> destinationlist = <Destination>[];
  String googleAPiKey = "AIzaSyCN5EoUCaoW_HJR1ZaD0xvagCLRdkSvN3w";
  Set<Polygon> polygons = <Polygon>{};
  String location = "Search Location";
  final Set<Circle> _circles = <Circle>{};

  ///markers
  final Set<Marker> _markers = {};
  late Position cl;
  late bool services;
  late LocationPermission per;
  late GoogleMapController mapController;
  late String searchadder;
  var lat;
  var long;
  Position? position;
  List<Marker> list = createMarkers(destinations);
  late Position _currentPosition;
  var myMarkers = HashSet<Marker>();

  CameraPosition _kGooglePlex =
      const CameraPosition(target: LatLng(27.0, 31.0), zoom: 6.9);

  ///start classes
  @override
  void initState() {
    getper();
    getLatAndLong();
    setPolylines();
    _kGooglePlex;
    distanceCalculation();
    createMarkers(destinations);
    _markers.addAll(list);
    super.initState();
  }

  /// to show trip step by step
  int currentStep = 0;
  List<Step> stepList() => [
        Step(
            isActive: currentStep >= 0,
            subtitle: const Text('first location to start the trip'),
            title: const Text('Start 8 am'),
            content: Center(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Name : ${destinationlist.elementAt(0).name}'),
                const SizedBox(
                  height: 10,
                ),
                Text(
                    'distance between your location and the first location is ${destinationlist.elementAt(0).distanceText}'),
                const SizedBox(
                  height: 10,
                ),
                const Text('Time to spend here 30min'),
                // Text('time to travel ' +
                //     destinationlist.first.durationText.toString()),
              ],
            ))),
        Step(
            isActive: currentStep >= 1,
            title: const Text('second location'),
            content: Center(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Name : ${destinationlist.elementAt(1).name}'),
                const SizedBox(
                  height: 10,
                ),
                Text('distance between you and location is ${destinationlist.elementAt(1).distanceText}'),
                const SizedBox(
                  height: 10,
                ),
                const Text('Time to spend here 30min'),
                // Text('time to travel ' +
                //     destinationlist.first.durationText.toString()),
              ],
            ))),
        Step(
            isActive: currentStep >= 2,
            title: const Text('third location'),
            content: Center(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Name : ${destinationlist.elementAt(2).name}'),
                const SizedBox(
                  height: 10,
                ),
                Text('distance between you and location is ${destinationlist.elementAt(2).distanceText}'),
                const SizedBox(
                  height: 10,
                ),
                const Text('Time to spend here 30min'),
                // Text('time to travel ' +
                //     destinationlist.first.durationText.toString()),
              ],
            ))),
        Step(
            isActive: currentStep >= 3,
            title: const Text('fourth location'),
            content: Center(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Name : ${destinationlist.elementAt(3).name}'),
                const SizedBox(
                  height: 10,
                ),
                Text('distance between you and location is ${destinationlist.elementAt(3).distanceText}'),
                const SizedBox(
                  height: 10,
                ),
                const Text('Time to spend here 30min'),
                // Text('time to travel ' +
                //     destinationlist.first.durationText.toString()),
              ],
            ))),
        Step(
            isActive: currentStep >= 4,
            title: const Text('fifth location'),
            content: Center(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Name : ${destinationlist.elementAt(4).name}'),
                const SizedBox(
                  height: 10,
                ),
                Text('distance between you and location is ${destinationlist.elementAt(4).distanceText}'),
                const SizedBox(
                  height: 10,
                ),
                const Text('Time to spend here 30min'),
                // Text('time to travel ' +
                //     destinationlist.first.durationText.toString()),
              ],
            ))),
        Step(
            isActive: currentStep >= 5,
            title: const Text('sixth location'),
            content: Center(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Name : ${destinationlist.elementAt(5).name}'),
                const SizedBox(
                  height: 10,
                ),
                Text(
                    'distance between your location and the first location is ${destinationlist.elementAt(5).distanceText}'),
                const SizedBox(
                  height: 10,
                ),
                const Text('Time to spend here 30min'),
                // Text('time to travel ' +
                //     destinationlist.first.durationText.toString()),
              ],
            ))),
        Step(
            isActive: currentStep >= 6,
            title: const Text('seventh location'),
            content: Center(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Name : ${destinationlist.elementAt(6).name}'),
                const SizedBox(
                  height: 10,
                ),
                Text('distance between you and location is ${destinationlist.elementAt(6).distanceText}'),
                const SizedBox(
                  height: 10,
                ),
                const Text('Time to spend here 30min'),
                // Text('time to travel ' +
                //     destinationlist.first.durationText.toString()),
              ],
            ))),
        Step(
            isActive: currentStep >= 7,
            title: const Text('eighth location'),
            content: Center(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Name : ${destinationlist.elementAt(7).name}'),
                const SizedBox(
                  height: 10,
                ),
                Text('distance between you and location is ${destinationlist.elementAt(7).distanceText}'),
                const SizedBox(
                  height: 10,
                ),
                const Text('Time to spend here 30min'),
                // Text('time to travel ' +
                //     destinationlist.first.durationText.toString()),
              ],
            ))),
        Step(
            isActive: currentStep >= 8,
            title: const Text('ninth location'),
            content: Center(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Name : ${destinationlist.elementAt(8).name}'),
                const SizedBox(
                  height: 10,
                ),
                Text('distance between you and location is ${destinationlist.elementAt(8).distanceText}'),
                const SizedBox(
                  height: 10,
                ),
                const Text('Time to spend here 30min'),
                // Text('time to travel ' +
                //     destinationlist.first.durationText.toString()),
              ],
            ))),
        Step(
            isActive: currentStep >= 9,
            subtitle: const Text('last location'),
            title: const Text('ends 6 pm'),
            content: Center(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Name : ${destinationlist.elementAt(9).name}'),
                const SizedBox(
                  height: 10,
                ),
                Text('distance between you and location is ${destinationlist.elementAt(9).distanceText}'),
                const SizedBox(
                  height: 10,
                ),
                const Text('Time to spend here 30min'),
                // Text('time to travel ' +
                //     destinationlist.first.durationText.toString()),
              ],
            ))),
      ];
  final List<dynamic> _mapThemes = [
    {
      'name': 'Standard',
      'style': MapStyle().dark,
      'image':
          'https://maps.googleapis.com/maps/api/staticmap?center=-33.9775,151.036&zoom=13&format=png&maptype=roadmap&style=element:labels%7Cvisibility:off&style=feature:administrative.land_parcel%7Cvisibility:off&style=feature:administrative.neighborhood%7Cvisibility:off&size=164x132&key=AIzaSyDk4C4EBWgjuL1eBnJlu1J80WytEtSIags&scale=2'
    },
    {
      'name': 'Sliver',
      'style': MapStyle().sliver,
      'image':
          'https://maps.googleapis.com/maps/api/staticmap?center=-33.9775,151.036&zoom=13&format=png&maptype=roadmap&style=element:geometry%7Ccolor:0xf5f5f5&style=element:labels%7Cvisibility:off&style=element:labels.icon%7Cvisibility:off&style=element:labels.text.fill%7Ccolor:0x616161&style=element:labels.text.stroke%7Ccolor:0xf5f5f5&style=feature:administrative.land_parcel%7Cvisibility:off&style=feature:administrative.land_parcel%7Celement:labels.text.fill%7Ccolor:0xbdbdbd&style=feature:administrative.neighborhood%7Cvisibility:off&style=feature:poi%7Celement:geometry%7Ccolor:0xeeeeee&style=feature:poi%7Celement:labels.text.fill%7Ccolor:0x757575&style=feature:poi.park%7Celement:geometry%7Ccolor:0xe5e5e5&style=feature:poi.park%7Celement:labels.text.fill%7Ccolor:0x9e9e9e&style=feature:road%7Celement:geometry%7Ccolor:0xffffff&style=feature:road.arterial%7Celement:labels.text.fill%7Ccolor:0x757575&style=feature:road.highway%7Celement:geometry%7Ccolor:0xdadada&style=feature:road.highway%7Celement:labels.text.fill%7Ccolor:0x616161&style=feature:road.local%7Celement:labels.text.fill%7Ccolor:0x9e9e9e&style=feature:transit.line%7Celement:geometry%7Ccolor:0xe5e5e5&style=feature:transit.station%7Celement:geometry%7Ccolor:0xeeeeee&style=feature:water%7Celement:geometry%7Ccolor:0xc9c9c9&style=feature:water%7Celement:labels.text.fill%7Ccolor:0x9e9e9e&size=164x132&key=AIzaSyDk4C4EBWgjuL1eBnJlu1J80WytEtSIags&scale=2'
    },
    {
      'name': 'Retro',
      'style': MapStyle().retro,
      'image':
          'https://maps.googleapis.com/maps/api/staticmap?center=-33.9775,151.036&zoom=13&format=png&maptype=roadmap&style=element:geometry%7Ccolor:0xebe3cd&style=element:labels%7Cvisibility:off&style=element:labels.text.fill%7Ccolor:0x523735&style=element:labels.text.stroke%7Ccolor:0xf5f1e6&style=feature:administrative%7Celement:geometry.stroke%7Ccolor:0xc9b2a6&style=feature:administrative.land_parcel%7Cvisibility:off&style=feature:administrative.land_parcel%7Celement:geometry.stroke%7Ccolor:0xdcd2be&style=feature:administrative.land_parcel%7Celement:labels.text.fill%7Ccolor:0xae9e90&style=feature:administrative.neighborhood%7Cvisibility:off&style=feature:landscape.natural%7Celement:geometry%7Ccolor:0xdfd2ae&style=feature:poi%7Celement:geometry%7Ccolor:0xdfd2ae&style=feature:poi%7Celement:labels.text.fill%7Ccolor:0x93817c&style=feature:poi.park%7Celement:geometry.fill%7Ccolor:0xa5b076&style=feature:poi.park%7Celement:labels.text.fill%7Ccolor:0x447530&style=feature:road%7Celement:geometry%7Ccolor:0xf5f1e6&style=feature:road.arterial%7Celement:geometry%7Ccolor:0xfdfcf8&style=feature:road.highway%7Celement:geometry%7Ccolor:0xf8c967&style=feature:road.highway%7Celement:geometry.stroke%7Ccolor:0xe9bc62&style=feature:road.highway.controlled_access%7Celement:geometry%7Ccolor:0xe98d58&style=feature:road.highway.controlled_access%7Celement:geometry.stroke%7Ccolor:0xdb8555&style=feature:road.local%7Celement:labels.text.fill%7Ccolor:0x806b63&style=feature:transit.line%7Celement:geometry%7Ccolor:0xdfd2ae&style=feature:transit.line%7Celement:labels.text.fill%7Ccolor:0x8f7d77&style=feature:transit.line%7Celement:labels.text.stroke%7Ccolor:0xebe3cd&style=feature:transit.station%7Celement:geometry%7Ccolor:0xdfd2ae&style=feature:water%7Celement:geometry.fill%7Ccolor:0xb9d3c2&style=feature:water%7Celement:labels.text.fill%7Ccolor:0x92998d&size=164x132&key=AIzaSyDk4C4EBWgjuL1eBnJlu1J80WytEtSIags&scale=2'
    },
    {
      'name': 'Dark',
      'style': MapStyle().dark,
      'image':
          'https://maps.googleapis.com/maps/api/staticmap?center=-33.9775,151.036&zoom=13&format=png&maptype=roadmap&style=element:geometry%7Ccolor:0x212121&style=element:labels%7Cvisibility:off&style=element:labels.icon%7Cvisibility:off&style=element:labels.text.fill%7Ccolor:0x757575&style=element:labels.text.stroke%7Ccolor:0x212121&style=feature:administrative%7Celement:geometry%7Ccolor:0x757575&style=feature:administrative.country%7Celement:labels.text.fill%7Ccolor:0x9e9e9e&style=feature:administrative.land_parcel%7Cvisibility:off&style=feature:administrative.locality%7Celement:labels.text.fill%7Ccolor:0xbdbdbd&style=feature:administrative.neighborhood%7Cvisibility:off&style=feature:poi%7Celement:labels.text.fill%7Ccolor:0x757575&style=feature:poi.park%7Celement:geometry%7Ccolor:0x181818&style=feature:poi.park%7Celement:labels.text.fill%7Ccolor:0x616161&style=feature:poi.park%7Celement:labels.text.stroke%7Ccolor:0x1b1b1b&style=feature:road%7Celement:geometry.fill%7Ccolor:0x2c2c2c&style=feature:road%7Celement:labels.text.fill%7Ccolor:0x8a8a8a&style=feature:road.arterial%7Celement:geometry%7Ccolor:0x373737&style=feature:road.highway%7Celement:geometry%7Ccolor:0x3c3c3c&style=feature:road.highway.controlled_access%7Celement:geometry%7Ccolor:0x4e4e4e&style=feature:road.local%7Celement:labels.text.fill%7Ccolor:0x616161&style=feature:transit%7Celement:labels.text.fill%7Ccolor:0x757575&style=feature:water%7Celement:geometry%7Ccolor:0x000000&style=feature:water%7Celement:labels.text.fill%7Ccolor:0x3d3d3d&size=164x132&key=AIzaSyDk4C4EBWgjuL1eBnJlu1J80WytEtSIags&scale=2'
    },
    {
      'name': 'Night',
      'style': MapStyle().night,
      'image':
          'https://maps.googleapis.com/maps/api/staticmap?center=-33.9775,151.036&zoom=13&format=png&maptype=roadmap&style=element:geometry%7Ccolor:0x242f3e&style=element:labels%7Cvisibility:off&style=element:labels.text.fill%7Ccolor:0x746855&style=element:labels.text.stroke%7Ccolor:0x242f3e&style=feature:administrative.land_parcel%7Cvisibility:off&style=feature:administrative.locality%7Celement:labels.text.fill%7Ccolor:0xd59563&style=feature:administrative.neighborhood%7Cvisibility:off&style=feature:poi%7Celement:labels.text.fill%7Ccolor:0xd59563&style=feature:poi.park%7Celement:geometry%7Ccolor:0x263c3f&style=feature:poi.park%7Celement:labels.text.fill%7Ccolor:0x6b9a76&style=feature:road%7Celement:geometry%7Ccolor:0x38414e&style=feature:road%7Celement:geometry.stroke%7Ccolor:0x212a37&style=feature:road%7Celement:labels.text.fill%7Ccolor:0x9ca5b3&style=feature:road.highway%7Celement:geometry%7Ccolor:0x746855&style=feature:road.highway%7Celement:geometry.stroke%7Ccolor:0x1f2835&style=feature:road.highway%7Celement:labels.text.fill%7Ccolor:0xf3d19c&style=feature:transit%7Celement:geometry%7Ccolor:0x2f3948&style=feature:transit.station%7Celement:labels.text.fill%7Ccolor:0xd59563&style=feature:water%7Celement:geometry%7Ccolor:0x17263c&style=feature:water%7Celement:labels.text.fill%7Ccolor:0x515c6d&style=feature:water%7Celement:labels.text.stroke%7Ccolor:0x17263c&size=164x132&key=AIzaSyDk4C4EBWgjuL1eBnJlu1J80WytEtSIags&scale=2'
    },
    {
      'name': 'Aubergine',
      'style': MapStyle().aubergine,
      'image':
          'https://maps.googleapis.com/maps/api/staticmap?center=-33.9775,151.036&zoom=13&format=png&maptype=roadmap&style=element:geometry%7Ccolor:0x1d2c4d&style=element:labels%7Cvisibility:off&style=element:labels.text.fill%7Ccolor:0x8ec3b9&style=element:labels.text.stroke%7Ccolor:0x1a3646&style=feature:administrative.country%7Celement:geometry.stroke%7Ccolor:0x4b6878&style=feature:administrative.land_parcel%7Cvisibility:off&style=feature:administrative.land_parcel%7Celement:labels.text.fill%7Ccolor:0x64779e&style=feature:administrative.neighborhood%7Cvisibility:off&style=feature:administrative.province%7Celement:geometry.stroke%7Ccolor:0x4b6878&style=feature:landscape.man_made%7Celement:geometry.stroke%7Ccolor:0x334e87&style=feature:landscape.natural%7Celement:geometry%7Ccolor:0x023e58&style=feature:poi%7Celement:geometry%7Ccolor:0x283d6a&style=feature:poi%7Celement:labels.text.fill%7Ccolor:0x6f9ba5&style=feature:poi%7Celement:labels.text.stroke%7Ccolor:0x1d2c4d&style=feature:poi.park%7Celement:geometry.fill%7Ccolor:0x023e58&style=feature:poi.park%7Celement:labels.text.fill%7Ccolor:0x3C7680&style=feature:road%7Celement:geometry%7Ccolor:0x304a7d&style=feature:road%7Celement:labels.text.fill%7Ccolor:0x98a5be&style=feature:road%7Celement:labels.text.stroke%7Ccolor:0x1d2c4d&style=feature:road.highway%7Celement:geometry%7Ccolor:0x2c6675&style=feature:road.highway%7Celement:geometry.stroke%7Ccolor:0x255763&style=feature:road.highway%7Celement:labels.text.fill%7Ccolor:0xb0d5ce&style=feature:road.highway%7Celement:labels.text.stroke%7Ccolor:0x023e58&style=feature:transit%7Celement:labels.text.fill%7Ccolor:0x98a5be&style=feature:transit%7Celement:labels.text.stroke%7Ccolor:0x1d2c4d&style=feature:transit.line%7Celement:geometry.fill%7Ccolor:0x283d6a&style=feature:transit.station%7Celement:geometry%7Ccolor:0x3a4762&style=feature:water%7Celement:geometry%7Ccolor:0x0e1626&style=feature:water%7Celement:labels.text.fill%7Ccolor:0x4e6d70&size=164x132&key=AIzaSyDk4C4EBWgjuL1eBnJlu1J80WytEtSIags&scale=2'
    }
  ];

  ///polyline method
  final Set<Polyline> _polylines = <Polyline>{};
  List<LatLng> polycoords = [];
  PolylinePoints? polypoints;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
        children: <Widget>[
          /// Map
          GoogleMap(
            polylines: _polylines,
            compassEnabled: false,
            markers: Set<Marker>.of(list),
            zoomControlsEnabled: false,
            initialCameraPosition: _kGooglePlex,
            onMapCreated: (GoogleMapController controller) {
              mapController = controller;
              mapController.animateCamera(
                CameraUpdate.newCameraPosition(
                  CameraPosition(
                    target: LatLng(
                      cl.latitude,
                      cl.longitude,
                    ),
                    zoom: 14.0,
                  ),
                ),
              );
              setPolylines();
              setState(() {
                createMarkers(destinations);
              });
            },
          ),

          ///search locations
          Positioned(
            top: 80,
            right: 20,
            left: 20,
            child: InkWell(
                onTap: () async {
                  var place = await PlacesAutocomplete.show(
                      context: context,
                      apiKey: 'AIzaSyDxt0hqGVcHzQsgMZaZbLgNIXjgnTxrh4I',
                      mode: Mode.overlay,
                      types: [],
                      strictbounds: false,
                      components: [Component(Component.country, 'eg')],
                      //google_map_webservice package
                      onError: (err) {
                        print(err);
                      });

                  if (place != null) {
                    setState(() {
                      location = place.description.toString();
                    });

                    //form google_maps_webservice package
                    final plist = GoogleMapsPlaces(
                      apiKey: 'AIzaSyDxt0hqGVcHzQsgMZaZbLgNIXjgnTxrh4I',
                      apiHeaders: await const GoogleApiHeaders().getHeaders(),
                      //from google_api_headers package
                    );
                    String placeid = place.placeId ?? "0";
                    final detail = await plist.getDetailsByPlaceId(placeid);
                    final geometry = detail.result.geometry!;
                    final lat = geometry.location.lat;
                    final lang = geometry.location.lng;
                    var newlatlang = LatLng(lat, lang);

                    //move map camera to selected place with animation
                    mapController.animateCamera(CameraUpdate.newCameraPosition(
                        CameraPosition(target: newlatlang, zoom: 17)));
                  }
                },
                child: Padding(
                  padding: const EdgeInsets.all(15),
                  child: Card(
                    child: Container(
                        padding: const EdgeInsets.all(0),
                        width: MediaQuery.of(context).size.width - 40,
                        child: ListTile(
                          title: Text(
                            location,
                            style: const TextStyle(fontSize: 18),
                          ),
                          trailing: const Icon(Icons.search),
                          dense: true,
                        )),
                  ),
                )),
          ),

          ///map themes
          Positioned(
            bottom: 35,
            left: 15,
            child: Container(
                width: 35,
                height: 50,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    MaterialButton(
                      onPressed: () {
                        showModalBottomSheet(
                          context: context,
                          builder: (context) => Container(
                              padding: const EdgeInsets.all(20),
                              color: Colors.white,
                              height: MediaQuery.of(context).size.height * 0.3,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    "Select Theme",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.w600,
                                        fontSize: 18),
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  SizedBox(
                                    width: double.infinity,
                                    height: 100,
                                    child: ListView.builder(
                                        scrollDirection: Axis.horizontal,
                                        itemCount: _mapThemes.length,
                                        itemBuilder: (context, index) {
                                          return GestureDetector(
                                            onTap: () {
                                              mapController.setMapStyle(
                                                  _mapThemes[index]['style']);
                                              Navigator.pop(context);
                                            },
                                            child: Container(
                                              width: 100,
                                              margin:
                                                  const EdgeInsets.only(right: 10),
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  image: DecorationImage(
                                                    fit: BoxFit.cover,
                                                    image: NetworkImage(
                                                        _mapThemes[index]
                                                            ['image']),
                                                  )),
                                            ),
                                          );
                                        }),
                                  ),
                                ],
                              )),
                        );
                      },
                      padding: const EdgeInsets.all(0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Icon(Icons.layers_rounded, size: 25),
                    ),
                  ],
                )),
          ),

          ///destinations list details
          Positioned(
            bottom: 30,
            right: 100,
            left: 100,
            child: SizedBox(
              height: 60,
              width: 150,
              child: MaterialButton(
                onPressed: () {
                  showModalBottomSheet(
                    anchorPoint: const Offset(0, 0),
                    enableDrag: true,
                    elevation: 10,
                    context: context,
                    isScrollControlled: true,
                    builder: (context) {
                      return StatefulBuilder(
                        builder: (BuildContext context, StateSetter setState) {
                          return Column(children: [
                            Expanded(
                              flex: 10,
                              child: SingleChildScrollView(
                                child: Theme(
                                  data: Theme.of(context).copyWith(
                                    colorScheme: ColorScheme.fromSwatch()
                                        .copyWith(
                                            secondary: ButtonAndIconsColor()),
                                  ),
                                  child: Stepper(
                                    onStepTapped: (index) {
                                      setState(() {
                                        currentStep = index;
                                      });
                                    },
                                    currentStep: currentStep,
                                    onStepContinue: () {
                                      if (currentStep != 2) {
                                        setState(() {
                                          currentStep++;
                                        });
                                      }
                                    },
                                    onStepCancel: () {
                                      if (currentStep != 0) {
                                        setState(() {
                                          currentStep--;
                                        });
                                      }
                                    },
                                    physics: const ClampingScrollPhysics(),
                                    steps: stepList(),
                                    type: StepperType.vertical,
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              height: 50,
                              width: double.infinity,
                              color: ButtonAndIconsColor(),
                              child: MaterialButton(
                                onPressed: () {
                                  navigateto(
                                      context,
                                      PlacesDetails(
                                          destinationlist: destinationlist));
                                },
                                child: const Text(
                                  'See Details',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            )
                          ]);
                        },
                      );
                    },
                  );
                },
                height: 40,
                color: ButtonAndIconsColor(),
                child: const FittedBox(
                  child: Text(
                    'GO',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  ///set polyline
  void setPolylines() async {
    PolylineResult result = await polypoints!.getRouteBetweenCoordinates(
      googleAPiKey,
      PointLatLng(cl.latitude, cl.longitude),
      PointLatLng(
          destinationlist.elementAt(0).lat, destinationlist.elementAt(0).lng),
    );
    if (result.status == "ok") {
      for (var point in result.points) {
        polycoords.add(LatLng(destinationlist.elementAt(1).lat,
            destinationlist.elementAt(1).lng));
      }
    }
    setState(() {
      _polylines.add(Polyline(
          width: 10,
          polylineId: const PolylineId('polyline'),
          color: ButtonAndIconsColor(),
          points: polycoords));
    });
  }

  ///permissions
  Future getper() async {
    services = await Geolocator.isLocationServiceEnabled();
    if (services == false) {
      await Geolocator.requestPermission(); //오류 해결 코드
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      print(position);
      AwesomeDialog(
        context: context,
        dialogType: DialogType.INFO,
        animType: AnimType.BOTTOMSLIDE,
        title: 'note!',
        desc: 'Tap on Go to start your tour',
        // btnOkOnPress: () {
        //   Navigator.pop(context);
        // },
      ).show();
    }
  }

  void getLocation() async {
    LocationPermission permission =
        await Geolocator.requestPermission(); //오류 해결 코드
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    print(position);
  }

  distanceCalculation() async {
    await getLatAndLong();
    String distanceURL =
        'https://maps.googleapis.com/maps/api/distancematrix/json?destinations=';
    for (var d in destinations) {
      distanceURL = '$distanceURL${d.lat}%2C${d.lng}%7C';
    }
    distanceURL = '$distanceURL&origins=${cl.latitude}%2C${cl.longitude}&key=AIzaSyDxt0hqGVcHzQsgMZaZbLgNIXjgnTxrh4I';
    print(distanceURL);
    var distance = [];
    var duration = [];
    final response = await get(Uri.parse(distanceURL));
    print(distanceURL);
    if (response.statusCode == 200) {
      var jsonResponse =
          convert.jsonDecode(response.body) as Map<String, dynamic>;

      for (var i = 0; i < jsonResponse['rows'][0]['elements'].length; i++) {
        distance.add({
          'distanceValue': jsonResponse['rows'][0]['elements'][i]['distance']
              ['value'],
          'distanceText': jsonResponse['rows'][0]['elements'][i]['distance']
              ['text'],
        });
        duration.add({
          'durationValue': jsonResponse['rows'][0]['elements'][i]['duration']
              ['value'],
          'durationText': jsonResponse['rows'][0]['elements'][i]['duration']
              ['text'],
        });
      }
      for (var d in destinations) {
        d.distance = distance[d.id]['distanceValue'];
        d.distanceText = distance[d.id]['distanceText'];
        // d.duration = duration[d.id]['durationValue'];
        // d.durationText = duration[d.id]['durationText'];
        destinationlist.add(d);
      }

      setState(() {
        destinationlist.sort((a, b) {
          return a.distance!.compareTo(b.distance!);
        });
      });
    }
  }

  Future<void> getLatAndLong(/*{LatLng? latlong}*/) async {
    cl = await Geolocator.getCurrentPosition().then((value) => value);
    lat = cl.latitude;
    long = cl.longitude;
    _kGooglePlex = CameraPosition(
      target: LatLng(lat, long),
    );
  }

  searchandNavigate() {
    locationFromAddress(searchadder).then((result) {
      mapController.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
        target: LatLng(result[0].latitude, result[0].longitude),
        zoom: 10.0,
      )));
    });
  }
}
