// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'package:kisan_facility/core/constants/api_constant.dart';
import 'package:kisan_facility/core/failure.dart';
import 'package:kisan_facility/core/type_def/either_type_def.dart';
import 'package:kisan_facility/service/network/network_client.dart';
import 'package:kisan_facility/model/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase;

final FirebaseAuth auth = FirebaseAuth.instance;

final onBoardingRepositoryProvider = Provider((ref) =>
    OnBoardingRepository(networkClient: ref.watch(networkClientProvider)));

class OnBoardingRepository {
  final NetworkClient _networkClient;
  OnBoardingRepository({
    required NetworkClient networkClient,
  }) : _networkClient = networkClient;

  FutureEither<UserModel> loginWithEmailPass(
      {String? email, String? password}) async {
    try {
      final resp = await _networkClient.post(apiBaseUrl + loginEndPoint,
          body: {"email": email, "password": password});
      var user = UserModel.fromJson(resp.data);
      return right(user);
    } on DioError catch (err) {
      print(err.response?.data);
      return left(Failure(err.response?.data["message"]));
    } catch (err) {
      return left(Failure(err.toString()));
    }
  }

  FutureEither<UserModel> createUserForApp(
      {String? firstname,
      String? middlename,
      String? lastname,
      String? email,
      String? phone,
      String? password,
      String? passConfirm,
      String? gender,
      File? profile,
      bool isUpdate = false}) async {
    try {
      FormData data = FormData.fromMap({
        "first_name": firstname,
        "middle_name": middlename,
        "last_name": lastname,
        "email": email,
        "phone": phone,
        "password": password,
        "password_confirmation": passConfirm,
        "gender": gender,
      });

      if (profile != null) {
        String filename = profile.path.split("/").last;
        MapEntry<String, MultipartFile> profileImage = MapEntry(
          'file',
          await MultipartFile.fromFile(profile.path, filename: filename),
        );

        data.files.add(profileImage);
      }

      final resp = await _networkClient.post(
          apiBaseUrl + (isUpdate == true ? updateUserPoint : signUpPoint),
          body: data);
      print(data.files.map((e) => e));
      print(data.fields.map((e) => e));

      var user = UserModel.fromJson(resp.data);
      return right(user);
    } on DioError catch (err) {
      print(err.response?.data);
      return left(Failure(err.response?.data["message"]));
    } catch (err) {
      return left(Failure(err.toString()));
    }
  }

  FutureEither<UserModel?> googleSignUp() async {
    try {
      final GoogleSignInAccount? googleSignIn =
          await GoogleSignIn(scopes: <String>['email']).signIn();
      if (googleSignIn != null) {
        final GoogleSignInAuthentication googleSignInAuthentication =
            await googleSignIn.authentication;
        final AuthCredential authCredential = GoogleAuthProvider.credential(
            idToken: googleSignInAuthentication.idToken,
            accessToken: googleSignInAuthentication.accessToken);
        // Getting users credential
        UserCredential result = await auth.signInWithCredential(authCredential);
        firebase.User? googleUser = result.user;
        final resp =
            await _networkClient.post(apiBaseUrl + goWithGoogle, body: {
          "display_name": googleUser?.displayName ?? "",
          "email": googleUser?.email ?? "",
          "phone_no": googleUser?.phoneNumber ?? "",
          "profile_pic": googleUser?.photoURL,
          "google_id": googleUser?.providerData.first.uid
        });
        var user = UserModel.fromJson(resp.data);
        return right(user);
      }

      return right(null);
    } catch (err) {
      return left(Failure(err.toString()));
    }
  }

  FutureEither<Response> logout() async {
    try {
      final resp = await _networkClient.post(apiBaseUrl + logoutEndPoint);
      return left(resp.data);
    } on DioError catch (err) {
      print(err.response?.data);
      return left(Failure(err.response?.data["message"]));
    } catch (err) {
      return left(Failure(err.toString()));
    }
  }
}
