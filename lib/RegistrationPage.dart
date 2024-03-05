import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:soyle_io_app/VerificationPage.dart';


class RegistrationPage extends StatefulWidget {
  @override
  _RegistrationPageState createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  late String _selectedCountry; // Инициализация переменной

  List<String> _countries = [
    'Россия',
    'США',
    'Великобритания',
    'Германия',
    'Қазақстан',
    'Қырғызстан',
    // Добавьте свои страны
  ];

  late TextEditingController _emailController; // Контроллер для поля ввода email

  @override
  void initState() {
    super.initState();
    _selectedCountry = _countries.first; // Инициализация переменной значением по умолчанию
    _emailController = TextEditingController(); // Инициализация контроллера
  }

  @override
  void dispose() {
    _emailController.dispose(); // Освобождение ресурсов контроллера
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
              'Добро пожаловать!',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20),
            DropdownButtonFormField(
              value: _selectedCountry,
              items: _countries.map((country) {
                return DropdownMenuItem(
                  value: country,
                  child: Text(country),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  _selectedCountry = value.toString(); // Обновление выбранной страны
                });
              },
              decoration: InputDecoration(
                labelText: 'Выберите страну',
              ),
            ),
            SizedBox(height: 20),
            TextField(
              controller: _emailController, // Привязка контроллера к полю ввода
              decoration: InputDecoration(
                labelText: 'Введите email',
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                sendCodeToEmail(_emailController.text); // Вызываем функцию отправки кода на почту
              },
              child: Text('Отправить код'),
            ),
          ],
        ),
      ),
    );
  }

  // Функция отправки кода на почту
  void sendCodeToEmail(String email) async {
    final String apiUrl = 'https://d5dsstfjsletfcftjn3b.apigw.yandexcloud.net/login';
    final Map<String, dynamic> requestData = {
      'email': email, // Используем значение из поля ввода email
    };

    final response = await http.post(
      Uri.parse(apiUrl),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(requestData),
    );

    if (response.statusCode == 200) {
      // Запрос успешно выполнен
      print('Код успешно отправлен на почту.');
      // Переходим на страницу проверки кода
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => VerificationPage(email: email, correctCode: '',)),
      );
    } else {
      // Ошибка при выполнении запроса
      print('Ошибка отправки кода на почту: ${response.reasonPhrase}');
    }
  }
}
