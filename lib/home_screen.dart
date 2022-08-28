import 'package:emprendimientos/emprendimientos_theme.dart';
import 'package:emprendimientos/ui_view/EstListView.dart';
import 'package:emprendimientos/ui_view/autocomplete.dart';
import 'package:flutter/material.dart';
import 'package:emprendimientos/ui_view/title_view.dart';
import 'package:emprendimientos/emp_theme.dart';
import 'package:emprendimientos/filters_screen.dart';
import 'package:emprendimientos/ests_list_data.dart';
import 'package:emprendimientos/ui_view/est_info_screen.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'dart:ui';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key, this.animationController}) : super(key: key);

  final AnimationController? animationController;
  @override
  State<HomeScreen> createState() => _HomeScreenState();
  static String serverName = 'https://peaceful-garden-43285.herokuapp.com';//'http://192.168.1.3:8000';
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin{

  Animation<double>? topBarAnimation;

  List<Widget> listViews = <Widget>[];
  final ScrollController _scrollController = ScrollController();
  double topBarOpacity = 0.0;

  final fieldController = TextEditingController();

  AnimationController? animationController;

  List<HotelListData> hotelList = HotelListData.hotelList;

  //late Future<List<Establecimiento>> futureEst;
  List<Establecimiento>? li;
  //late Future<List<Album>> futureAlbum;
  //Future<List<Establecimiento>> fut = fetchEstablecimientos("http://127.0.0.1:8000/api/establecimientos/");
  //static String serverName = 'http://192.168.1.3:8000';
  double priceFilter = 10.0;
  List<String> parroquias = [];

  @override
  void initState()  {
    animationController = AnimationController(
        duration: const Duration(milliseconds: 1000), vsync: this);

    topBarAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(
            parent: widget.animationController!,
            curve: Interval(0, 0.5, curve: Curves.fastOutSlowIn)));
    super.initState();
    //addAllListData();
    //loadData();
    //getData();
  }

  void loadData() async {
    if(AutocompleteNames.valor == '') {
      List<Establecimiento> result = await fetchEstablecimientos(
          "${HomeScreen.serverName}/api/establecimientos/");
      li = result;
    }else{
      List<Establecimiento> result = await fetchEstablecimientos(
          "${HomeScreen.serverName}/api/establecimientos/?nombre=${AutocompleteNames.valor}");
      li = result;

    }
  }

  Future<List<Establecimiento>> getData() async {
    if(AutocompleteNames.valor.isEmpty) {
      if(priceFilter < 10.0){
        List<Establecimiento> result = await fetchEstablecimientos(
            "${HomeScreen.serverName}/api/establecimientos/?precio=$priceFilter");
        li = result;
        print("price filter ===== ${result.length}");
        return result;
      }else if(parroquias.isNotEmpty) {
        String aux = parroquias.toString().replaceAll("[", "").replaceAll("]", "").replaceAll(" ", "");
        List<Establecimiento> result = await fetchEstablecimientos(
            "${HomeScreen.serverName}/api/establecimientos/?parroquia=$aux");
        li = result;
        //print("parr filter ===== ${result.length}");
        return result;

      }else{
        List<Establecimiento> result = await fetchEstablecimientos(
            "${HomeScreen.serverName}/api/establecimientos/");
        li = result;
        print("sin valor ===== ${result.length}");
        return result;
      }
    }else{
      List<Establecimiento> result = await fetchEstablecimientos(
          "${HomeScreen.serverName}/api/establecimientos/?nombre=${AutocompleteNames.valor}");
      li = result;
      print("con valor ===== ${result.length}");

      return result;
    }


  }

  void addAllListData() {
    const int count = 9;
    listViews.add(
      TitleView(
        titleTxt: 'Parroquias Rurales',
        animation: Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
            parent: widget.animationController!,
            curve:
            Interval((1 / count) * 0, 1.0, curve: Curves.fastOutSlowIn))),
        animationController: widget.animationController!,
      ),
    );

  }

  @override
  void dispose() {
    animationController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: EmpAppTheme.buildLightTheme(),
      child: Container(
        child: Scaffold(
          body: Stack(
            children: <Widget>[
              InkWell(
                splashColor: Colors.transparent,
                focusColor: Colors.transparent,
                highlightColor: Colors.transparent,
                hoverColor: Colors.transparent,
                onTap: () {
                  FocusScope.of(context).requestFocus(FocusNode());
                },
                child: Column(
                  children: <Widget>[
                    getAppBarUI(),
                    Expanded(
                      child: NestedScrollView(
                        controller: _scrollController,
                        headerSliverBuilder:
                            (BuildContext context, bool innerBoxIsScrolled) {
                          return <Widget>[
                            SliverList(
                              delegate: SliverChildBuilderDelegate(
                                      (BuildContext context, int index) {
                                    return Column(
                                      children: <Widget>[
                                        getSearchBarUI(),

                                      ],
                                    );
                                  }, childCount: 1),
                            ),
                            SliverPersistentHeader(
                              pinned: true,
                              floating: true,
                              delegate: ContestTabHeader(
                                getFilterBarUI(),
                              ),
                            ),
                          ];
                        },
                        body:
                        Container(
                          color:
                          EmpAppTheme.buildLightTheme().backgroundColor,
                          child:
                          FutureBuilder<List<Establecimiento>> (
                              future: getData(),
                              builder: (context, snapshot){
                                if (snapshot.hasError){
                                  return const Center(
                                    child: Text('An error has occurred!'),
                                  );
                                }else if (snapshot.hasData){
                                  return ListView.builder(
                                    itemCount: snapshot.data?.length,
                                    padding: const EdgeInsets.only(top: 8),
                                    scrollDirection: Axis.vertical,
                                    itemBuilder: (BuildContext context, int index) {
                                      //int count = snapshot.data?.length;
                                      //li!.length! > 10 ? 10 : li!.length!;
                                      final Animation<double> animation =
                                      Tween<double>(begin: 0.0, end: 1.0).animate(
                                          CurvedAnimation(
                                              parent: animationController!,
                                              curve: Interval(
                                                  (1 / 74) * index, 1.0,
                                                  curve: Curves.fastOutSlowIn)));
                                      animationController?.forward();
                                      return
                                        EstListView(
                                          callback: () {
                                            Establecimiento? e = snapshot.data?[index];
                                            moveTo(e);
                                          },
                                          estData: snapshot.data?[index],
                                          animation: animation,
                                          animationController: animationController!,
                                        );
                                    },
                                  );
                                }else{
                                  return const Center(
                                    child: CircularProgressIndicator(),
                                  );
                                }
                              },

                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void moveTo(Establecimiento? e) {
    Navigator.push<dynamic>(
      context,
      MaterialPageRoute<dynamic>(
        builder: (BuildContext context) =>  EstInfoScreen(establecimientoObj: e,),
      ),
    );

  }

  /*
  Widget getListUI() {
    return Container(
      decoration: BoxDecoration(
        color: EmpAppTheme.buildLightTheme().backgroundColor,
        boxShadow: <BoxShadow>[
          BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              offset: const Offset(0, -2),
              blurRadius: 8.0),
        ],
      ),
      child: Column(
        children: <Widget>[
          Container(
            height: MediaQuery.of(context).size.height - 156 - 50,
            child: FutureBuilder<bool>(
              future: getData(),
              builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
                if (!snapshot.hasData) {
                  return const SizedBox();
                } else {
                  return ListView.builder(
                    itemCount: hotelList.length,
                    scrollDirection: Axis.vertical,
                    itemBuilder: (BuildContext context, int index) {
                      final int count =
                      hotelList.length > 10 ? 10 : hotelList.length;
                      final Animation<double> animation =
                      Tween<double>(begin: 0.0, end: 1.0).animate(
                          CurvedAnimation(
                              parent: animationController!,
                              curve: Interval((1 / count) * index, 1.0,
                                  curve: Curves.fastOutSlowIn)));
                      animationController?.forward();

                      return HotelListView(
                        callback: () {},
                        hotelData: hotelList[index],
                        animation: animation,
                        animationController: animationController!,
                      );
                    },
                  );
                }
              },
            ),
          )
        ],
      ),
    );
  }
  */

  /*
  Widget getHotelViewList() {
    final List<Widget> hotelListViews = <Widget>[];
    for (int i = 0; i < hotelList.length; i++) {
      final int count = hotelList.length;
      final Animation<double> animation =
      Tween<double>(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(
          parent: animationController!,
          curve: Interval((1 / count) * i, 1.0, curve: Curves.fastOutSlowIn),
        ),
      );
      hotelListViews.add(
        HotelListView(
          callback: () {},
          hotelData: hotelList[i],
          animation: animation,
          animationController: animationController!,
        ),
      );
    }
    animationController?.forward();
    return Column(
      children: hotelListViews,
    );
  }
  */

  Widget getMainListViewUI() {
    return FutureBuilder<List<Establecimiento>>(
      future: getData(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const SizedBox();
        } else {
          return ListView.builder(
            controller: _scrollController,
            padding: EdgeInsets.only(
              top: AppBar().preferredSize.height +
                  MediaQuery.of(context).padding.top +
                  24,
              bottom: 62 + MediaQuery.of(context).padding.bottom,
            ),
            itemCount: listViews.length,
            scrollDirection: Axis.vertical,
            itemBuilder: (BuildContext context, int index) {
              widget.animationController?.forward();
              return listViews[index];
            },
          );
        }
      },
    );
  }

  Widget getAppBarUI() {
    return Container(
      decoration: BoxDecoration(
        color: EmpAppTheme.buildLightTheme().backgroundColor,
        boxShadow: <BoxShadow>[
          BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              offset: const Offset(0, 2),
              blurRadius: 8.0),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.only(
            top: MediaQuery.of(context).padding.top, left: 8, right: 8),
        child: Row(
          children: <Widget>[
            /*Container(
              alignment: Alignment.centerLeft,
              width: AppBar().preferredSize.height + 40,
              height: AppBar().preferredSize.height,
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  borderRadius: const BorderRadius.all(
                    Radius.circular(32.0),
                  ),
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Icon(Icons.arrow_back),
                  ),
                ),
              ),
            ),*/
            Expanded(
              child: Center(
                child: Text(
                  'Emprendimientos - Loja',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 22,
                  ),
                ),
              ),
            ),
            Container(
              width: AppBar().preferredSize.height + 40,
              height: AppBar().preferredSize.height,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  /*Material(
                    color: Colors.transparent,
                    child: InkWell(
                      borderRadius: const BorderRadius.all(
                        Radius.circular(32.0),
                      ),
                      onTap: () {},
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Icon(Icons.favorite_border),
                      ),
                    ),
                  ),*/
                  Material(
                    color: Colors.transparent,
                    child: InkWell(
                      borderRadius: const BorderRadius.all(
                        Radius.circular(32.0),
                      ),
                      onTap: () {

                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Icon(FontAwesomeIcons.mapMarkerAlt),
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget getSearchBarUI() {
    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 16, top: 8, bottom: 8),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(right: 16, top: 8, bottom: 8),
              child: Container(
                decoration: BoxDecoration(
                  color: EmpAppTheme.buildLightTheme().backgroundColor,
                  borderRadius: const BorderRadius.all(
                    Radius.circular(38.0),
                  ),
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                        color: Colors.grey.withOpacity(0.2),
                        offset: const Offset(0, 2),
                        blurRadius: 8.0),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.only(
                      left: 16, right: 16, top: 4, bottom: 4),
                  child: AutocompleteNames(),
                  /*TextField(
                    controller: fieldController,
                    onChanged: (String txt) {},
                    style: const TextStyle(
                      fontSize: 18,
                    ),
                    cursorColor: EmpAppTheme.buildLightTheme().primaryColor,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Mama Viche',
                    ),
                  ),*/
                ),
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: EmpAppTheme.buildLightTheme().primaryColor,
              borderRadius: const BorderRadius.all(
                Radius.circular(38.0),
              ),
              boxShadow: <BoxShadow>[
                BoxShadow(
                    color: Colors.grey.withOpacity(0.4),
                    offset: const Offset(0, 2),
                    blurRadius: 8.0),
              ],
            ),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                borderRadius: const BorderRadius.all(
                  Radius.circular(32.0),
                ),
                onTap: () {
                  FocusScope.of(context).requestFocus(FocusNode());
                  print("texto desde home: ${AutocompleteNames.valor}");
                },
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Icon(FontAwesomeIcons.search,
                      size: 20,
                      color: EmpAppTheme.buildLightTheme().backgroundColor),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }


  Widget getFilterBarUI() {
    return Stack(
      children: <Widget>[
        Positioned(
          top: 0,
          left: 0,
          right: 0,
          child: Container(
            height: 24,
            decoration: BoxDecoration(
              color: EmpAppTheme.buildLightTheme().backgroundColor,
              boxShadow: <BoxShadow>[
                BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    offset: const Offset(0, -2),
                    blurRadius: 8.0),
              ],
            ),
          ),
        ),
        Container(
          color: EmpAppTheme.buildLightTheme().backgroundColor,
          child: Padding(
            padding:
            const EdgeInsets.only(left: 16, right: 16, top: 8, bottom: 4),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child:  Text(
                      '${li?.length} emprendimientos encontrados',
                      style: TextStyle(
                        fontWeight: FontWeight.w100,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
                Material(
                  color: Colors.transparent,
                  child: InkWell(
                    focusColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    hoverColor: Colors.transparent,
                    splashColor: Colors.grey.withOpacity(0.2),
                    borderRadius: const BorderRadius.all(
                      Radius.circular(4.0),
                    ),
                    onTap: () {
                      FocusScope.of(context).requestFocus(FocusNode());
                      Navigator.push<dynamic>(
                        context,
                        MaterialPageRoute<dynamic>(
                            builder: (BuildContext context) => FiltersScreen(
                              doubleCallback: (price){
                                setState( (){
                                  getData();
                                } );
                              }, pricecallback: (double price) {
                                  priceFilter = price;
                                  print("price desde home $priceFilter");
                              },
                              parrCallback: (parr){
                                setState( (){
                                  getData();
                                } );
                              }, parrcallback: (List<String> parr) {
                              parroquias = parr;
                              print("parroquias desde home $parroquias");
                            },
                            ),
                            fullscreenDialog: true),
                      );
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(left: 8),
                      child: Row(
                        children: <Widget>[
                          Text(
                            'Filtro',
                            style: TextStyle(
                              fontWeight: FontWeight.w100,
                              fontSize: 16,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Icon(Icons.sort,
                                color: EmpAppTheme.buildLightTheme()
                                    .primaryColor),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        const Positioned(
          top: 0,
          left: 0,
          right: 0,
          child: Divider(
            height: 1,
          ),
        )
      ],
    );
  }


}

class ContestTabHeader extends SliverPersistentHeaderDelegate {
  ContestTabHeader(
      this.searchUI,
      );
  final Widget searchUI;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return searchUI;
  }

  @override
  double get maxExtent => 52.0;

  @override
  double get minExtent => 52.0;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    return false;
  }
}

