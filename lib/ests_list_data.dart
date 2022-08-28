import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';
import 'dart:async';
import 'dart:convert';


class Establecimiento {
  Establecimiento({
    this.nombre = '',
    this.parroquia = '',
    this.ruc = '',
    this.sector = '',
    this.telefono = '',
    this.email = '',
    this.propietario = '',
    this.tipo = '',
    this.redesSociales = '',
    this.asociacion = '',
    this.local = '',
    this.equipos = '',
    this.equiposCocina = '',
    this.serviciosComplementarios = '',
    this.numeroMesas = 0,
    this.plazas = 0,
    this.banio = '',
    this.oferta = '',
    this.tipoServicio = '',
    this.menu = '',
    this.precioPromedio = 0.0,
    this.proceso = '',
    this.materiasPrimas = '',
    this.tipoMateriaPrima = '',
    this.numeroMujeres = 0,
    this.numeroHombres = 0,
    this.formacionAcademica = '',
    this.personalCapacitado = '',
    this.frecuenciaCapacitacion = '',
    this.empleadosFormacion = '',
    this.licenciaAnual = '',
    this.url = '',
    this.latitude = 0.0,
    this.longitude = 0.0

  });
  String? nombre;
  String? parroquia;
  String? ruc;
  String? sector;
  String? telefono;
  String? email;
  String? propietario;
  String? tipo;
  String? redesSociales;
  String? asociacion;
  String? local;
  String? equipos;
  String? equiposCocina;
  String? serviciosComplementarios;
  int? numeroMesas;
  int? plazas;
  String? banio;
  String? oferta;
  String? tipoServicio;
  String? menu;
  double? precioPromedio;
  String? proceso;
  String? materiasPrimas;
  String? tipoMateriaPrima;
  int? numeroMujeres;
  int? numeroHombres;
  String? formacionAcademica;
  String? personalCapacitado;
  String? frecuenciaCapacitacion;
  String? empleadosFormacion;
  String? licenciaAnual;
  String? url;
  double latitude;
  double longitude;

  factory Establecimiento.fromJson(Map<String, dynamic> json) {
    return Establecimiento(

      nombre: json['nombre'],
      parroquia: json['parroquia'],
      ruc: json['ruc'],
      sector: json['sector'],
      telefono: json['telefono'],
      email: json['email'],
      propietario: json['propietario'],
      tipo: json['tipo'],
      redesSociales: json['redes_sociales'],
      asociacion: json['asociacion'],
      local: json['local'],
      equipos: json['equipos'],
      equiposCocina: json['equipos_cocina'],
      serviciosComplementarios: json['servicios_complementarios'],
      numeroMesas: json['numero_mesas'],
      plazas: json['plazas'],
      banio: json['banio'],
      oferta: json['oferta'],
      tipoServicio: json['tipo_servicio'],
      menu: json['menu'],
      precioPromedio: json['precio_promedio'],
      proceso: json['proceso'],
      materiasPrimas: json['materias_primas'],
      tipoMateriaPrima: json['tipo_materia_prima'],
      numeroMujeres: json['numero_mujeres'],
      numeroHombres: json['numero_hombres'],
      formacionAcademica: json['formacion_academica'],
      personalCapacitado: json['personal_caapacitado'],
      frecuenciaCapacitacion: json['frecuencia_capacitacion'],
      empleadosFormacion: json['empleados_formacion'],
      licenciaAnual: json['licencia_anual'],
      url: json['url'],
      latitude: json['latitude'],
      longitude: json['longitude'],
    );
  }

}

// A function that converts a response body into a List<Establecimiento>.
List<Establecimiento> parseEstablecimientos(http.Response response) {
  final parsed = jsonDecode(utf8.decode(response.bodyBytes)).cast<Map<String, dynamic>>();

  return parsed.map<Establecimiento>((json) => Establecimiento.fromJson(json)).toList();
}

Future<List<Establecimiento>> fetchEstablecimientos(String uri) async {
  final response = await http
      .get(Uri.parse(uri), headers: {
    "Access-Control-Allow-Origin": "*", // Required for CORS support to work
    //"Access-Control-Allow-Credentials": "true", // Required for cookies, authorization headers with HTTPS
    "Access-Control-Allow-Headers": "Origin,Content-Type,X-Amz-Date,Authorization,X-Api-Key,X-Amz-Security-Token,locale",
    "Access-Control-Allow-Methods": "POST, OPTIONS, GET"
  },);
  print("======= ${response.statusCode}");
  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    //Future<List<Establecimiento>> fut = compute(parseEstablecimientos, response);
    return compute(parseEstablecimientos, response);
    //return fut;
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load startups');
  }
}

////////////////////////

class HotelListData {
  HotelListData({
    this.imagePath = '',
    this.titleTxt = '',
    this.subTxt = "",
    this.dist = 1.8,
    this.reviews = 80,
    this.rating = 4.5,
    this.perNight = 180,
  });

  String imagePath;
  String titleTxt;
  String subTxt;
  double dist;
  double rating;
  int reviews;
  int perNight;

  static List<HotelListData> hotelList = <HotelListData>[
    HotelListData(
      imagePath: 'assets/images/hotel_1.png',
      titleTxt: 'Grand Royal Hotel',
      subTxt: 'Wembley, London',
      dist: 2.0,
      reviews: 80,
      rating: 4.4,
      perNight: 180,
    ),
    HotelListData(
      imagePath: 'assets/images/hotel_2.png',
      titleTxt: 'Queen Hotel',
      subTxt: 'Wembley, London',
      dist: 4.0,
      reviews: 74,
      rating: 4.5,
      perNight: 200,
    ),
    HotelListData(
      imagePath: 'assets/images/hotel_3.png',
      titleTxt: 'Grand Royal Hotel',
      subTxt: 'Wembley, London',
      dist: 3.0,
      reviews: 62,
      rating: 4.0,
      perNight: 60,
    ),
    HotelListData(
      imagePath: 'assets/images/hotel_4.png',
      titleTxt: 'Queen Hotel',
      subTxt: 'Wembley, London',
      dist: 7.0,
      reviews: 90,
      rating: 4.4,
      perNight: 170,
    ),
    HotelListData(
      imagePath: 'assets/images/hotel_5.png',
      titleTxt: 'Grand Royal Hotel',
      subTxt: 'Wembley, London',
      dist: 2.0,
      reviews: 240,
      rating: 4.5,
      perNight: 200,
    ),
  ];
}


////////////////////

// A function that converts a response body into a List<Photo>.
List<Album> parseAlbums(String responseBody) {
  final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();

  return parsed.map<Album>((json) => Album.fromJson(json)).toList();
}



Future<List<Album>> fetchAlbums(String uri) async {
  final response = await http
      .get(Uri.parse(uri));

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    return compute(parseAlbums, response.body);
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load album');
  }
}
class Album {
  final int userId;
  final int id;
  final String title;

  const Album({
    required this.userId,
    required this.id,
    required this.title,
  });

  factory Album.fromJson(Map<String, dynamic> json) {
    return Album(
      userId: json['userId'],
      id: json['id'],
      title: json['title'],
    );
  }
}

