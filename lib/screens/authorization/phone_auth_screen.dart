import 'package:flutter/material.dart';
import 'package:flutter_libphonenumber/flutter_libphonenumber.dart';
import 'package:theflexmen/screens/authorization/phone_verify_screen.dart';

class PhoneAuthScreen extends StatefulWidget {
  const PhoneAuthScreen({super.key});

  @override
  PhoneAuthScreenState createState() => PhoneAuthScreenState();
}

class PhoneAuthScreenState extends State<PhoneAuthScreen> {
  final _formKey = GlobalKey<FormState>();
  final _manualFormatController = TextEditingController();
  String? _errorText;
  String? _verificationId;
  late final bool isDarkMode;
  late final String logoPath;
  void _validateAndSubmit() {
    setState(() {
      _errorText = null;
    });

    if (_formKey.currentState!.validate()) {
      print("Отправка номера: ${_manualFormatController.text}");
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    isDarkMode = Theme.of(context).brightness == Brightness.dark;
    logoPath =
        isDarkMode ? "assets/icons/logo_white.png" : "assets/icons/logo.png";
    precacheImage(AssetImage(logoPath), context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: SizedBox(
          height: MediaQuery.of(context).size.height + 1,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(logoPath, width: 300),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 26, bottom: 20),
                    child: Text(
                      'SIGN IN',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                Form(
                  key: _formKey,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextFormField(
                          keyboardType: TextInputType.phone,
                          inputFormatters: [
                            LibPhonenumberTextFormatter(
                              phoneNumberType: PhoneNumberType.mobile,
                              phoneNumberFormat: PhoneNumberFormat.national,
                              country: CountryWithPhoneCode(
                                phoneCode: '7',
                                countryCode: 'RU',
                                exampleNumberMobileNational:
                                    '+7 (900) 123-45-67',
                                exampleNumberFixedLineNational:
                                    '+7 (495) 123-45-67',
                                phoneMaskMobileNational: '+0 (000) 000-00-00',
                                phoneMaskFixedLineNational:
                                    '+0 (000) 000-00-00',
                                exampleNumberMobileInternational:
                                    '+7 900 123-45-67',
                                exampleNumberFixedLineInternational:
                                    '+7 495 123-45-67',
                                phoneMaskMobileInternational:
                                    '+0 000 000-00-00',
                                phoneMaskFixedLineInternational:
                                    '+0 000 000-00-00',
                                countryName: 'Russia',
                              ),
                              inputContainsCountryCode: true,
                              shouldKeepCursorAtEndOfInput: true,
                              additionalDigits: 0,
                            ),
                          ],
                          controller: _manualFormatController,
                          decoration: InputDecoration(
                            labelText: 'Phone number',
                            border: OutlineInputBorder(),
                          ),
                          maxLength: 18,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Enter phone number";
                            }
                            if (!RegExp(
                              r'^\+7 \(\d{3}\) \d{3}-\d{2}-\d{2}$',
                            ).hasMatch(value)) {
                              return "Incorrect phone number";
                            }
                            return null;
                          },
                        ),
                        if (_errorText != null)
                          Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: Text(
                              _errorText!,
                              style: TextStyle(color: Colors.red, fontSize: 14),
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: SizedBox(
                    height: 48,
                    width: double.infinity,
                    child: FilledButton(
                      onPressed: () {
                        _validateAndSubmit();
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder:
                                (context) => PhoneVerifyScreen(
                                  verificationId: _verificationId ?? "",
                                ),
                          ),
                        );
                      },
                      child: Text("SEND"),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
