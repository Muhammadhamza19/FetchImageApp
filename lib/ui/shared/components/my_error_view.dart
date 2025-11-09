import 'package:image_app/support/config/app_color.dart';
import 'package:image_app/support/config/app_theme.dart';
import 'package:image_app/ui/shared/inputs/my_button.dart';
import 'package:image_app/ui/shared/inputs/my_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

typedef Refresh = Function();

class MyErrorView extends StatelessWidget {
  final String _errorMsg;
  final Refresh? refreshFunction;

  const MyErrorView(
    this._errorMsg, {
    super.key,
    this.refreshFunction,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: Get.height * 0.5,
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              MyText(
                _errorMsg,
                style: textStyle(
                    color: disabledTextColor,
                    fontSize: 16.0,
                    fontWeight: FontWeight.w600),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16.0),
              refreshFunction != null
                  ? MyButton(
                      text: "Refresh",
                      onPressed: refreshFunction,
                    )
                  : Container(),
            ],
          ),
        ),
      ),
    );
  }
}
