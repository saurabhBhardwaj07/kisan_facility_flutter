import 'package:flutter/material.dart';
import 'package:kisan_facility/utils/app_colors.dart';

typedef StringTypeCallBack = Function(String type);

mixin SelectableSheetMixin {
  static void showTypeForSelect(
      StringTypeCallBack callBack, BuildContext context, List<String> type) {
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        isDismissible: false,
        backgroundColor: AppColors.mistyRose,
        builder: (context) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 16.0),
            child: Column(
                mainAxisSize: MainAxisSize.min,
                children: type
                    .map(
                      (e) => ListTile(
                        title: Text(
                          e,
                        ),
                        onTap: () {
                          callBack.call(e);
                          Navigator.pop(context);
                        },
                      ),
                    )
                    .toList()),
          );
        });
  }
}
