import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:yoo_katale/auth/sign.dart';
import 'package:yoo_katale/expert/expertprofile.dart';
import 'package:yoo_katale/expert/expertslist.dart';
import 'package:yoo_katale/screens/detect.dart';
import 'package:yoo_katale/test.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
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

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text('My App'),
      //   leading: Builder(
      //     builder: (BuildContext context) {
      //       return IconButton(
      //         icon: Icon(Icons.menu),
      //         onPressed: () {
      //           Scaffold.of(context).openDrawer();
      //         },
      //       );
      //     },
      //   ),
      // ),
      body: Padding(
        padding: EdgeInsets.only(top: 20.0),
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
      expandedHeight: 130.0,
      flexibleSpace: FlexibleSpaceBar(
        background: Stack(
      children: [
        Positioned.fill(
          child: Image.asset(
            "assets/splash-screen1.png",
            fit: BoxFit.cover,
          ),
        ),
        Positioned(
          right: 4.0, // Adjust the right position as needed
          top: 16.0, // Adjust the top position as needed
          child: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: Icon(Icons.menu,color: Colors.orange),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
            );
          },
        ),
        ),
        ],
          ),
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
                    label = "EXPERTS";
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
            //SizedBox(height: 20.0),
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
      ),
      drawer: DrawerWidget(),
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
           decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(
            color: const Color.fromARGB(255, 196, 193, 193), // Set the border color to red
            width: 2.0, // Set the border width as needed
          ),
        ),
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
    } else if (label == "EXPERTS") {
      return GestureDetector(
        onTap: () {
          
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => ExpertListPage(),
          ));
        },
        child: Container(
         decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(
            color: const Color.fromARGB(255, 196, 193, 193), // Set the border color to red
            width: 2.0, // Set the border width as needed
          ),
        ),
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
      return ClipRRect(
          borderRadius: BorderRadius.only(
        topLeft: Radius.circular(10.0), // Adjust the radius for the top-left corner
        topRight: Radius.circular(50.0), // Adjust the radius for the top-right corner
        bottomLeft: Radius.circular(100.0), // Adjust the radius for the bottom-left corner
        bottomRight: Radius.circular(100.0), // Adjust the radius for the bottom-right corner
      ),
        child: Container(
          decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(
            color: const Color.fromARGB(255, 196, 193, 193), // Set the border color to red
            width: 2.0, // Set the border width as needed
          ),
        ),
         // color: Colors.white,
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
                    SizedBox(height: 10.0),
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
class DrawerWidget extends StatefulWidget {
  //final FirebaseAuth auth;
  

  

  @override
  _DrawerWidgetState createState() => _DrawerWidgetState();
}

class _DrawerWidgetState extends State<DrawerWidget> {
 
  final FirebaseAuth auth = FirebaseAuth.instance;

  @override
  void initState() {
    super.initState();
   
  }



  Future<void> signOut() async {
    await auth.signOut();
    Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => LoginPage()),
                );
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          // UserAccountsDrawerHeader(
          //   accountName: Text(userName),
          //   accountEmail: Text(userEmail),
          //   currentAccountPicture: CircleAvatar(
          //     // You can display the user's profile picture here
          //     backgroundColor: Colors.white,
          //     child: Text(userName[0]),
          //   ),
          // ),
          ListTile(
            title: Text('Profile'),
            leading: Icon(Icons.person),
            onTap: () {
              // Navigate to the user's profile screen
              // You can implement this as needed
             // Navigator.of(context).pop();
            },
          ),
          ListTile(
            title: Text('Sign Out'),
            leading: Icon(Icons.exit_to_app),
            onTap: () {
              // Sign out the user
              signOut();
            },
          ),
        ],
      ),
    );
  }
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
