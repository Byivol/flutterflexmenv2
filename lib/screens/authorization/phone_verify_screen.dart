import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:theflexmen/screens/main/mainscr.dart';

class PhoneVerifyScreen extends StatefulWidget {
  final String verificationId;
  const PhoneVerifyScreen({super.key, required this.verificationId});

  @override
  State<PhoneVerifyScreen> createState() => _PhoneVerifyScreenState();
}

class _PhoneVerifyScreenState extends State<PhoneVerifyScreen> {
  TextEditingController textEditingController = TextEditingController();
  final _focusNode = FocusNode();

  late StreamController<ErrorAnimationType> errorController;
  late final bool isDarkMode;
  late Timer _timer;
  int _start = 5;
  bool _isButtonDisabled = false;

  @override
  void initState() {
    errorController = StreamController<ErrorAnimationType>();
    super.initState();
    _startTimer();
  }

  @override
  void didChangeDependencies() {
    isDarkMode = Theme.of(context).brightness == Brightness.dark;
    super.didChangeDependencies();
  }

  void _startTimer() {
    _isButtonDisabled = true;
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (_start == 0) {
        setState(() {
          _timer.cancel();
          _isButtonDisabled = false;
        });
      } else {
        setState(() {
          _start--;
        });
      }
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    errorController.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
      body: Center(
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
              focusNode: _focusNode,
              mainAxisAlignment: MainAxisAlignment.center,
              pinTheme: PinTheme(
                activeFillColor: Colors.transparent,
                shape: PinCodeFieldShape.box,
                fieldOuterPadding: EdgeInsets.symmetric(horizontal: 8),
                borderRadius: BorderRadius.circular(15),
                fieldHeight: 68,
                fieldWidth: 48,
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
              length: 6,
              obscureText: false,
              animationType: AnimationType.fade,
              backgroundColor: Colors.transparent,
              enableActiveFill: true,
              errorAnimationController: errorController,
              controller: textEditingController,
              onCompleted: (v) async {
                try {
                  final cred = PhoneAuthProvider.credential(
                    verificationId: widget.verificationId,
                    smsCode: textEditingController.text,
                  );
                  FirebaseAuth auth = FirebaseAuth.instance;
                  await auth.setSettings(
                    appVerificationDisabledForTesting: true,
                  );
                  await auth.signInWithCredential(cred);

                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const HomeScreen()),
                  );
                } catch (e) {}
              },
              onChanged: (s) {},
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                  onPressed:
                      _isButtonDisabled
                          ? null
                          : () {
                            setState(() {
                              _start = 5;
                              _startTimer();
                            });
                          },
                  child: Text(
                    "Send code again",
                    style: TextStyle(
                      color: _isButtonDisabled ? Colors.grey : Colors.green,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 1),
                  child: Text(
                    "00:${_start.toString().padLeft(2, '0')}",
                    style: TextStyle(fontSize: 14, color: Colors.grey),
                  ),
                ),
              ],
            ),
            SizedBox(height: 200),
          ],
        ),
      ),
    );
  }
}
