// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter_shopping_apps/common/widgets/bottom_bar.dart';
import 'package:flutter_shopping_apps/constant/error_handling.dart';
import 'package:flutter_shopping_apps/constant/global_var.dart';
import 'package:flutter_shopping_apps/constant/utils.dart';
import 'package:flutter_shopping_apps/features/home/screens/home_screen.dart';
import 'package:flutter_shopping_apps/models/user.dart';
import 'package:flutter_shopping_apps/provider/user_provider.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  // sign up user
  void signUpUser({
    required BuildContext context,
    required String email,
    required String password,
    required String name,
  }) async {
    try {
      User user = User(
        id: '',
        name: name,
        password: password,
        email: email,
        address: '',
        type: '',
        token: '',
        cart: [],
      );

      http.Response res = await http.post(
        Uri.parse('$uri/api/signup'),
        body: user.toJson(),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );

      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () {
          showSnackBar(
            context,
            'Account created! Login with the same credentials!',
          );
        },
      );
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  void signInUser({
    required BuildContext context,
    required String email,
    required String password,
  }) async {
    try {
      http.Response res = await http.post(Uri.parse('$uri/api/signin'),
          body: jsonEncode({
            'email': email,
            'password': password,
          }),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          });

      print(res.body);

      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () async {
          SharedPreferences prefs = await SharedPreferences.getInstance();
          Provider.of<UserProvider>(context, listen: false).setUser(res.body);

          var responseBody = jsonDecode(res.body);

          if (responseBody.containsKey('token')) {
            await prefs.setString('x-auth-token', responseBody['token']);
          }

          Navigator.pushNamedAndRemoveUntil(
            context,
            BottomBar.routeName,
            (route) => false,
          );
        },
      );
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  // void getUserData(
  //   BuildContext context,
  // ) async {
  //   try {
  //     SharedPreferences prefs = await SharedPreferences.getInstance();
  //     String? token = prefs.getString('x-auth-token');
  //     if (token != null) {
  //       var tokenRes = await http.post(Uri.parse('$uri/tokenIsValid'),
  //           headers: <String, String>{
  //             'Content-Type': 'application/json; charset=UTF-8',
  //             'x-auth-token': token
  //           });
  //       var response = jsonDecode(tokenRes.body);
  //       if (response == true) {
  //         http.Response userRes = await http.get(Uri.parse('$uri/'),
  //             headers: <String, String>{
  //               'Content-Type': 'application/json; charset=UTF-8',
  //               'x-auth-token': token
  //             });
  //         var userProvider = Provider.of<UserProvider>(context, listen: false);
  //         userProvider.setUser(userRes.body);
  //       }
  //     }
  //   } catch (e) {
  //     //  debugPrint(e.toString());
  //     showSnackBar(context, e.toString());
  //   }
  // }

  void getuserdata(
    BuildContext context,
  ) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('x-auth-token');
      if (token != null) {
        var tokenRes = await http.post(Uri.parse('$uri/tokenIsValid'),
            headers: <String, String>{
              'Content-Type': 'application/json; charset=UTF-8',
              'x-auth-token': token
            });
        var response = jsonDecode(tokenRes.body);
        if (response == true) {
          http.Response userRes = await http.get(Uri.parse('$uri/'),
              headers: <String, String>{
                'Content-Type': 'application/json; charset=UTF-8',
                'x-auth-token': token
              });
          var userProvider = Provider.of<UserProvider>(context, listen: false);
          userProvider.setUser(userRes.body);
        }
      }
    } catch (e) {
      //  debugPrint(e.toString());
      showSnackBar(context, e.toString());
    }
  }
}
