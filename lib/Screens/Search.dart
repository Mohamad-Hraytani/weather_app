import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:substring_highlight/substring_highlight.dart';
import 'package:weather_app/Providres/SQL/mySqdb_provider.dart';
import 'package:weather_app/Providres/SQL/weathermodel.dart';
import 'package:weather_app/Providres/weather_provider.dart';


class search extends StatefulWidget {
  const search({super.key});

  @override
  State<search> createState() => _searchState();
}

class _searchState extends State<search> {
  String query = '';
   late List<String> autoCompleteData;
late TextEditingController _searchController;
  Future fetchAutoCompleteData() async {
  
final String stringData = await rootBundle.loadString("assets/data.json");

    final List<dynamic> json = jsonDecode(stringData);

    final List<String> jsonStringData = json.cast<String>();

    setState(() {
      autoCompleteData = jsonStringData;
    });
  }


@override
  void initState() {

    super.initState();
        fetchAutoCompleteData();
  }



  @override
  Widget build(BuildContext context) {
  final weatherProvider = Provider.of<WeatherProvider>(context );
  final mydbrovider = Provider.of<mySqdb>(context );
    return   Padding(
              padding: const EdgeInsets.all(1.0),
              child: Column(
                children: [
                  Autocomplete(
                    optionsBuilder: (TextEditingValue textEditingValue) {
                      if (textEditingValue.text.isEmpty) {
                        return const Iterable<String>.empty();
                      } else {
                        return autoCompleteData.where((word) => word
                            .toLowerCase()
                            .contains(textEditingValue.text.toLowerCase()));
                      }
                    },
                    optionsViewBuilder:
                        (context, Function(String) onSelected, options) {
                      return Material(
                        color: Colors.transparent,
                        elevation: 4,
                        child: ListView.separated(
                          padding: EdgeInsets.zero,
                          itemBuilder: (context, index) {
                            final option = options.elementAt(index);

                            return ListTile(
                      
                              title: SubstringHighlight(
                                textStyle: TextStyle(color: Colors.white),
                                text: option.toString(),
                                term: _searchController.text,
                                textStyleHighlight: TextStyle(fontWeight: FontWeight.w700 , color: Colors.yellow.withRed(300)),
                              ),
                              onTap: () async{
                                onSelected(option.toString());
 
                       await     weatherProvider.fetchWeather(query);

                       mydbrovider.con(weathermodel( id:weatherProvider.id, lable: weatherProvider.City_name ));
                       



                              },
                            );
                          },
                          separatorBuilder: (context, index) => Divider(),
                          itemCount: options.length,
                        ),
                      );
                    },
                    onSelected: (selectedString) {    
                        query = selectedString;
                    },
                    fieldViewBuilder:
                        (context, controller, focusNode, onEditingComplete) {
                      this._searchController = controller;

                      return TextField(
 style: TextStyle(fontSize: 16),
                      controller: controller,
                        focusNode: focusNode,
                        onEditingComplete: onEditingComplete,
                      decoration: InputDecoration(
                                   border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(20))),
                                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20)) ,
                    borderSide: BorderSide(color: Colors.white),
                                  ),
                                  contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                        hintText: 'Enter a city name',
                        hintStyle: TextStyle(color: Colors.white, backgroundColor: Colors.black.withOpacity(0.2)),
                        suffixIcon: IconButton(
                          icon: Icon(Icons.search),
                          onPressed: () async{  
                       await     weatherProvider.fetchWeather(query);

                       mydbrovider.con(weathermodel( id:weatherProvider.id, lable: weatherProvider.City_name ));
                          },
                        ),
                      ),
                    );
                    },
                  )
                ],
              ),
            );
  }
}