import 'dart:convert';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:BIXI/common/colors.dart';
import 'package:BIXI/models/listdata_model.dart';
import 'package:BIXI/models/news_model.dart';
import 'package:BIXI/services/Api.dart';

class NewsProvider {
  Future<ListData> GetEverything(String keyword, int page) async {
    ListData articles = ListData([], 0, false);
    await ApiService().getEverything(keyword, page).then((response) {
      if (response.status=='ok'){

       if (response.statusCode == 200) {
        Iterable data = jsonDecode(response.body)['articles'];
        articles = ListData(
          data.map((e) => News.fromJson(e)).toList(),
          jsonDecode(response.body)['totalResults'],
          true,
        );
      } else {
        Fluttertoast.showToast(
          msg: jsonDecode(response.body)['message'],
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: AppColors.lighterGray,
          textColor: AppColors.black,
          fontSize: 16.0,
        );
        throw Exception(response.statusCode);
      }


      }
       
    });
    return articles;
  }
}
