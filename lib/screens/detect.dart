import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: DetectPage(),
    );
  }
}

class DetectPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Row(
          children: [
            Icon(
              Icons.search,
              color: Colors.orange,
            ),
            SizedBox(width: 8.0),
            Text(
              "DETECT",
              style: TextStyle(
                fontSize: 18.0,
              ),
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          // Row of square images
          Container(
            height: 120.0, // Adjust the height as needed
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                _buildImage("Image 1"),
                _buildImage("Image 2"),
                _buildImage("Image 3"),
                // Add more images as needed
              ],
            ),
          ),
          SizedBox(height: 16.0),
          // Green horizontal button
          Container(
            color: Colors.green,
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            height: 50.0,
            child: Center(
              child: Text(
                "Choose plant type here",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16.0,
                ),
              ),
            ),
          ),
          SizedBox(height: 16.0),
          // Horizontal grids with plant names
          _buildPlantGrid("CASSAVA"),
          _buildPlantGrid("SWEET POTATO"),
          _buildPlantGrid("BANANA"),
          _buildPlantGrid("MAIZE"),
          _buildPlantGrid("SOYA BEANS"),
          _buildPlantGrid("BEANS"),
          _buildPlantGrid("PEANUTS"),
          _buildPlantGrid("PINEAPPLES"),
        ],
      ),
    );
  }

  Widget _buildImage(String label) {
    return Container(
      width: 120.0, // Adjust the width as needed
      margin: EdgeInsets.only(right: 8.0),
      color: Colors.grey, // Placeholder color
      child: Center(
        child: Text(
          label,
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  Widget _buildPlantGrid(String label) {
    return Container(
      color: Colors.white,
      child: Center(
        child: Text(
          label,
          style: TextStyle(
            color: Colors.black,
            fontSize: 18.0,
          ),
        ),
      ),
    );
  }
}
