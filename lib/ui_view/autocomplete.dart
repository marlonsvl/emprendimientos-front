import 'package:emprendimientos/home_screen.dart';
import 'package:emprendimientos/main.dart';
import 'package:flutter/material.dart';
import 'package:emprendimientos/emp_theme.dart';
import 'package:emprendimientos/ests_list_data.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';
import 'dart:async';
import 'dart:convert';

@immutable
class Emp {
  const Emp({
    required this.name
  });

  final String name;

  @override
  String toString() {
    return '$name';
  }

  @override
  bool operator ==(Object other) {
    if (other.runtimeType != runtimeType) {
      return false;
    }
    return other is Emp && other.name == name;
  }

  factory Emp.fromJson(Map<String, dynamic> json) {
    return Emp(
      name: json['nombre']
    );
  }

}

class AutocompleteNames extends StatelessWidget  {
  AutocompleteNames({Key? key}) : super(key: key);

  late List<Emp> _userOptions;

  static String _displayStringForOption(Emp option) => option.name;

  static String valor = '';
  final fieldTextEditingController = TextEditingController();

  Future<List<Emp>> getData() async {
    List<Emp> result = await fetchEmp("${HomeScreen.serverName}/api/nombres/");
    _userOptions = result;
    return result;
  }

  List<Emp> parseEmp(http.Response response) {
    final parsed = jsonDecode(utf8.decode(response.bodyBytes)).cast<Map<String, dynamic>>();

    return parsed.map<Emp>((json) => Emp.fromJson(json)).toList();
  }


  Future<List<Emp>> fetchEmp(String uri) async {
    final response = await http
        .get(Uri.parse(uri), headers: {
      "Access-Control-Allow-Origin": "*", // Required for CORS support to work
      "Access-Control-Allow-Credentials": "true", // Required for cookies, authorization headers with HTTPS
      "Access-Control-Allow-Headers": "Origin,Content-Type,X-Amz-Date,Authorization,X-Api-Key,X-Amz-Security-Token,locale",
      "Access-Control-Allow-Methods": "POST, OPTIONS"
    },);
    print("======= ${response.statusCode}");
    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      //Future<List<Establecimiento>> fut = compute(parseEstablecimientos, response);
      return compute(parseEmp, response);
      //return fut;
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load startups');
    }
  }

  @override
  void initState()  {
    fieldTextEditingController.clear();
  }

  @override
  Widget build(BuildContext context) {
    getData();
    return
      Autocomplete<Emp>(
      fieldViewBuilder: (
          BuildContext context,
          fieldTextEditingController,
          FocusNode fieldFocusNode,
          VoidCallback onFieldSubmitted
      ) {

        return TextField(
          controller: fieldTextEditingController,
          focusNode: fieldFocusNode,
          style: const TextStyle(
            fontSize: 18,
          ),
          cursorColor: EmpAppTheme.buildLightTheme().primaryColor,
          decoration: InputDecoration(
            border: InputBorder.none,
            hintText: 'Nombre',
          ),
        );
      },
      displayStringForOption: _displayStringForOption,
      optionsBuilder: (TextEditingValue textEditingValue) {
        if (textEditingValue.text == '') {
          return const Iterable<Emp>.empty();
        }

        return _userOptions.where((Emp option) {

          return option.name.toLowerCase()
              .toString()
              .contains(textEditingValue.text.toLowerCase());
        });
      },
      onSelected: (Emp selection) {
          print('You just selected ${_displayStringForOption(selection)}');
          valor = _displayStringForOption(selection);
          fieldTextEditingController.clear();
          fieldTextEditingController.text = '';
      },


      /*optionsViewBuilder: (
          BuildContext context,
          AutocompleteOnSelected<User> onSelected,
          Iterable<User> options
          )  {
        return Align(
          alignment: Alignment.topLeft,
          child: Material(
            child: Container(
              width: 300,
              color: EmpAppTheme.buildLightTheme().primaryColor,
              child: ListView.builder(
                padding: EdgeInsets.all(10.0),
                itemCount: options.length,
                itemBuilder: (BuildContext context, int index) {
                  final Emp option = options.elementAt(index);

                  return GestureDetector(
                    onTap: () {
                      onSelected(option);
                    },
                    child: ListTile(
                      title: Text(option.name, style: const TextStyle(color: Colors.white)),
                    ),
                  );
                },
              ),
            ),
          ),
        );
      },*/
    );
  }
}
