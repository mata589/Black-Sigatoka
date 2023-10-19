import 'package:flutter/material.dart';
//import 'package:yoo_katale/chat/view/search_screen.dart';
import 'package:yoo_katale/screens/newhomescreen.dart';
import 'package:yoo_katale/sign.dart';
import 'package:yoo_katale/widget_tree.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  PageController _pageController = PageController(initialPage: 0);
  int _currentPage = 0;

  void _goToNextPage() {
    if (_currentPage < 2) {
      _pageController.animateToPage(_currentPage + 1,
          duration: Duration(milliseconds: 300), curve: Curves.ease);
    } else if (_currentPage == 2) {
      // Navigate to the new widget tree with home: WidgetTree()
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => LoginPage()
              //UsersSearchScreen()
              ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        onPageChanged: (int page) {
          setState(() {
            _currentPage = page;
          });
        },
        children: <Widget>[
          _buildSplashScreen(
              Colors.white,
              "AgriCare Expert AI\nEmpowering Smart Agriculture",
              "assets/splash-screen1.png"),
          _buildSplashScreen(
              Colors.green,
              "Connect to experts\nLive meeting with our agriculture experts for your farm's support",
              "assets/splash-screen2.png"),
          _buildSplashScreenWithSkip(
              Colors.green,
              "AI TOOLS that enhance your farm's productivity",
              "assets/splash-screen3.png"),
        ],
      ),
      bottomNavigationBar: _currentPage == 1
          ? GestureDetector(
              onTap: _goToNextPage,
              child: Container(
                color: Colors.green,
                padding: EdgeInsets.all(20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Skip", style: TextStyle(color: Colors.white)),
                    Icon(Icons.arrow_forward, color: Colors.white),
                  ],
                ),
              ),
            )
          : null,
    );
  }

  Widget _buildSplashScreen(
      Color backgroundColor, String text, String imagePath) {
    return Container(
      color: backgroundColor,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(imagePath, height: 200),
          Text(
            text,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSplashScreenWithSkip(
      Color backgroundColor, String text, String imagePath) {
    return Container(
      color: backgroundColor,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(imagePath, height: 200),
          Text(
            text,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          GestureDetector(
            onTap: _goToNextPage,
            child: Container(
              margin: EdgeInsets.only(top: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Skip", style: TextStyle(color: Colors.white)),
                  Icon(Icons.arrow_forward, color: Colors.white),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
