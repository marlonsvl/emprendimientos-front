import 'package:emprendimientos/ests_list_data.dart';
import 'package:emprendimientos/ui_view/autocomplete.dart';
import 'package:flutter/material.dart';
import 'package:emprendimientos/emp_theme.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:flutter_map_marker_cluster/flutter_map_marker_cluster.dart';
//import 'package:geolocator/geolocator.dart';
import 'package:emprendimientos/ui_view/zoombuttons_plugin_option.dart';
import 'package:location/location.dart';
import 'package:flutter/services.dart';
import 'package:flutter_map_marker_popup/flutter_map_marker_popup.dart';



class EstInfoScreen extends StatefulWidget {
  const EstInfoScreen({Key? key, this.establecimientoObj}) : super(key: key);

  final Establecimiento? establecimientoObj;

  @override
  _EstInfoScreenState createState() => _EstInfoScreenState();
}

class _EstInfoScreenState extends State<EstInfoScreen>
    with TickerProviderStateMixin {
  final double infoHeight = 764.0;
  AnimationController? animationController;
  Animation<double>? animation;
  double opacity1 = 0.0;
  double opacity2 = 0.0;
  double opacity3 = 0.0;


  @override
  void initState() {
    animationController = AnimationController(
        duration: const Duration(milliseconds: 1000), vsync: this);
    animation = Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
        parent: animationController!,
        curve: Interval(0, 1.0, curve: Curves.fastOutSlowIn)));
    setData();
    super.initState();
  }

  Future<void> setData() async {
    animationController?.forward();
    await Future<dynamic>.delayed(const Duration(milliseconds: 200));
    setState(() {
      opacity1 = 1.0;
    });
    await Future<dynamic>.delayed(const Duration(milliseconds: 200));
    setState(() {
      opacity2 = 1.0;
    });
    await Future<dynamic>.delayed(const Duration(milliseconds: 200));
    setState(() {
      opacity3 = 1.0;
    });
  }



  @override
  Widget build(BuildContext context) {
    final double tempHeight = MediaQuery.of(context).size.height -
        (MediaQuery.of(context).size.width / 1.2) +
        24.0;
    return Container(
      color: EmpAppTheme.nearlyWhite,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: ListView(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
              //child:
              //Container(
                //alignment: Alignment.centerLeft,
              child: SizedBox(
                width: AppBar().preferredSize.height,
                height: AppBar().preferredSize.height,
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    borderRadius:
                    BorderRadius.circular(AppBar().preferredSize.height),
                    child: Icon(
                      Icons.arrow_back_ios,
                      color: EmpAppTheme.nearlyBlack,
                    ),
                    onTap: () {
                      Navigator.pop(context);
                      AutocompleteNames.valor = '';

                    },
                  ),
                ),
              ),
            ),
            /*Column(
              children: <Widget>[
                AspectRatio(
                  aspectRatio: 1.2,
                  child: Image.asset('assets/images/hotel_1.png'),
                ),
              ],
            ),*/
            //Positioned(
            //  top: (MediaQuery.of(context).size.width / 1.2) - 24.0,
            //  bottom: 0,
            //  left: 0,
            //  right: 0,
            //  child:
              Container(
                decoration: BoxDecoration(
                  color: EmpAppTheme.nearlyWhite,
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(32.0),
                      topRight: Radius.circular(32.0)),
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                        color: EmpAppTheme.grey.withOpacity(0.2),
                        offset: const Offset(1.1, 1.1),
                        blurRadius: 10.0),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 8, right: 8),
                  child: SingleChildScrollView(
                    child: Container(
                      height: infoHeight,
                      //constraints: BoxConstraints(
                      //    minHeight: infoHeight,
                      //    maxHeight: tempHeight > infoHeight
                      //        ? tempHeight
                      //        : infoHeight),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        //crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(
                                top: 32.0, left: 18, right: 16),
                            child: Text("${widget.establecimientoObj?.nombre}",
                              //'Web Design\nCourse',
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 22,
                                letterSpacing: 0.27,
                                color: EmpAppTheme.darkerText,
                              ),
                            ),
                          ),
                          //Padding(
                          //Expanded(
                            //padding: const EdgeInsets.only(
                            //    left: 16, right: 16, bottom: 8, top: 16),
                            //child:
                            //Column(
                            //  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            //  crossAxisAlignment: CrossAxisAlignment.center,
                            //  children: <Widget>[
                                //Container(
                                  //child: Row(
                                  //  children: <Widget>[
                                Expanded(child:
                                  Padding(
                                    padding: const EdgeInsets.only(
                                    top: 0.0, left: 18, right: 16),
                                    child: Text(
                                        'Propietario(a): ${widget.establecimientoObj?.propietario} (${widget.establecimientoObj?.parroquia})'.replaceAll("_", " "),
                                        textAlign: TextAlign.left,
                                        style: TextStyle(
                                          fontWeight: FontWeight.w200,
                                          fontSize: 14,
                                          letterSpacing: 0.27,
                                          color: EmpAppTheme.grey,
                                        ),
                                      ))),
                                      /*Icon(
                                        Icons.star,
                                        color: EmpAppTheme.nearlyBlue,
                                        size: 24,
                                      ),*/
                                    //],
                                  //),
                                //),
                          Expanded(child:
                          Padding(
                              padding: const EdgeInsets.only(
                                  top: 0.0, left: 18, right: 16),
                              child:
                              Text(
                                'Precio promedio: \$${widget.establecimientoObj?.precioPromedio}',
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                  fontWeight: FontWeight.w200,
                                  fontSize: 22,
                                  letterSpacing: 0.27,
                                  color: EmpAppTheme.buildLightTheme().primaryColor,
                                ),
                              )
                          )
                          ),
                              //],
                            //),
                          //),
                          //IntrinsicHeight(child:
                          AnimatedOpacity(
                            duration: const Duration(milliseconds: 500),
                            opacity: opacity1,
                            child: Padding(
                              padding: const EdgeInsets.all(8),
                              child:
                              getTimeBoxUI('${widget.establecimientoObj?.tipoServicio}'.replaceAll('_', ' ').replaceAll("nan", "-"), 'Tipo de servicio'),

                            ),
                          ),

                          AnimatedOpacity(
                            duration: const Duration(milliseconds: 500),
                            opacity: opacity1,
                            child: Padding(
                              padding: const EdgeInsets.all(8),
                              child:
                              getTimeBoxUI('${widget.establecimientoObj?.email}'.replaceAll("nan", "-"), 'Email'),
                              //getTimeBoxUI('+593 ${widget.establecimientoObj?.telefono}'.replaceAll("nan", "-"), 'Teléfono'),
                              //getTimeBoxUI('${widget.establecimientoObj?.tipoServicio}'.replaceAll('_', ' ').replaceAll("nan", "-"), 'Tipo de servicio'),

                            ),
                          ),
                          AnimatedOpacity(
                            duration: const Duration(milliseconds: 500),
                            opacity: opacity1,
                            child: Padding(
                              padding: const EdgeInsets.all(8),
                              child:
                              getTimeBoxUI('+593 ${widget.establecimientoObj?.telefono}'.replaceAll("nan", "-"), 'Teléfono'),
                              //getTimeBoxUI('${widget.establecimientoObj?.tipoServicio}'.replaceAll('_', ' ').replaceAll("nan", "-"), 'Tipo de servicio'),

                            ),
                          ),
                          Expanded(
                            child: AnimatedOpacity(
                              duration: const Duration(milliseconds: 500),
                              opacity: opacity2,
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    left: 16, right: 16, top: 8, bottom: 8),
                                child:

                                Text(
                                  'Menú: ${widget.establecimientoObj?.menu}',
                                  textAlign: TextAlign.justify,
                                  style: TextStyle(
                                    fontWeight: FontWeight.w200,
                                    fontSize: 18,
                                    letterSpacing: 0.27,
                                    color: EmpAppTheme.grey,
                                  ),
                                  maxLines: 6,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ),
                          ),
                          ScaleTransition(
                            alignment: Alignment.center,
                            scale: CurvedAnimation(
                                parent: animationController!, curve: Curves.fastOutSlowIn),
                            child: Card(
                              color: EmpAppTheme.buildLightTheme().primaryColor,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(50.0)),
                              elevation: 10.0,
                              child: Container(
                                  width: 60,
                                  height: 60,
                                  child:
                                  InkWell(
                                    onTap: (){
                                      moveToMap(widget.establecimientoObj);
                                    },
                                    child: Center(
                                      child: Icon(
                                        Icons.location_on,
                                        color: EmpAppTheme.nearlyWhite,
                                        size: 30,
                                      ),
                                    ),
                                  )),
                            ),
                          ),

                          //Mapa(),

                          /*AnimatedOpacity(
                            duration: const Duration(milliseconds: 500),
                            opacity: opacity3,
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  left: 16, bottom: 16, right: 16),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  Container(
                                    width: 48,
                                    height: 48,
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: EmpAppTheme.nearlyWhite,
                                        borderRadius: const BorderRadius.all(
                                          Radius.circular(16.0),
                                        ),
                                        border: Border.all(
                                            color: EmpAppTheme.grey
                                                .withOpacity(0.2)),
                                      ),
                                      child: Icon(
                                        Icons.add,
                                        color: EmpAppTheme.nearlyBlue,
                                        size: 28,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 16,
                                  ),
                                  Expanded(
                                    child: Container(
                                      height: 48,
                                      decoration: BoxDecoration(
                                        color: EmpAppTheme.nearlyBlue,
                                        borderRadius: const BorderRadius.all(
                                          Radius.circular(16.0),
                                        ),
                                        boxShadow: <BoxShadow>[
                                          BoxShadow(
                                              color: EmpAppTheme
                                                  .nearlyBlue
                                                  .withOpacity(0.5),
                                              offset: const Offset(1.1, 1.1),
                                              blurRadius: 10.0),
                                        ],
                                      ),
                                      child: Center(
                                        child: Text(
                                          'Join Course',
                                          textAlign: TextAlign.left,
                                          style: TextStyle(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 18,
                                            letterSpacing: 0.0,
                                            color: EmpAppTheme
                                                .nearlyWhite,
                                          ),
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),*/
                          SizedBox(
                            height: MediaQuery.of(context).padding.bottom,
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            //),
            //Positioned(
            //  top: (MediaQuery.of(context).size.width / 1.2) - 24.0 - 35,
            //  right: 35,
            //  child:


            //),
          ],
        ),
      ),
    );
  }

  void moveToMap(Establecimiento? e) {
    Navigator.push<dynamic>(
      context,
      MaterialPageRoute<dynamic>(
        builder: (BuildContext context) =>  MyMap(establecimientoObj: e,),
      ),
    );

  }

  Widget getTimeBoxUI(String text1, String txt2) {
    return Padding(

      padding: const EdgeInsets.all(8.0),
      child:
      Container(
        height: 60,
        decoration: BoxDecoration(
          color: EmpAppTheme.nearlyWhite,
          borderRadius: const BorderRadius.all(Radius.circular(16.0)),
          boxShadow: <BoxShadow>[
            BoxShadow(
                color: EmpAppTheme.grey.withOpacity(0.2),
                offset: const Offset(1.1, 1.1),
                blurRadius: 8.0),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.only(
              left: 18.0, right: 18.0, top: 12.0, bottom: 12.0),
          child: ListView(

            //mainAxisAlignment: MainAxisAlignment.center,
            //crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[

                  Text(
                    text1,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                      letterSpacing: 0.27,
                      color: EmpAppTheme.buildLightTheme().primaryColor,
                    ),
                  ),

              Text(
                txt2,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.w200,
                  fontSize: 14,
                  letterSpacing: 0.27,
                  color: EmpAppTheme.grey,
                ),
              ),
            ],
          ),
        ),
      ),


    );
  }

}



