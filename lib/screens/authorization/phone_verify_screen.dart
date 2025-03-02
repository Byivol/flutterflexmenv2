import 'dart:async';

import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class PhoneVerifyScreen extends StatefulWidget {
  final String verificationId;
  const PhoneVerifyScreen({super.key, required this.verificationId});

  @override
  State<PhoneVerifyScreen> createState() => _PhoneVerifyScreenState();
}

class _PhoneVerifyScreenState extends State<PhoneVerifyScreen> {
  TextEditingController textEditingController = TextEditingController();
  late StreamController<ErrorAnimationType> errorController;

  late final bool isDarkMode;
  @override
  void initState() {
    errorController = StreamController<ErrorAnimationType>();
    super.initState();
  }

  @override
  void didChangeDependencies() {
    print(Theme.of(context).brightness);
    isDarkMode = Theme.of(context).brightness == Brightness.dark;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    print(isDarkMode);
    Color activeBorderColor = isDarkMode ? Colors.white : Colors.black;
    Color inactiveBorderColor = isDarkMode ? Colors.white : Colors.black;
    Color fillColor = isDarkMode ? Colors.white : Colors.black;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Container(
          height: MediaQuery.of(context).size.height - kToolbarHeight + 1,
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Enter code"),
                SizedBox(height: 10),
                Text(
                  "We have sent a text message to your phone number.",
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.w300),
                ),
                SizedBox(height: 20),
                PinCodeTextField(
                  mainAxisAlignment: MainAxisAlignment.center,
                  pinTheme: PinTheme(
                    activeFillColor: Colors.transparent,
                    shape: PinCodeFieldShape.box,
                    fieldOuterPadding: EdgeInsets.symmetric(horizontal: 12),
                    borderRadius: BorderRadius.circular(15),
                    fieldHeight: 78,
                    fieldWidth: 58,
                    borderWidth: 1,
                    errorBorderWidth: 1,
                    activeBorderWidth: 1,
                    disabledBorderWidth: 1,
                    selectedBorderWidth: 1,
                    inactiveBorderWidth: 1,
                    inactiveFillColor: Colors.transparent,
                    selectedFillColor: Colors.transparent,
                    activeColor: activeBorderColor,
                    inactiveColor: inactiveBorderColor,
                    selectedColor: fillColor,
                    errorBorderColor: Colors.red,
                  ),
                  appContext: context,
                  length: 4,
                  obscureText: false,
                  animationType: AnimationType.fade,
                  backgroundColor: Colors.transparent,
                  enableActiveFill: true,
                  errorAnimationController: errorController,
                  controller: textEditingController,
                  onCompleted: (v) {
                    print("Completed");
                  },
                  onChanged: (s) {},
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextButton(
                      onPressed: () {},
                      child: Text(
                        "Send code again",
                        style: TextStyle(color: Colors.green),
                      ),
                    ),
                    Text(
                      "00:20",
                      style: TextStyle(fontSize: 14, color: Colors.grey),
                    ),
                  ],
                ),
                SizedBox(height: 200),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
