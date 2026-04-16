import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:khmerbike/models/station.dart';
import 'package:khmerbike/ui/screens/map_station/widgets/station_modal.dart';
import 'package:khmerbike/ui/screens/station/station_detail.dart';
import 'package:khmerbike/ui/theme/app_theme.dart';

class CustomMap extends StatefulWidget {
  final List<Station> stations;
  final LatLng initialPosition;
  final Function(GoogleMapController) onMapCreated;

  const CustomMap({
    super.key,
    required this.stations,
    required this.initialPosition,
    required this.onMapCreated,
  });

  @override
  State<CustomMap> createState() => _CustomMapState();
}

class _CustomMapState extends State<CustomMap> {
  BitmapDescriptor _customMarker = BitmapDescriptor.defaultMarker;
  final Map<String, BitmapDescriptor> _stationIcons = {};
  bool _iconsCreated = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_iconsCreated) {
      _createAllStationIcons();
      _iconsCreated = true;
    }
  }

  @override
  void didUpdateWidget(covariant CustomMap oldWidget) {
    super.didUpdateWidget(oldWidget);
    final oldCounts = {
      for (var s in oldWidget.stations)
        s.id: s.docks.where((d) => d.bike != null).length,
    };
    final newCounts = {
      for (var s in widget.stations)
        s.id: s.docks.where((d) => d.bike != null).length,
    };
    if (!_mapEquals(oldCounts, newCounts)) {
      _stationIcons.clear();
      _iconsCreated = false;
      WidgetsBinding.instance.addPostFrameCallback(
        (_) => _createAllStationIcons(),
      );
    }
  }

  bool _mapEquals(Map a, Map b) {
    if (a.length != b.length) return false;
    for (final k in a.keys) {
      if (!b.containsKey(k) || b[k] != a[k]) return false;
    }
    return true;
  }

  Future<void> _createAllStationIcons() async {
    try {
      final double dpr = MediaQuery.of(context).devicePixelRatio;
      final int size = (40 * dpr).round();

      final data = await rootBundle.load('assets/images/marker1.png');
      final Uint8List imgBytes = data.buffer.asUint8List();

      for (final station in widget.stations) {
        final bikeCount = station.docks.where((d) => d.bike != null).length;
        final BitmapDescriptor icon = await _createMarkerFromAsset(
          imgBytes,
          size,
          bikeCount,
        );
        _stationIcons[station.id] = icon;
      }
      setState(() {});
    } catch (e, st) {
      debugPrint('Failed creating station icons: $e');
      debugPrint('$st');
    }
  }

  Future<BitmapDescriptor> _createMarkerFromAsset(
    Uint8List assetBytes,
    int size,
    int count,
  ) async {
    final codec = await ui.instantiateImageCodec(
      assetBytes,
      targetWidth: size * 0.5.round(),
      targetHeight: (size * 4).round(),
    );
    final frame = await codec.getNextFrame();
    final ui.Image bgImage = frame.image;

    final recorder = ui.PictureRecorder();
    final canvas = Canvas(
      recorder,
      Rect.fromLTWH(0, 0, size.toDouble(), size.toDouble()),
    );

    final src = Rect.fromLTWH(
      0,
      0,
      bgImage.width.toDouble(),
      bgImage.height.toDouble(),
    );
    final dst = Rect.fromLTWH(0, 0, size.toDouble(), size.toDouble());
    final paint = Paint();
    canvas.drawImageRect(bgImage, src, dst, paint);

    // draw inner white circle to ensure number readability
    final center = Offset(size / 2, size / 2.6);
    final innerRadius = size * 0.25;
    final innerPaint = Paint()..color = AppTheme.background;
    canvas.drawCircle(center, innerRadius, innerPaint);

    // draw count text
    final textPainter = TextPainter(textDirection: TextDirection.ltr);
    final textStyle = TextStyle(
      color: AppTheme.accent,
      fontSize: innerRadius, // large but fits inside
      fontWeight: FontWeight.bold,
      shadows: [
        Shadow(blurRadius: 2, color: Colors.black26, offset: Offset(0, 1)),
      ],
    );
    textPainter.text = TextSpan(text: '$count', style: textStyle);
    textPainter.layout();
    final offset = Offset(
      center.dx - textPainter.width / 2,
      center.dy - textPainter.height / 2,
    );
    textPainter.paint(canvas, offset);

    final picture = recorder.endRecording();
    final img = await picture.toImage(size, size);
    final byteData = await img.toByteData(format: ui.ImageByteFormat.png);
    final bytes = byteData!.buffer.asUint8List();
    return BitmapDescriptor.fromBytes(bytes);
  }

  void showStationModal(BuildContext context, Station station) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => StationModal(station: station),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GoogleMap(
      initialCameraPosition: CameraPosition(
        target: widget.initialPosition,
        zoom: 13,
      ),
      markers: Set<Marker>.from(
        widget.stations.map(
          (station) => Marker(
            markerId: MarkerId(station.id.toString()),
            position: LatLng(
              station.location.latitude,
              station.location.longitude,
            ),
            icon: _stationIcons[station.id] ?? _customMarker,
            infoWindow: InfoWindow(title: station.name),
            onTap: () => {
              // Navigate to station details screen
              showStationModal(context, station),
            },
          ),
        ),
      ),
      onMapCreated: widget.onMapCreated,
    );
  }
}
