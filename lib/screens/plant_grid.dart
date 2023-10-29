import 'package:flutter/material.dart';
import 'package:yoo_katale/model/data/data.dart';
import 'package:yoo_katale/screens/Diseases.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
void main() {
  runApp(Plants());
}


class Plants extends StatefulWidget {
  @override
  _PlantsState createState() => _PlantsState();
}

class _PlantsState extends State<Plants> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  late Animation<double> _animation2;
  List listunits = [];
  @override
  void initState() {
    super.initState();
    // print('<<<<<---' + widget.coursemap.toString() + '---->>>>');
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 1),
    );

    _animation = Tween<double>(begin: 0, end: 1)
        .animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut))
      ..addListener(() {
        setState(() {});
      });

    _animation2 = Tween<double>(begin: 0, end: -30)
        .animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double _w = MediaQuery.of(context).size.width;
     final screenWidth = MediaQuery.of(context).size.width;
    //String string = widget.plantname;
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Color(0xffF5F5F5),
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: Container(
            decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
            child: TextField(
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white,
          contentPadding: EdgeInsets.all(12),
          hintText: 'Detect',
          hintStyle: TextStyle(
            color: Colors.orange,
          ),
          prefixIcon: Icon(
            Icons.search,
            color: Colors.orange,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25),
            borderSide: BorderSide(color: Color.fromARGB(255, 216, 212, 209)),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25),
            borderSide: BorderSide(color: Color.fromARGB(255, 216, 212, 209)),
          ),
          // Add a box shadow
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25),
            borderSide: BorderSide(color: Color.fromARGB(255, 216, 212, 209)),
            gapPadding: 4,
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25),
            borderSide: BorderSide(color: Color.fromARGB(255, 216, 212, 209)),
            gapPadding: 4,
          ),
        ),
      )
          ),
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(220.0),
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 10.0),
              height: 200,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                separatorBuilder: (context, index) => SizedBox(width: 10.0), // Add spacing between images
                padding: EdgeInsets.all(10.0),
                itemCount: 3, // Number of images
                itemBuilder: (context, index) {
                  final imageWidth = screenWidth * 0.4; // Adjust the image width as a fraction of the screen width
                  final imageHeight = imageWidth;

                  return ImageWithBorder(
                    imageUrl: 'assets/Detect${index + 1}.png',
                    width: imageWidth,
                    height: imageHeight,
                  );
                },
              ),
            ),
          ),
        ),
      body: ListView(
  children: [
    ElevatedButton(
      onPressed: () {
        // Handle button click
      },
      style: ElevatedButton.styleFrom(
        primary: Colors.green,
      ),
      child: Text(
        'Choose plant type here',
        style: TextStyle(
          fontSize: 24,
          color: Colors.black,
        ),
      ),
    ),
    SizedBox(height: 16), // Add some spacing below the button
    ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: Plant.length,
      itemBuilder: (context, index) {
        return
                        // ListTile(
                        //   leading: Text(widget.Diseases[index]),
                        // );
                        //myCard(widget.Diseases);
                        Opacity(
                      opacity: _animation.value,
                      child: Transform.translate(
                        offset: Offset(0, _animation2.value),
                        child: InkWell(
                          enableFeedback: true,
                          onTap: () {
                            List list = mapcourse(Plant);
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Disease(
                                          plantname: Plant[index].plantname,
                                          Diseases: Plant[index].Diseases,
                                          coursemap: Plant[index].Disease,
                                        )));
                          },
                          highlightColor: Colors.transparent,
                          splashColor: Colors.transparent,
                          child: Container(
                            margin:
                                EdgeInsets.fromLTRB(_w / 20, _w / 20, _w / 20, 0),
                            padding: EdgeInsets.all(_w / 20),
                            height: _w / 4.4,
                            width: _w,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: Color(0xffEDECEA),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                // CircleAvatar(
                                //   backgroundColor: Colors.blue.withOpacity(.1),
                                //   radius: _w / 15,
                                //   child: FlutterLogo(size: 30),
                                // ),
                                Container(
                                  alignment: Alignment.centerLeft,
                                  width: _w / 2,
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        Plant[index].plantname,
                                        textScaleFactor: 1.0,
                                        style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          color: Colors.black.withOpacity(.7),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                //Icon(Icons.navigate_next_outlined)
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
      },
    ),
  ],
),


      ),
    );
  }

