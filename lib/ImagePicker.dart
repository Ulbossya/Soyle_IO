import 'package:flutter/material.dart';
import 'package:soyle_io_app/QuestionPage.dart';

class ImagePickerPage extends StatefulWidget {
  @override
  _ImagePickerPageState createState() => _ImagePickerPageState();
}

class _ImagePickerPageState extends State<ImagePickerPage> {
  String? selectedImagePath;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Выберите аватар'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    selectedImagePath = 'assets/img/boyavatar.png';
                  });
                  // Navigate to AnotherPage immediately after selecting the avatar
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AnotherPage(),
                    ),
                  );
                },
                child: Center(
                  child: Image.asset(
                    'assets/img/boyavatar.png', // Путь к первому изображению
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    selectedImagePath = 'assets/img/girlavatar.png';
                  });
                  // Navigate to AnotherPage immediately after selecting the avatar
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AnotherPage(),
                    ),
                  );
                },
                child: Center(
                  child: Image.asset(
                    'assets/img/girlavatar.png', // Путь ко второму изображению
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.gamepad),
            label: 'Game',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
        currentIndex: 0,
        selectedItemColor: Colors.blue,
        onTap: (index) {
          // Handle navigation for other tabs
        },
      ),
    );
  }
}
