import 'dart:convert';

import 'package:either_dart/either.dart';
import 'package:quraan/core/constant/enum.dart';
import 'package:quraan/core/functions/checkinternet.dart';
import 'package:http/http.dart' as http;

class Crud {
  Future<Either<StatusRequest, List>> getRequest(url) async {
    try {
        var responce = await http.get(Uri.parse(url));
      if (await checkInternet()) {
        if (responce.statusCode == 200 || responce.statusCode == 201) {
          var responcebody = await jsonDecode(responce.body);
          
          return Right(responcebody);
        } else {
          return Left(StatusRequest.failure);
        }
      } else {
        return const Left(StatusRequest.offline);
      }
    } catch (e) {
      // print(responce)
      print(e);
      return const Left(StatusRequest.serverFailure);
    }
  }
}
