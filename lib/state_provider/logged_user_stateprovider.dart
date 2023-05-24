import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kisan_facility/model/logged_user.dart';
import 'package:kisan_facility/model/user_model.dart';

final loggedUserState = StateNotifierProvider<LoggedUserState, LoggedUser?>(
    (ref) => LoggedUserState(null));

final userProvider = StateProvider<UserModel?>((ref) => null);

class LoggedUserState extends StateNotifier<LoggedUser?> {
  LoggedUserState(super.state);
  void updateUser(LoggedUser user) {
    state = user;
  }
}
