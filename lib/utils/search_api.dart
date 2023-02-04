import 'dart:convert';

import 'package:http/http.dart' as http;import '../constants/app_costants.dart';


import '../models/main_response.dart';
import '../models/order_histrory_model.dart';
import '../models/suggestion_model.dart';



class SearchApi {
  static Future<List<String>> getSearchSuggestions(String query,customerId,selectedCriteria)  async {
    Uri url = Uri.parse('https://proactii.com/MultiVendor/api/MultivendorApi/getSuggestionFromKeyword');

    print("url  =======> ${url.toString()}");
    // final
    // final response = await http.get(url);

    var response =
    await http.post(url, body: {
      'secretkey': AppConstants.secretKey,
      'keyword': query,
      'cat_short_code': selectedCriteria,
    });


    // if (response.statusCode == 200) {
      var  result = json.decode(response.body);

      MainResponse mainResponse;
      mainResponse = (MainResponse.fromJson(result));

      List<String>? suggestionListData = [];
      if(mainResponse.data != null){
        mainResponse.data!.forEach((v) {
          suggestionListData.add(v);
        });

      }



      return Future.value(suggestionListData);


    // } else {
    //   throw Exception();
    // }
  }
}