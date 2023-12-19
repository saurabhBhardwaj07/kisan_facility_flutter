// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kisan_facility/cache/storage_shared_pref.dart';
import 'package:kisan_facility/screens/dashborad/dashborad.dart';
import 'package:kisan_facility/screens/dashborad/home/home_screen.dart';
import 'package:kisan_facility/screens/onboardiing/repositary/onboarding_repositary.dart';
import 'package:kisan_facility/state_provider/logged_user_stateprovider.dart';
import 'package:kisan_facility/utils/app_snackbar.dart';
import 'package:kisan_facility/utils/navigation_shortcut.dart';

final onBoardingControllerProvider =
    StateNotifierProvider<OnBoardingController, bool>((ref) =>
        OnBoardingController(
            onBoardingRepository: ref.watch(onBoardingRepositoryProvider),
            storageHelper: ref.watch(storageSharedPrefProvider),
            ref: ref));

class OnBoardingController extends StateNotifier<bool> {
  final Ref _ref;
  final OnBoardingRepository _onBoardingRepository;
  final StorageHelper _storageHelper;
  OnBoardingController(
      {required Ref ref,
      required OnBoardingRepository onBoardingRepository,
      required StorageHelper storageHelper})
      : _ref = ref,
        _onBoardingRepository = onBoardingRepository,
        _storageHelper = storageHelper,
        super(false);

  void userCreate(BuildContext context,
      {required String firstname,
      String? middlename,
      required String lastname,
      required String email,
      required String phone,
      required String password,
      required String passConfirm,
      File? file,
      required String gender,
      bool isUpdate = false}) async {
    state = true;
    final user = await _onBoardingRepository.createUserForApp(
        firstname: firstname,
        middlename: middlename,
        lastname: lastname,
        email: email,
        phone: phone,
        password: password,
        passConfirm: passConfirm,
        profile: file,
        gender: gender,
        isUpdate: isUpdate);

    state = false;
    user.fold((l) => showSnackBar(context, l.message), (user) {
      isUpdate == true
          ? null
          : StorageHelper.setStringIn(StorageKeys.token, user.token);
      StorageHelper.setLoggedUser(user);
      _ref.read(userProvider.notifier).update((state) => user);
      //?----------- Navigation-----------------
      isUpdate == true
          ? Navigator.pop(context)
          : AppNavigation.newScreen(
              context,
              DashBoardScreen(
                child: const HomeScreen(),
              ));
    });
  }

  void userLogin(BuildContext context,
      {String? email, String? password}) async {
    state = true;
    final user = await _onBoardingRepository.loginWithEmailPass(
        email: email, password: password);
    state = false;
    user.fold((l) => showSnackBar(context, l.message), (user) {
      StorageHelper.setStringIn(StorageKeys.token, user.token);
      StorageHelper.setLoggedUser(user);

      _ref.read(userProvider.notifier).update((state) => user);
      //?----------- Navigation-----------------
      AppNavigation.newScreen(
          context,
          DashBoardScreen(
            child: const HomeScreen(),
          ));
    });
  }

  void googleLogin(BuildContext context) async {
    state = true;
    final googleUser = await _onBoardingRepository.googleSignUp();
    state = false;
    googleUser.fold((l) => showSnackBar(context, l.message), (user) {
      StorageHelper.setStringIn(StorageKeys.token, user?.token);
      _ref.read(userProvider.notifier).update((state) => user);
      StorageHelper.setLoggedUser(user!);
      //?----------- Navigation-----------------
      AppNavigation.newScreen(
          context,
          DashBoardScreen(
            child: const HomeScreen(),
          ));
    });
  }

  void userLogOut(BuildContext context) async {
    final user = await _onBoardingRepository.logout();
    user.fold((l) => showSnackBar(context, l.message), (r) {
      StorageHelper.remove(StorageKeys.userData);
      StorageHelper.remove(StorageKeys.token);
    });
  }
}
