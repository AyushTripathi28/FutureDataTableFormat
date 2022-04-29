import 'dart:convert';
import 'package:future_datatable/modalclass.dart';
import 'package:http/http.dart' as http;

class ApiManager {
  Future<List<Country>> fetchData() async {
    // geting response from API.
    var response =
        await http.get(Uri.parse("https://api.covid19api.com/summary"));
    // checking if Get request is successful by 200 status.
    if (response.statusCode == 200) {
      // decoding recieved string data into JSON data.
      var result = jsonDecode(response.body);
      // getting only Contries data from whole covid data which we convert into json.
      List jsonResponse = result["Countries"] as List;
      // return list by maping it with Country class.
      return jsonResponse.map((e) => Country.fromJson(e)).toList();
    } else {
      throw Exception(response.reasonPhrase);
    }
  }
}
