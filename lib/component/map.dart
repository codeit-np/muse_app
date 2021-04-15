import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong/latlong.dart';

Widget mapWidget() {
  return FlutterMap(
    options: MapOptions(
      center: LatLng(26.663171, 87.637187),
      zoom: 16.0,
    ),
    layers: [
      TileLayerOptions(
          urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
          subdomains: ['a', 'b', 'c']),
      MarkerLayerOptions(
        markers: [
          Marker(
            width: 80.0,
            height: 80.0,
            point: LatLng(26.663171, 87.637187),
            builder: (ctx) => Container(
              child: Icon(
                Icons.place,
                size: 40,
                color: Colors.red,
              ),
            ),
          ),
        ],
      ),
    ],
  );
}
