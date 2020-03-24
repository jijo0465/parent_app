import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:parent_app/components/digi_screen_title.dart';
import 'package:parent_app/components/digicampus_appbar.dart';

class SchoolBusScreen extends StatefulWidget {
  const SchoolBusScreen({Key key}) : super(key: key);

  @override
  _SchoolBusScreenState createState() => _SchoolBusScreenState();
}

class _SchoolBusScreenState extends State<SchoolBusScreen> {
  bool isLoading = true;
  LatLng busLocation;
  BitmapDescriptor locationPinIcon;
  Marker marker;
  GoogleMapController mapController;

  @override
  void initState() {
    busLocation = LatLng(15.496777, 73.827827);
    BitmapDescriptor.fromAssetImage(ImageConfiguration(devicePixelRatio: 0.025),
            'assets/images/schoolbus.png')
        .then((onValue) {
      locationPinIcon = onValue;
      marker = Marker(
        markerId: MarkerId("bus_loc"),
        position: busLocation,
        infoWindow: InfoWindow(title: 'Bus Location'),
        icon: locationPinIcon,
      );
      setState(() {
        isLoading = false;
      });
    }); //_markers.clear();
    super.initState();
  }

  void driveCamera(mapController) {
    //   _markers.add(marker);
    mapController.animateCamera(CameraUpdate.newLatLngZoom(busLocation, 15));
    // busLocation = LatLng((busLocation.latitude + 0.002500), 73.827827);
    // //driveCamera();
    //mapController.animateCamera(CameraUpdate.newLatLngZoom(LatLng(8.5069, 76.9569), 15));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: isLoading
            ? Container()
            : Column(children: <Widget>[
                DigiCampusAppbar(
                  icon: Icons.close,
                  onDrawerTapped: () {
                    Navigator.of(context).pop();
                  },
                ),
                SizedBox(height: 12),
                DigiScreenTitle(text: 'School Bus Tracking'),
                SizedBox(height: 12),
                Expanded(
                  child: GoogleMap(
                      padding: EdgeInsets.all(6),
                      markers: Set.of((marker != null) ? [marker] : []),
                      initialCameraPosition:
                          CameraPosition(target: busLocation),
                      onMapCreated: (mapController) {
                        driveCamera(mapController);
                      }),
                ),
                SizedBox(
                  height: 20,
                )
              ]));
  }
}
