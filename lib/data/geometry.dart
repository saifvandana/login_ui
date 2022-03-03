import 'package:login_ui/data/location.dart';

import 'viewport.dart';

class Geometry {
  final Location location;
  final ViewPort viewPort;
  Geometry({required this.location, required this.viewPort});

  factory Geometry.fromJson(Map<String, dynamic> json) {
    return Geometry(location: json['location'], viewPort: json['viewport']);
  }
}
