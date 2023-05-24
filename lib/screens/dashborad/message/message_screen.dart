import 'package:dialog_flowtter/dialog_flowtter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kisan_facility/components/app_logo_widget.dart';
import 'package:kisan_facility/components/custom_textfrom_field.dart';
import 'package:kisan_facility/components/dashboard_header.dart';
import 'package:kisan_facility/components/layout.dart';
import 'package:kisan_facility/screens/dashborad/message/chat_screen.dart';
import 'package:kisan_facility/state_provider/message_chartbot_provider.dart';

class MessageScreen extends ConsumerStatefulWidget {
  const MessageScreen({super.key});

  @override
  _MessageScreenState createState() => _MessageScreenState();
}

class _MessageScreenState extends ConsumerState<MessageScreen> {
  late DialogFlowtter dialogFlowtter;

  final TextEditingController _controller = TextEditingController();

  List<Map<String, dynamic>> messages = [];

  @override
  void initState() {
    DialogFlowtter.fromFile().then((instance) => dialogFlowtter = instance);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final chatMessage = ref.watch(messageChartProvider);
    return Layout(
        showAsset: false,
        child: Column(
          children: [
            const DashboardHeader(
              centerText: 'Message',
            ),
            chatMessage.isEmpty
                ? Expanded(
                    child: Column(
                      children: const [
                        AppLogoWidget(),
                        Text(
                          "Type Hello & Start Your \n Conversation so We Can Help You There!",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontWeight: FontWeight.w500, fontSize: 20),
                        )
                      ],
                    ),
                  )
                : Expanded(
                    child: ChatScreen(
                    messages: chatMessage,
                  )),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
              child: Row(
                children: [
                  Expanded(
                    child: CustomTextronField(
                      inputController: _controller,
                      hideValidator: true,
                      labelText: "Q/A",
                      hintText: "Type Here Your Query",
                    ),
                  ),
                  IconButton(
                      onPressed: () {
                        sendMessage(_controller.text, ref);
                        _controller.clear();
                      },
                      icon: const Icon(Icons.send))
                ],
              ),
            ),
            const SizedBox(
              height: 80,
            )
          ],
        ));
  }

  sendMessage(String text, WidgetRef ref) async {
    if (text.isEmpty) {
      print('Message is empty');
    } else {
      setState(() {
        addMessage(Message(text: DialogText(text: [text])), ref, true);
      });

      DetectIntentResponse response = await dialogFlowtter.detectIntent(
          queryInput: QueryInput(text: TextInput(text: text)));
      if (response.message == null) return;
      setState(() {
        addMessage(response.message!, ref);
      });
    }
  }

  addMessage(Message message, WidgetRef ref, [bool isUserMessage = false]) {
    ref.read(messageChartProvider.notifier).addMessage(message, isUserMessage);
    // messages.add({'message': message, 'isUserMessage': isUserMessage});
  }
}
