import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:ecommerce_bloc/core/error/exceptions.dart';

abstract interface class AuthRemoteDataSource {
  Future<String> signUpWithEmailPassword({
    required String name,
    required String email,
    required String password,
  });

  Future<String> signInWithEmailPassword({
    required String email,
    required String password,
  });
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  AuthRemoteDataSourceImpl({required this.client});

  final Dio client;

  @override
  Future<String> signInWithEmailPassword(
      {required String email, required String password}) async {
    try {
      final response = await client.post('/auth/login', data: {
        'email': email,
        'password': password,
      });

      if (response.statusCode != 201) {
        throw const ServerException('Something went wrong');
      }

      return response.data;
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<String> signUpWithEmailPassword({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      log('HEREE');
      final response = await client.post('/auth/register', data: {
        'name': name,
        'email': email,
        'password': password,
      });

      return response.data;
    } catch (e) {
      if (e is DioException) {
        log('DioError: ${e.message}');
        throw ServerException(e.response!.data['message']);
      } else {
        log('Unexpected error: ${e.toString()}');
        throw const ServerException('An unexpected error occurred');
      }
    }
  }
}
