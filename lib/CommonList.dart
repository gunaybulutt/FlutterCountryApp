import 'package:flutter/material.dart';
import 'package:flutter_country_app/Country.dart';
import 'package:flutter_country_app/DetailPage.dart';
import 'package:shared_preferences/shared_preferences.dart';


class CommonList extends StatefulWidget {

  List<Country> _allFavoriteCountries = [];
  List<String> _favoriteCountryCode = [];

  CommonList(this._allFavoriteCountries,this._favoriteCountryCode);

  @override
  State<StatefulWidget> createState() {
    return CommonListState(_allFavoriteCountries,_favoriteCountryCode);
  }
  
}

class CommonListState extends State<CommonList> {

  List<Country> _allFavoriteCountries = [];
  List<String> _favoriteCountryCode = [];

  CommonListState(this._allFavoriteCountries,this._favoriteCountryCode);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: _allFavoriteCountries.length,
      itemBuilder: itemBuilder,
      );
  }



   Widget? itemBuilder(BuildContext context, int index) {

    Country country = _allFavoriteCountries[index];

    return ListTile(
      title: Text(country.name),
      subtitle: Text(country.capital),
      leading: CircleAvatar(
        backgroundImage: NetworkImage(country.flag)
        ),

      trailing: IconButton( 

        onPressed: (){
          _clickedFavoriteButton(country);
        },

        icon: Icon(
          _favoriteCountryCode.contains(country.name)
          ? Icons.favorite
          : Icons.favorite_border,
          color: Colors.red,
        ),
      ),

      onTap:(){
         _clickedCountry(context,country);
      }
    );
  }



  void _clickedCountry(BuildContext context, Country country){
    MaterialPageRoute pageRoute = MaterialPageRoute(
      builder: (context){
        return DetailPage(country);
    });
    Navigator.push(context, pageRoute);
  }



  void _clickedFavoriteButton(Country country) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    //contains listenin o elemanı yada yapıyı içerip içermediğini kontrol eder
    if(_favoriteCountryCode.contains(country.name)){
      _favoriteCountryCode.remove(country.name);
    }else{
      _favoriteCountryCode.add(country.name);
    }

    await prefs.setStringList("favorites", _favoriteCountryCode);

    setState(() {});
  }
}