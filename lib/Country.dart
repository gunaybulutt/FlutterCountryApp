class Country{
  String name;
  String capital;
  String region;
  String currency;
  String flag;
  String language;

  
  //api den gelen decode edilmiş json u vericez burası onu country nesnesine dönüştürecek
  Country.fromJson(Map<String, dynamic> countryMap)
      : name = countryMap['name'],
        capital = countryMap['capital'],
        region = countryMap['region'],
        currency = countryMap['currency'],
        flag = countryMap['flag'],
        language = countryMap['language'];
  
}