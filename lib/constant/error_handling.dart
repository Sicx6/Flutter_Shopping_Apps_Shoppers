import 'dart:convert';
import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:flutter_shopping_apps/constant/utils.dart';
import 'package:http/http.dart' as http;

void httpErrorHandle(
    {required http.Response response,
    required BuildContext context,
    required VoidCallback onSuccess}) {
  switch (response.statusCode) {
    case 200:
      onSuccess();
      break;
    case 400:
      showSnackBar(context, jsonDecode(response.body)['msg']);
      break;
    case 500:
      showSnackBar(context, jsonDecode(response.body)['msg']);
      break;
    default:
      showSnackBar(context, response.body);
  }
}
