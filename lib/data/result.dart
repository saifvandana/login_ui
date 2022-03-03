import 'package:login_ui/data/geometry.dart';
import 'package:login_ui/data/photo.dart';

class Result {
  final Geometry geometry;
  final String icon;
  final String id;
  final String name;
  final List<Photo> photos;
  final String placeId;
  final double rating;
  final String reference;
  final String scope;
  final List<String> types;
  final int userRatingsTotal;
  final String vicinity;

  Result(
      {required this.geometry,
      required this.icon,
      required this.id,
      required this.name,
      required this.photos,
      required this.placeId,
      required this.rating,
      required this.reference,
      required this.scope,
      required this.types,
      required this.userRatingsTotal,
      required this.vicinity});

  factory Result.fromJson(Map<String, dynamic> json) {
    return Result(
      geometry: json['geometry'],
      icon: json['icon'],
      id: json['id'],
      name: json['name'],
      photos: json['photos'],
      placeId: json['placeId'],
      rating: json['rating'],
      reference: json['reference'],
      scope: json['scope'],
      types: json['types'],
      userRatingsTotal: json['user_ratings_total'],
      vicinity: json['vicinity'],
    );
  }
}
