import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_country_app/Country.dart';

class DetailPage extends StatefulWidget {

  final Country country;

  DetailPage(this.country);

  @override
  State<StatefulWidget> createState() {
    return DetailPageState(country);
  }
  
}

class DetailPageState extends State<DetailPage> {

Country country;

DetailPageState(this.country);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:  _buildAppBar(),
      body: _buildBody(context),
    );
  }

  AppBar _buildAppBar(){
    return AppBar(
      title: Text(country.name),
      centerTitle: true,
    );
  }

  Widget _buildBody(BuildContext context){
    return Column(
      children: [
        SizedBox(
          width: double.infinity,
          height: 32,
          ),
        _buildFlag(context),
        SizedBox(height: 24),
        _buildCountryName(),
        SizedBox(height: 36),
       _buildCountryAllDetailRow(),
      ],
    );
  }


  Widget _buildCountryAllDetailRow(){
    return Padding(
      padding: const EdgeInsets.only(left : 125),
      child: Column(
        children: [
          _buildCountryDetailRow("Name :  ", country.name),
          SizedBox(height: 24),
          _buildCountryDetailRow("Capital :  ", country.capital),
          SizedBox(height: 24),
          _buildCountryDetailRow("Currency :  ", country.currency),
          SizedBox(height: 24),
          _buildCountryDetailRow("Language :  ", country.language),
          SizedBox(height: 24),
          _buildCountryDetailRow("Region :  ", country.region),
        ],
      ),
    );
  }

  Widget _buildFlag(BuildContext context){
    return Image.network(
      country.flag,
      //resmi yarı boyutuna indirir
      width: MediaQuery.sizeOf(context).width / 2,
      //resmin oranını genişliğe göre ayarla
      fit: BoxFit.fitHeight,
      );
  }

  Widget _buildCountryName(){
    return Text(
      country.name,
      style: TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.bold,
        ),
    );
  }

  Widget _buildCountryDetailRow(String baslik, String detay){
    return Row(
      children: [
        Expanded(
          flex: 2,
          child: Text(
            baslik,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),

        Expanded(
          flex: 3,
          child: Text(
            detay,
            style: TextStyle(
              fontSize: 18),
          ),
        ),

      ],
    );
  }
}