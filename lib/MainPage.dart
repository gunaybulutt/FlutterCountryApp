import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_country_app/CommonList.dart';
import 'package:flutter_country_app/Country.dart';
import 'package:flutter_country_app/FavoritePage.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class MainPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return MainPageState();
  }
  
}

class MainPageState extends State<MainPage> {

  String apiUrl = "https://raw.githubusercontent.com/atilsamancioglu/IA19-DataSetCountries/master/countrydataset.json";

  List<Country> _allCountries = [];
  List<String> _favoriteCountryCode = [];


  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_){
      _getDataFromLocal().then((value){
        _getDataFromApi();
      });
      
      
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context),
      body: _buildBody(),
    );
  }


  AppBar _buildAppBar(BuildContext context){
    return AppBar(
      title: Text("All Countries"),
      centerTitle: true,
      actions: [
        IconButton(
          onPressed: (){
            _openFavoritePage(context);
            },
          icon: Icon(
            Icons.favorite,
            color: Colors.black,
          ),
        ),
      ],
    );
  }

  Widget _buildBody(){
    return _allCountries.isEmpty ? 
    Center(child: CircularProgressIndicator())
    : CommonList(_allCountries,_favoriteCountryCode);
  }


  void _openFavoritePage(BuildContext context){

    MaterialPageRoute pageRoute = MaterialPageRoute(
      builder: (context){
        return FavoritePage(_allCountries,_favoriteCountryCode);
    });
    Navigator.push(context, pageRoute);

  }


 

  void _getDataFromApi() async {
    Uri uri = Uri.parse(apiUrl);
    http.Response response = await http.get(uri);
    
    List<dynamic> parsedResponse = jsonDecode(response.body);

    for(int i = 0; i<parsedResponse.length; i++){
      Map<String,dynamic> countryMap = parsedResponse[i];
      Country country = Country.fromJson(countryMap);
      _allCountries.add(country);
    }

    setState(() {});
  }

  

  Future<void> _getDataFromLocal() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? favorite = prefs.getStringList("favorites");

    if(favorite != null){
      for(String countryName in favorite){
        _favoriteCountryCode.add(countryName);
      }
    }

  }
  
}