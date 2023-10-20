import 'package:flutter/material.dart';
import 'package:yoo_katale/expert/expertprofile.dart';
import 'package:yoo_katale/expert/expertslist.dart';
import 'package:yoo_katale/screens/detect.dart';
import 'package:yoo_katale/test.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 100.0,
            flexibleSpace: FlexibleSpaceBar(
              //title: Text("AgriCare Expert AI\nEmpowering Smart Agriculture"),
              background: Image.asset(
                  height: 100, "assets/splash-screen1.png", fit: BoxFit.cover),
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                if (index == 0) {
                  return ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => ExpertsPage()));
                    },
                    child: Text("Expert profile"),
                  );
                }
                return null; // Return null for other items (or replace with your content).
              },
              childCount:
                  2, // Set childCount as the number of items, including the button.
            ),
          ),
          SliverGrid(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: _calculateCrossAxisCount(
                  context), // Responsive cross-axis count
            ),
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                IconData? icon;
                String? label;
                Color? iconColor;
                if (index == 0) {
                  icon = Icons.shopping_cart;
                  label = "Buy";
                  iconColor = Colors.green;
                } else if (index == 1) {
                  icon = Icons.search;
                  label = "DETECT";
                  iconColor = Colors.orange;
                } else if (index == 2) {
                  icon = Icons.contacts;
                  label = "EXPERT";
                  iconColor = Colors.orange;
                } else if (index == 3) {
                  icon = Icons.attach_money;
                  label = "SELL";
                  iconColor = Colors.green;
                }

                return _buildGridItem(icon!, label!, iconColor!, context);
              },
              childCount: 4,
            ),
          ),
          SliverToBoxAdapter(
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    children: [
                      // _buildGridSeparator(),
                      _buildDateGridleft("WED 3 APRIL 2024 LUWEERO 30°C",
                          Icons.wb_sunny, Colors.greenAccent,
                          height: _calculateDateGridHeight(
                              context)), // Responsive height
                    ],
                  ),
                ),
                SizedBox(
                    width: _calculateSpacing(context)), // Responsive spacing
                Expanded(
                  child: Column(
                    children: [
                      //_buildGridSeparator(),
                      _buildDateGrid(
                          "RAINY \n SEASON\n STARTS \n \nTHUR, 30 APRIL 2023",
                          null,
                          Color.fromARGB(255, 35, 80, 58),
                          height: _calculateDateGridHeight(context)),
                      // Responsive height
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Calculate the cross-axis count based on screen width
  int _calculateCrossAxisCount(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    if (width > 1200) {
      return 4;
    } else if (width > 800) {
      return 3;
    } else {
      return 2;
    }
  }

  // Calculate the height of date grids based on screen height
  double _calculateDateGridHeight(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return height * 0.2; // Adjust the factor as needed
  }

  // Calculate the spacing between the date grids based on screen width
  double _calculateSpacing(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return width * 0.02; // Adjust the factor as needed
  }

  Widget _buildGridItem(
      IconData icon, String label, Color iconColor, BuildContext context) {
    if (label == "DETECT") {
      return GestureDetector(
        onTap: () {
          // Navigate to the DETECT screen
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => DetectPage(),
          ));
        },
        child: Container(
          color: Colors.white,
          child: Center(
            child: CustomPaint(
              size: Size(100.0, 100.0),
              painter: LeafPainter(iconColor),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      icon,
                      size: 48.0,
                      color: iconColor,
                    ),
                    SizedBox(height: 16.0),
                    Text(
                      label,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      );
    } else if (label == "EXPERT") {
      return GestureDetector(
        onTap: () {
          // Navigate to the EXPERT screen
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => ExpertListPage(),
          ));
        },
        child: Container(
          color: Colors.white,
          child: Center(
            child: CustomPaint(
              size: Size(100.0, 100.0),
              painter: LeafPainter(iconColor),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      icon,
                      size: 48.0,
                      color: iconColor,
                    ),
                    SizedBox(height: 16.0),
                    Text(
                      label,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      );
    } else {
      return Container(
        color: Colors.white,
        child: Center(
          child: CustomPaint(
            size: Size(100.0, 100.0),
            painter: LeafPainter(iconColor),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    icon,
                    size: 48.0,
                    color: iconColor,
                  ),
                  SizedBox(height: 16.0),
                  Text(
                    label,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
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

  Widget _buildGridSeparator() {
    return Container(
      color: const Color.fromARGB(255, 55, 209, 135),
      height: 10.0,
    );
  }

  Widget _buildDateGrid(String text, IconData? icon, Color backgroundColor,
      {double height = 100.0}) {
    return ClipRRect(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(height / 2), // Half of the height for a circle
      ),
      child: Container(
        height: height,
        color: backgroundColor,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (icon != null)
              Icon(
                icon,
                color: Colors.white,
                size: 36.0,
              ),
            Center(
              child: Text(
                text,
                style: TextStyle(
                  color: const Color.fromARGB(255, 250, 249, 249),
                  fontSize: 18.0,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget _buildDateGridleft(String text, IconData? icon, Color backgroundColor,
    {double height = 100.0}) {
  return ClipRRect(
    borderRadius: BorderRadius.only(
      topRight: Radius.circular(height / 2), // Half of the height for a circle
    ),
    child: Container(
      height: height,
      color: backgroundColor,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            text,
            style: TextStyle(
              color: const Color.fromARGB(255, 250, 249, 249),
              fontSize: 18.0,
            ),
          ),
          if (icon != null)
            Icon(
              icon,
              color: Colors.white,
              size: 36.0,
            ),
        ],
      ),
    ),
  );
}

class LeafPainter extends CustomPainter {
  final Color pointColor;

  LeafPainter(this.pointColor);

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2;

    // Draw the leaf structure with white lines
    final paint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0;

    final path = Path();
    path.moveTo(center.dx, center.dy - radius);
    path.cubicTo(
      center.dx - radius / 2,
      center.dy - radius / 2,
      center.dx - radius / 2,
      center.dy + radius / 2,
      center.dx,
      center.dy + radius,
    );
    path.cubicTo(
      center.dx + radius / 2,
      center.dy + radius / 2,
      center.dx + radius / 2,
      center.dy - radius / 2,
      center.dx,
      center.dy - radius,
    );

    canvas.drawPath(path, paint);

    // Draw an orange point at the center
    paint.color = pointColor;
    paint.style = PaintingStyle.fill;
    canvas.drawCircle(center, 4.0, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
