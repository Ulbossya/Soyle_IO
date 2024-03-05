import 'package:flutter/material.dart';
import 'RegistrationPage.dart';

class SliderPage extends StatefulWidget {
  @override
  _SliderPageState createState() => _SliderPageState();
}

class _SliderPageState extends State<SliderPage> {
  int _currentPage = 0;
  final PageController _pageController = PageController();

  List<String> _slideTexts = [
    'Добро пожаловать в мир увлекательного обучения и веселых игр!',
    'Приключения слова! Погрузись в увлекательное путешествие по миру слов!',
    'Наше приложение предлагает разнообразные игры, способствующие развитию речи, логики и внимания.',
    'Весело и познавательно! Подари своему ребенку яркие моменты учебы и развлечения!',
  ];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView(
            controller: _pageController,
            onPageChanged: (int page) {
              setState(() {
                _currentPage = page;
              });
            },
            children: [
              _buildImage('assets/img/first.png', _slideTexts[0]),
              _buildImage('assets/img/second.png', _slideTexts[1]),
              _buildImage('assets/img/third.png', _slideTexts[2]),
              _buildImage('assets/img/fourth.png', _slideTexts[3]),
              // Добавьте пути к вашим изображениям и соответствующие тексты
            ],
          ),
          Positioned(
            top: 30,
            left: 10,
            child: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                if (_currentPage > 0) {
                  _pageController.previousPage(
                    duration: Duration(milliseconds: 500),
                    curve: Curves.easeInOut,
                  );
                }
              },
            ),
          ),
          Positioned(
            top: 43,
            right: 20,
            child: InkWell(
              onTap: () {
                if (_currentPage < 3) {
                  // Проверяем, что не последний слайд
                  _pageController.nextPage(
                    duration: Duration(milliseconds: 500),
                    curve: Curves.easeInOut,
                  );
                } else {
                  // Переход на страницу регистрации
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => RegistrationPage()),
                  );
                }
              },
              child: Text(
                'Skip',
                style: TextStyle(
                  color: Colors.black, // Изменяем цвет текста на черный
                  fontSize: 17,
                ),
              ),
            ),
          ),
          Positioned(
            top: MediaQuery.of(context).size.height *
                0.79, // Устанавливаем отступ снизу
            left: 35,
            right: 10,
            child: Center(
              child: Text(
                _slideTexts[_currentPage],
                textAlign: TextAlign.center, // Выравнивание текста по центру
                style: TextStyle(
                  fontSize: 18,
                  fontFamily: 'Benzin',
                  color: Color(0xFF5A6275), // Цвет текста
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 20,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                4, // Замените на количество ваших слайдов
                (index) => _buildDot(index),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildImage(String imagePath, String text) {
    return GestureDetector(
      onTap: () {
        _pageController.nextPage(
          duration: Duration(milliseconds: 500),
          curve: Curves.easeInOut,
        );
      },
      child: Center(
        child: Image.asset(
          imagePath,
          fit: BoxFit.contain,
          width: MediaQuery.of(context).size.width * 0.6,
          height: MediaQuery.of(context).size.height * 0.6,
        ),
      ),
    );
  }

  Widget _buildDot(int index) {
    Color dotColor =
        _currentPage == index ? Color(0xFF5A6275) : Color(0xFFD9D9D9);
    return Container(
      width: 40,
      height: 9,
      margin: EdgeInsets.symmetric(horizontal: 5),
      decoration: BoxDecoration(
        color: dotColor,
        borderRadius: BorderRadius.circular(5),
      ),
    );
  }
}
