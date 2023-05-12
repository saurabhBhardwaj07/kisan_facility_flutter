import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kisan_facility/model/product_list_response.dart';

final productListProvider =
    FutureProvider<List<ProductListResponse>>((ref) async {
  List<ProductListResponse> productList = [];
  var res = await rootBundle.loadString("lib/json/product_list.json");
  var data = await json.decode(res) as List;
  productList.addAll(data.map((e) => ProductListResponse.fromJson(e)));

  return productList;
});
