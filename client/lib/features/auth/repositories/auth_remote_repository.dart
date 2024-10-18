import 'dart:convert';

import 'package:fpdart/fpdart.dart';
import 'package:http/http.dart' as http;

import '../../../core/failure/failure.dart';
import '../models/user_model.dart';

class AuthRemoteRepository {
  Future<Either<AppFailure, UserModel>> signup({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      final response = await http.post(
        Uri.parse(
          // 10.0.2.2 is an AVD alias to localhost
          "http://10.0.2.2:8000/auth/signup",
        ),
        headers: {
          'Content-type': 'application/json',
        },
        body: jsonEncode(
          {
            'name': name,
            'email': email,
            'password': password,
          },
        ),
      );

      final resBodyMap = jsonDecode(response.body) as Map<String, dynamic>;

      if (response.statusCode != 201) {
        return Left(AppFailure(resBodyMap['detail']));
      }

      return Right(UserModel.fromMap(resBodyMap));
    } catch (err) {
      return Left(AppFailure(err.toString()));
    }
  }

  Future<void> login({
    required String email,
    required String password,
  }) async {
    try {
      final response = await http.post(
        Uri.parse("http://10.0.2.2:8000/auth/login"),
        headers: {
          'Content-type': 'application/json',
        },
        body: jsonEncode(
          {
            'email': email,
            'password': password,
          },
        ),
      );

      print(response.body);
      print(response.statusCode);
    } catch (err) {
      print(err);
    }
  }
}
