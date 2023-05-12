import 'package:dialog_flowtter/dialog_flowtter.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final messageChartProvider =
    StateNotifierProvider<MessageChartState, List<Map<String, dynamic>>>((ref) {
  return MessageChartState();
});

class MessageChartState extends StateNotifier<List<Map<String, dynamic>>> {
  MessageChartState() : super([]);

  void addMessage(Message message, [bool isUserMessage = false]) {
    state.add({'message': message, 'isUserMessage': isUserMessage});
  }
}
