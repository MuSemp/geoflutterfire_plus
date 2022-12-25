import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

import 'math.dart';

/// An entity saved in Cloud Firestore as geopoint field.
class GeoFirePoint {
  GeoFirePoint(this.latitude, this.longitude);

  /// Latitude of the location.
  double latitude;

  /// Longitude of the location.
  double longitude;

  /// Returns geohash of [GeoFirePoint].
  String get geohash => encode(latitude: latitude, longitude: longitude);

  /// Returns all neighbors of [GeoFirePoint].
  List<String> get neighbors => neighborsOfGeohash(geohash);

  /// Returns [GeoPoint] of [GeoFirePoint].
  GeoPoint get geopoint => GeoPoint(latitude, longitude);

  /// Returns [Coordinates]  of [GeoFirePoint].
  Coordinates get coordinates => Coordinates(latitude, longitude);

  /// Returns distance in kilometers between [GeoFirePoint] and given
  /// ([latitude], [longitude]).
  double distanceBetweenInKm({
    required double latitude,
    required double longitude,
  }) =>
      distanceInKm(
        from: coordinates,
        to: Coordinates(latitude, longitude),
      );

  /// Returns [geopoint] and [geohash] as Map<String, dynamic>. Can be used when
  /// adding or updating to Firestore document.
  Map<String, dynamic> get data => {'geopoint': geopoint, 'geohash': geohash};
}

/// Describes coordinates (location) by ([latitude], [longitude]).
class Coordinates extends Equatable {
  const Coordinates(this.latitude, this.longitude);

  /// Latitude of the location.
  final double latitude;

  /// Longitude of the location.
  final double longitude;

  @override
  List<Object> get props => [latitude, longitude];
}
