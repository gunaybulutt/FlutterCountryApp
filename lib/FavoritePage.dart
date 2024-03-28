import 'package:flutter/material.dart';
import 'package:flutter_country_app/CommonList.dart';
import 'package:flutter_country_app/Country.dart';

class FavoritePage extends StatefulWidget {

  final List<Country> _allCountries;
  final List<String> _favoriteCountryCode;

  FavoritePage(this._allCountries,this._favoriteCountryCode);

  @override
  State<StatefulWidget> createState() {
    return FavoritePageState();
  }
  
}

class FavoritePageState extends State<FavoritePage> {

  List<Country> _favoriteCountries = [];

  

  @override
  void initState() {
    super.initState();
    //FavoritePageState ile FavoritePage birbirine bağlı olduğı için widget ile ulaşılabilir
    //State'ler bağlı oldukları widget'lere (FavoritePage) tek bir anahtar kelime ile
    //Widget ile ulaşabilir
    for(Country country in widget._allCountries){
      if(widget._favoriteCountryCode.contains(country.name)){
        //bu ülkenin ülke kodları favoriler içindeyse bunu ekle
        _favoriteCountries.add(country);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: _buildBody(),
    );
  }

  AppBar _buildAppBar(){
    return AppBar(title: Text("Favorite Countries"),centerTitle: true,);
  }

  Widget _buildBody(){
    return CommonList(_favoriteCountries, widget._favoriteCountryCode);
  }
}