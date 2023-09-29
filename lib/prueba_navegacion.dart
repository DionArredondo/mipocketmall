/*import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class NavigationMap extends StatefulWidget {
  @override
  State<NavigationMap> createState() => _NavigationMapState();
}

class _NavigationMapState extends State<NavigationMap> with TickerProviderStateMixin {
  late GoogleMapController mapController;
  late Polyline polyline;
  late AnimationController controller; 

  @override
  void initState() {
    super.initState();

    // Aqui se modifica la polilinea, tomar en cuenta LatLng
    polyline = Polyline(
      polylineId: PolylineId("my_polyline"), // Especificamos un identificador único para la polilínea
      points: [
        // Latitud, longitud
        LatLng(38.428383, -0.423182),
        LatLng(38.430384, -0.424183),
        LatLng(38.432385, -0.425184),
      ],
      color: Colors.blue,
      width: 5,
    );

    _startAnimation();
  }

  void _startAnimation() {
    // Aqui es donde se modifica lo de la animacion de la polilinea "ruta"
    controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 5), 
    );

    var animation = Tween(
      begin: 0.0,
      end: 1.0,
    ).animate(controller);

    animation.addListener(() {
      // Aqui es donde se actualiza la posicion de la polilinea
      List<LatLng> points = [];
      for (var i = 0; i < polyline.points.length; i++) {
        double fraction = animation.value;
        double lat = (polyline.points[i].latitude - polyline.points[i].latitude) * fraction + polyline.points[i].latitude;
        double lng = (polyline.points[i].longitude - polyline.points[i].longitude) * fraction + polyline.points[i].longitude;
        points.add(LatLng(lat, lng));
      }
      setState(() {
        polyline = polyline.copyWith(pointsParam: points);
      });
    });

    controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Mapa"),
      ),
      body: GoogleMap(
        mapType: MapType.normal,
        zoomControlsEnabled: false,
        initialCameraPosition: CameraPosition(
          //Aqui se pone de donde quiere empezar, al tiro con esto
          target: LatLng(38.428383, -0.423182), 
          zoom: 15.0, // Zoom inicial
        ),
        onMapCreated: (controller) {
          mapController = controller;
        },
        polylines: {polyline},
      ),
    );
  }
}*/

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

// ignore: constant_identifier_names
const MAPBOX_ACCESS_TOKEN =
    'pk.eyJ1IjoicGl0bWFjIiwiYSI6ImNsY3BpeWxuczJhOTEzbnBlaW5vcnNwNzMifQ.ncTzM4bW-jpq-hUFutnR1g';

final myPosition = LatLng(40.697488, -73.979681);

class NavigationMap extends StatelessWidget {
  const NavigationMap({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Mapa'),
        backgroundColor: Colors.blueAccent,
      ),
      body: FlutterMap(
        options:
            MapOptions(center: myPosition, minZoom: 5, maxZoom: 25, zoom: 18),
        nonRotatedChildren: [
          TileLayer(
            urlTemplate:
                'https://api.mapbox.com/styles/v1/{id}/tiles/{z}/{x}/{y}?access_token={accessToken}',
            additionalOptions: const {
              'accessToken': MAPBOX_ACCESS_TOKEN,
              'id': 'mapbox/streets-v12'
            },
          ),
          MarkerLayer(
            markers: [
              Marker(
                point: myPosition,
                builder: (context) {
                  return Container(
                    child: const Icon(
                      Icons.person_pin,
                      color: Colors.blueAccent,
                      size: 40,
                    ),
                  );
                },
              )
            ],
          )
        ],
      ),
    );
  }
}