class MyMap extends StatefulWidget {
  MyMap({
    Key? key, this.establecimientoObj
  }) : super(key: key);

  final Establecimiento? establecimientoObj;

  @override
  _MyMapState createState() => _MyMapState();
}

class _MyMapState extends State<MyMap> {
  final PopupController _popupLayerController = PopupController();
  MapController _mapController = MapController();
  LocationData? _currentLocation;
  bool _liveUpdate = false;
  bool _permission = false;

  String? _serviceError = '';

  var interActiveFlags = InteractiveFlag.all;

  final Location _locationService = Location();

  double _zoom = 15;
  List<LatLng> _latLngList = [];
  List<Marker> _markers = [];

  void initLocationService() async {
    await _locationService.changeSettings(
      accuracy: LocationAccuracy.high,
      interval: 1000,
    );

    LocationData? location;
    bool serviceEnabled;
    bool serviceRequestResult;

    try {
      serviceEnabled = await _locationService.serviceEnabled();

      if (serviceEnabled) {
        var permission = await _locationService.requestPermission();
        _permission = permission == PermissionStatus.granted;

        if (_permission) {
          location = await _locationService.getLocation();
          _currentLocation = location;
          _locationService.onLocationChanged
              .listen((LocationData result) async {
            if (mounted) {
              setState(() {
                _currentLocation = result;

                // If Live Update is enabled, move map center
                if (_liveUpdate) {
                  _mapController.move(
                      LatLng(_currentLocation!.latitude!,
                          _currentLocation!.longitude!),
                      _mapController.zoom);
                }
              });
            }
          });
        }
      } else {
        serviceRequestResult = await _locationService.requestService();
        if (serviceRequestResult) {
          initLocationService();
          return;
        }
      }
    } on PlatformException catch (e) {
      debugPrint(e.toString());
      if (e.code == 'PERMISSION_DENIED') {
        _serviceError = e.message;
      } else if (e.code == 'SERVICE_STATUS_ERROR') {
        _serviceError = e.message;
      }
      location = null;
    }
  }


