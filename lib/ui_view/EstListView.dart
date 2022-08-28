import 'package:emprendimientos/emp_theme.dart';
import 'package:emprendimientos/ests_list_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:emprendimientos/home_screen.dart';

class EstListView extends StatelessWidget {
  const EstListView({Key? key,
    this.estData,
    this.animationController,
    this.animation,
    this.callback}) : super(key: key);

  final VoidCallback? callback;
  final AnimationController? animationController;
  final Animation<double>? animation;
  final Establecimiento? estData;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animationController!,
      builder: (BuildContext context, Widget? child) {
        return FadeTransition(
          opacity: animation!,
          child: Transform(
            transform: Matrix4.translationValues(
                0.0, 50 * (1.0 - animation!.value), 0.0),
            child: Padding(
              padding: const EdgeInsets.only(
                  left: 24, right: 24, top: 8, bottom: 16),
              child: InkWell(
                splashColor: Colors.transparent,
                onTap: callback,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(16.0)),
                    boxShadow: <BoxShadow>[
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.6),
                        offset: const Offset(4, 4),
                        blurRadius: 16,
                      ),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: const BorderRadius.all(Radius.circular(16.0)),
                    child: Stack(
                      children: <Widget>[
                        Column(
                          children: <Widget>[
                            AspectRatio(
                              aspectRatio: 2,
                              child: Image.network(
                                //estData!.url!,
                                '${HomeScreen.serverName}/static/gastronomia/fotos/${estData!.nombre}.jpg',
                                //'https://picsum.photos/250?image=9',
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) {
                                  return Container(
                                    color: Colors.amber,
                                    alignment: Alignment.center,
                                    child: const Text(
                                      'No image!',
                                      style: TextStyle(fontSize: 30),
                                    ),
                                  );
                                },
                              ),
                            ),
                            Container(
                              color: EmpAppTheme.buildLightTheme()
                                  .backgroundColor,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Expanded(
                                    child: Container(
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            left: 16, top: 8, bottom: 8),
                                        child: Column(
                                          mainAxisAlignment:
                                            MainAxisAlignment.center,
                                          crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Text(
                                              estData!.nombre!,
                                              textAlign: TextAlign.left,
                                              style: TextStyle(
                                                fontWeight: FontWeight.w600,
                                                fontSize: 22,
                                              ),
                                            ),
                                            Row(
                                              crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                              mainAxisAlignment:
                                                MainAxisAlignment.start,
                                              children: <Widget>[
                                                /*Text(
                                                  estData!.tipoServicio!,
                                                  style: TextStyle(
                                                    fontSize: 14,
                                                    color: Colors.grey
                                                        .withOpacity(0.8)),
                                                ),
                                                const SizedBox(
                                                  width: 4,
                                                ),
                                                Icon(
                                                  FontAwesomeIcons.mapMarkerAlt,
                                                  size: 12,
                                                  color: EmpAppTheme
                                                      .buildLightTheme()
                                                      .primaryColor,
                                                ),*/
                                                Expanded(
                                                  child: Text(
                                                    '${estData!.oferta}'.replaceAll('_', ' '),
                                                    overflow:
                                                    TextOverflow.ellipsis,
                                                    style: TextStyle(
                                                        fontSize: 14,
                                                        color: Colors.grey
                                                            .withOpacity(0.8)),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            /*Padding(
                                              padding:
                                                const EdgeInsets.only(top: 4),
                                              child: Row(
                                                children: <Widget>[
                                                  RatingBar(
                                                    initialRating: 1,
                                                    direction: Axis.horizontal,
                                                    allowHalfRating: true,
                                                    itemCount: 5,
                                                    itemSize: 24,
                                                    ratingWidget: RatingWidget(
                                                      full: Icon(
                                                        Icons.star_rate_rounded,
                                                        color: EmpAppTheme
                                                            .buildLightTheme()
                                                            .primaryColor,
                                                      ),
                                                      half: Icon(
                                                        Icons.star_half_rounded,
                                                        color: EmpAppTheme
                                                            .buildLightTheme()
                                                            .primaryColor,
                                                      ),
                                                      empty: Icon(
                                                        Icons
                                                            .star_border_rounded,
                                                        color: EmpAppTheme
                                                            .buildLightTheme()
                                                            .primaryColor,
                                                      ),
                                                    ),
                                                    itemPadding: EdgeInsets.zero,
                                                    onRatingUpdate: (rating) {
                                                      print(rating);
                                                    },
                                                  ),
                                                  Text(
                                                    'Contacto al:  ${estData!.email}',
                                                    style: TextStyle(
                                                        fontSize: 14,
                                                        color: Colors.grey
                                                            .withOpacity(0.8)),
                                                  ),
                                                ],
                                              ),
                                            ),*/
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        right: 16, top: 8),
                                    child: Column(
                                      mainAxisAlignment:
                                        MainAxisAlignment.center,
                                      crossAxisAlignment:
                                        CrossAxisAlignment.end,
                                      children: <Widget>[
                                        Text(
                                          'Precio promedio:',
                                          style: TextStyle(
                                              fontSize: 14,
                                              color:
                                              Colors.grey.withOpacity(0.8)),
                                        ),
                                        Text(
                                          '\$${estData!.precioPromedio.toString()}',
                                          textAlign: TextAlign.left,
                                          style: TextStyle(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 22,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        Positioned(
                          top: 8,
                          right: 8,
                          child: Material(
                            color: Colors.transparent,
                            child: InkWell(
                              borderRadius: const BorderRadius.all(
                                Radius.circular(32.0),
                              ),

                              ////// aqui poner favorito //////
                              onTap: () {},
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Icon(
                                  Icons.favorite_border,
                                  color: EmpAppTheme.buildLightTheme()
                                      .primaryColor,
                                ),
                              ),
                            ),
                          )
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
