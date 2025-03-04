import 'package:flutter/material.dart';

class QrCodeScreen extends StatelessWidget {
  const QrCodeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Номер карты', style: TextStyle(fontSize: 20)),
        leadingWidth: 100,
        leading: Center(
          child: TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('Закрыть'),
          ),
        ),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            RichText(
              text: const TextSpan(
                text: 'THE',
                style: TextStyle(
                  letterSpacing: 14,
                  height: 0,
                  fontSize: 55,
                  fontWeight: FontWeight.w100,
                ),
                children: <TextSpan>[
                  TextSpan(
                    text: 'FLEX',
                    style: TextStyle(
                      letterSpacing: 14,
                      height: 0,
                      fontSize: 55,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 150),
            Image.asset('assets/icons/qrcode.jpg', height: 80),
            SizedBox(height: 18),
            Column(
              children: [
                Text("025784", style: TextStyle(fontSize: 18)),
                SizedBox(height: 3),
                Text(
                  "Губин Евгений Александрович",
                  style: TextStyle(fontSize: 18),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