  @override
  void initState() {

    super.initState();
    initLocationService();
  }

  @override
  Widget build(BuildContext context) {
    LatLng currentLatLng;

    // Until currentLocation is initially updated, Widget can locate to 0, 0
    // by default or store previous location value to show.
    if (_currentLocation != null) {
      currentLatLng =
          LatLng(_currentLocation!.latitude!, _currentLocation!.longitude!);
    } else {
      currentLatLng = LatLng(0, 0);
    }

    _latLngList.add(LatLng(widget.establecimientoObj!.latitude, widget.establecimientoObj!.longitude));
    _latLngList.add(currentLatLng);

    _markers = _latLngList
        .map((point) => Marker(
      point: point,
      width: 60,
      height: 60,
      builder: (context) => Icon(
        Icons.pin_drop,
        size: 60,
        color: Colors.blueAccent,
      ),
    ))
        .toList();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: EmpAppTheme.buildLightTheme().primaryColor,
        title: Text('Ubicación: ${widget.establecimientoObj?.nombre}'),
      ),
      body:
        FlutterMap(
          options: MapOptions(
            center: LatLng(widget.establecimientoObj!.latitude, widget.establecimientoObj!.longitude),
            zoom: _zoom,
            interactiveFlags: InteractiveFlag.all,
            onTap: (_, __) => _popupLayerController.hideAllPopups(),
            plugins: [
              ZoomButtonsPlugin(),
            ]
          ),

          nonRotatedLayers: [
            ZoomButtonsPluginOption(
              minZoom: 4,
              maxZoom: 19,
              mini: true,
              padding: 10,
              alignment: Alignment.bottomRight,
            ),
          ],
          nonRotatedChildren: [
            AttributionWidget.defaultWidget(
              source: 'OpenStreetMap contributors',
              onSourceTapped: null,
            ),
          ],
          children: <Widget>[
            TileLayerWidget(
              options: TileLayerOptions(
                urlTemplate: 'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
                subdomains: <String>['a', 'b', 'c'],
              ),
            ),
            PopupMarkerLayerWidget(
                options: PopupMarkerLayerOptions(
                  markers: <Marker>[
                    Marker(
                      anchorPos: AnchorPos.align(AnchorAlign.top),
                      point: LatLng(widget.establecimientoObj!.latitude, widget.establecimientoObj!.longitude),
                      height: 60,
                      width: 60,
                      builder: (BuildContext ctx) => Icon(
                        Icons.pin_drop,
                        size: 60,
                        color: EmpAppTheme.buildLightTheme().primaryColor,
                      ),
                    ),
                  ],
                  popupController: _popupLayerController,
                  popupBuilder: (_, Marker marker) {
                    return
                      Container(
                          decoration: BoxDecoration(
                            color: EmpAppTheme.nearlyWhite,
                            borderRadius: const BorderRadius.all(Radius.circular(16.0)),
                            boxShadow: <BoxShadow>[
                              BoxShadow(
                                  color: EmpAppTheme.grey.withOpacity(0.2),
                                  offset: const Offset(1.1, 1.1),
                                  blurRadius: 8.0),
                            ],
                          ),
                          child:

                      SizedBox(

                      width: 200,
                      child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Text("${widget.establecimientoObj?.nombre}",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 16,
                                letterSpacing: 0.27,
                                color: EmpAppTheme.buildLightTheme().primaryColor,
                              ),
                            ),
                            Text('${widget.establecimientoObj
                                ?.latitude}-${widget.establecimientoObj
                                ?.longitude}',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontWeight: FontWeight.w200,
                                fontSize: 14,
                                letterSpacing: 0.27,
                                color: EmpAppTheme.grey,
                              ),),
                          ],
                        ),
                      ),
                    ));
                  }
                ),
            ),
          ],
        ),
    );
  }
}

