import 'package:flutter/material.dart';
import 'package:soyle_io_app/ImagePicker.dart';

class VerificationPage extends StatefulWidget {
  final String email;
  final String correctCode;

  VerificationPage({required this.email, required this.correctCode});

  @override
  _VerificationPageState createState() => _VerificationPageState();
}

class _VerificationPageState extends State<VerificationPage> {
  late TextEditingController _codeController;

  @override
  void initState() {
    super.initState();
    _codeController = TextEditingController();
  }

  @override
  void dispose() {
    _codeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
    
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Введите код, отправленный на ${widget.email}',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 20),
            TextField(
              controller: _codeController,
              decoration: InputDecoration(labelText: 'Введите код'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                _verifyCode(_codeController.text);
              },
              child: Text('Проверить код'),
            ),
          ],
        ),
      ),
    );
  }

  void _verifyCode(String code) {
    // Убираем проверку на совпадение кодов
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => ImagePickerPage()),
    );
  }
}

