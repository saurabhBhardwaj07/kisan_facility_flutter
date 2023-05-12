import 'package:flutter_riverpod/flutter_riverpod.dart';

final apiLoadingProvider = StateNotifierProvider<AppLoaderState, bool>((ref) {
  return AppLoaderState();
});

class AppLoaderState extends StateNotifier<bool> {
  AppLoaderState() : super(false);
  void changeState(bool value) {
    state = value;
  }
}