//method that returns Diseases units for each paga
  List mapcourse(course) {
    listunits = course;
    print('========' +
        listunits.toString()
        //coursemap[course].toString()
        //course
        +
        '======');

    return listunits;
  }
}

class MyPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint_1 = Paint()
      ..color = Color.fromARGB(255, 250, 250, 249)
      ..style = PaintingStyle.fill;

    Path path_1 = Path()
      ..moveTo(0, 0)
      ..lineTo(size.width * .1, 0)
      ..cubicTo(size.width * .05, 0, 0, 20, 0, size.width * .08);

    Path path_2 = Path()
      ..moveTo(size.width, 0)
      ..lineTo(size.width * .9, 0)
      ..cubicTo(
          size.width * .95, 0, size.width, 20, size.width, size.width * .08);

    Paint paint_2 = Paint()
      ..color = Color.fromARGB(255, 252, 251, 251)
      ..strokeWidth = 1
      ..style = PaintingStyle.stroke;

    Path path_3 = Path()
      ..moveTo(0, 0)
      ..lineTo(size.width, 0);

    canvas.drawPath(path_1, paint_1);
    canvas.drawPath(path_2, paint_1);
    canvas.drawPath(path_3, paint_2);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}


class ImageWithBorder extends StatefulWidget {
  final String imageUrl;
  final double width;
  final double height;

  ImageWithBorder({
    required this.imageUrl,
    required this.width,
    required this.height,
  });

  @override
  State<ImageWithBorder> createState() => _ImageWithBorderState();
}

class _ImageWithBorderState extends State<ImageWithBorder> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black, width: 2.0),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Image.asset(
          widget.imageUrl,
          width: widget.width,
          height: widget.height,
        ),
      ),
    );
  }
}















































// class plantGrid extends StatelessWidget {
//   plantGrid({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return GridView.builder(
//         itemCount: plant.length,
//         physics: const NeverScrollableScrollPhysics(),
//         shrinkWrap: true,
//         gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//             childAspectRatio: 16 / 7, crossAxisCount: 1, mainAxisSpacing: 20),
//         itemBuilder: (context, index) {
//           var plant = plant[index];
//           return Container(
//             decoration: BoxDecoration(
//               image: DecorationImage(
//                   image: AssetImage(plant[index].backImage),
//                   fit: BoxFit.fill),
//             ),
//             child: InkWell(
//               child: Padding(
//                 padding: const EdgeInsets.all(16),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                       children: [
//                         Text(
//                           plant.plantname,
//                           style: const TextStyle(
//                               color: Colors.white, fontSize: 20.0),
//                         ),
//                       ],
//                     ),
//                     // Column(
//                     //   mainAxisAlignment: MainAxisAlignment.center,
//                     //   children: [
//                     //     Image.asset(
//                     //       plant[index].imageUrl,
//                     //       height: 110,
//                     //     )
//                     //   ],
//                     // )
//                   ],
//                 ),
//               ),
//               onTap: plant[index].Diseases.length == 0
//                   ? () {}
//                   : () {
//                       Navigator.of(context).push(MaterialPageRoute(
//                           builder: (context) => Disease(
//                                 plantname: plant.plantname,
//                                 Diseases: plant.Diseases,
//                                 coursemap: plant.Disease,
//                               )));

//                       print('<<<<<' + plant.Disease.toString() + '>>>>');
//                     },
//             ),
//           );
//         });
//   }
// }
