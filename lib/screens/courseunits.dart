// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

// class course_units extends StatefulWidget {
//   final String course;
//   final String plant;
//   final List<dynamic> units;
//   course_units(
//       {required this.course, required this.plant, required this.units});
//   @override
//   _course_unitsState createState() => _course_unitsState();
// }

// class _course_unitsState extends State<course_units> {
//   @override
//   initState() {
//     printing();
//   }

//   printing() {
// //print('----------------'+widget.units[0].toString()+'-----------------');
//   }
// //int number_of_uints = units.;
// //String courseUnitName = widget.course;
//   String name = '';
//   @override
//   Widget build(BuildContext c) {
//     double _w = MediaQuery.of(context).size.width;
//     return Scaffold(
//       appBar: AppBar(
//         leading: Text("Course Units"),
//         title: Card(
//             child: SizedBox(
//                 width: 200,
//                 height: 30,
//                 child: TextField(
//                   decoration: InputDecoration(
//                       prefixIcon: Icon(Icons.search), hintText: "search....."),
//                   onChanged: (value) {
//                     setState(() {
//                       name = value;
//                     });
//                   },
//                 ))),
//         // Text("Course Units"),
//         //centerTitle: true,
//         //brightness: Brightness.dark,
//       ),
//       body: AnimationLimiter(
//         child: ListView.builder(
//           padding: EdgeInsets.all(_w / 30),
//           physics:
//               BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
//           itemCount: widget.units.length,
//           itemBuilder: (BuildContext context, int index) {
//             if (name.isEmpty) {
//               return AnimationConfiguration.staggeredList(
//                 position: index,
//                 delay: Duration(milliseconds: 100),
//                 child: SlideAnimation(
//                   duration: Duration(milliseconds: 2500),
//                   curve: Curves.fastLinearToSlowEaseIn,
//                   child: FadeInAnimation(
//                     curve: Curves.fastLinearToSlowEaseIn,
//                     duration: Duration(milliseconds: 2500),
//                     child: GestureDetector(
//                       onTap: () {
//                         // Navigator.push(
//                         //     context,
//                         //     MaterialPageRoute(
//                         //       builder: (context) => paper(
//                         //         courseunitname: widget.units[index],
//                         //         plantname: widget.plant,
//                         //         coursename: widget.course,
//                         //       ),
//                         //     ));
//                       },
//                       child: Container(
//                         child: Center(
//                             child: Text(widget.units[index],
//                                 style: TextStyle(
//                                     color: Colors.red,
//                                     fontSize: 16.0,
//                                     fontWeight: FontWeight.bold))),
//                         margin: EdgeInsets.only(bottom: _w / 20),
//                         height: _w / 4,
//                         decoration: BoxDecoration(
//                           color: Colors.white,
//                           borderRadius: BorderRadius.all(Radius.circular(20)),
//                           boxShadow: [
//                             BoxShadow(
//                               color: Colors.black.withOpacity(0.1),
//                               blurRadius: 40,
//                               spreadRadius: 10,
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//               );
//             }
//             if (widget.units[index].toString().contains(name.toLowerCase())) {
//               return AnimationConfiguration.staggeredList(
//                 position: index,
//                 delay: Duration(milliseconds: 100),
//                 child: SlideAnimation(
//                   duration: Duration(milliseconds: 2500),
//                   curve: Curves.fastLinearToSlowEaseIn,
//                   child: FadeInAnimation(
//                     curve: Curves.fastLinearToSlowEaseIn,
//                     duration: Duration(milliseconds: 2500),
//                     child: GestureDetector(
//                       onTap: () {
//                         // Navigator.push(
//                         //     context,
//                         //     MaterialPageRoute(
//                         //       builder: (context) => paper(
//                         //         courseunitname: widget.units[index],
//                         //         plantname: widget.plant,
//                         //         coursename: widget.course,
//                         //       ),
//                         //     ));
//                       },
//                       child: Container(
//                         child: Center(
//                             child: Text(widget.units[index],
//                                 style: TextStyle(
//                                     color: Colors.red,
//                                     fontSize: 16.0,
//                                     fontWeight: FontWeight.bold))),
//                         margin: EdgeInsets.only(bottom: _w / 20),
//                         height: _w / 4,
//                         decoration: BoxDecoration(
//                           color: Colors.white,
//                           borderRadius: BorderRadius.all(Radius.circular(20)),
//                           boxShadow: [
//                             BoxShadow(
//                               color: Colors.black.withOpacity(0.1),
//                               blurRadius: 40,
//                               spreadRadius: 10,
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//               );
//             }
//             return Container();
//           },
//         ),
//       ),
//     );
//   }
// }
























// // import 'package:flutter/material.dart';
// // import 'package:flutter/services.dart';
// // import 'package:mak_past_papers/model/plant_model.dart';

// // class MyCustomUI extends StatefulWidget {
// //   final String course;
// //   final List<dynamic> units;

// //   MyCustomUI({required this.course, required this.units});
// //   @override
// //   _MyCustomUIState createState() => _MyCustomUIState();
// // }

// // class _MyCustomUIState extends State<MyCustomUI>
// //     with SingleTickerProviderStateMixin {
// //   late AnimationController _controller;
// //   late Animation<double> _animation;

// //   @override
// //   void initState() {
// //     super.initState();

// //     _controller = AnimationController(
// //       vsync: this,
// //       duration: Duration(seconds: 1),
// //     );

// //     _animation = Tween<double>(begin: 0, end: 1)
// //         .animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut))
// //       ..addListener(() {
// //         setState(() {});
// //       });

// //     _controller.forward();
// //   }

// //   @override
// //   void dispose() {
// //     _controller.dispose();
// //     super.dispose();
// //   }

// //   @override
// //   Widget build(BuildContext context) {
// //     double _w = MediaQuery.of(context).size.width;
// //     return Scaffold(
// //       backgroundColor: Color(0xffF5F5F5),
// //       appBar: PreferredSize(
// //           preferredSize: Size.fromHeight(120.0), // here the desired height
// //           child: SafeArea(
// //               child: AppBar(
// //                   backgroundColor: Color(0xffF5F5F5),
// //                   automaticallyImplyLeading: false,
// //                   flexibleSpace: searchBar()))),
// //       body: Stack(
// //         children: [
// //           ListView.builder(
// //               itemCount: widget.units.length,
// //               itemBuilder: (context, index) {
// //                 return card(
// //                   widget.course,
// //                 );
// //               }),
// //         ],
// //       ),
// //     );
// //   }

// //   Widget searchBar() {
// //     double _w = MediaQuery.of(context).size.width;
// //     return Padding(
// //       padding: EdgeInsets.fromLTRB(_w / 20, _w / 25, _w / 20, 0),
// //       child: Column(
// //         crossAxisAlignment: CrossAxisAlignment.start,
// //         children: [
// //           Container(
// //             alignment: Alignment.center,
// //             height: _w / 8.5,
// //             width: _w / 1.36,
// //             padding: EdgeInsets.symmetric(horizontal: _w / 60),
// //             decoration: BoxDecoration(
// //               color: Colors.white,
// //               borderRadius: BorderRadius.circular(99),
// //               boxShadow: [
// //                 BoxShadow(
// //                   color: Colors.black.withOpacity(.1),
// //                   blurRadius: 30,
// //                   offset: Offset(0, 15),
// //                 ),
// //               ],
// //             ),
// //             child: TextField(
// //               maxLines: 1,
// //               decoration: InputDecoration(
// //                 fillColor: Colors.transparent,
// //                 filled: true,
// //                 hintStyle: TextStyle(
// //                     color: Colors.black.withOpacity(.4),
// //                     fontWeight: FontWeight.w600,
// //                     fontSize: _w / 22),
// //                 prefixIcon:
// //                     Icon(Icons.search, color: Colors.black.withOpacity(.6)),
// //                 hintText: 'Search for courseunit.....',
// //                 border: OutlineInputBorder(
// //                     borderRadius: BorderRadius.circular(10),
// //                     borderSide: BorderSide.none),
// //                 contentPadding: EdgeInsets.zero,
// //               ),
// //             ),
// //           ),
// //           SizedBox(height: _w / 14),
// //           Container(
// //             width: _w / 1.15,
// //             child: Text(
// //               'Example Text',
// //               textScaleFactor: 1.4,
// //               style: TextStyle(
// //                 fontWeight: FontWeight.w600,
// //                 color: Colors.black.withOpacity(.7),
// //               ),
// //             ),
// //           ),
// //         ],
// //       ),
// //     );
// //   }

// //   Widget card(String title) {
// //     double _w = MediaQuery.of(context).size.width;
// //     return Opacity(
// //       opacity: _animation.value,
// //       child: InkWell(
// //         highlightColor: Colors.transparent,
// //         splashColor: Colors.transparent,
// //         onTap: () {
// //           //Navigator.of(context).push(MyFadeRoute(route: route, page: 4));
// //         },
// //         child: Container(
// //           width: _w / 2.36,
// //           height: _w / 1.8,
// //           decoration: BoxDecoration(
// //             color: Colors.white,
// //             borderRadius: BorderRadius.circular(20),
// //             boxShadow: [
// //               BoxShadow(color: Colors.black.withOpacity(.05), blurRadius: 50),
// //             ],
// //           ),
// //           child: Column(
// //             children: [
// //               Container(
// //                 width: _w / 2.36,
// //                 height: _w / 2.6,
// //                 decoration: BoxDecoration(
// //                   color: Color(0xff5C71F3),
// //                   borderRadius: BorderRadius.vertical(
// //                     top: Radius.circular(20),
// //                   ),
// //                 ),
// //                 alignment: Alignment.center,
// //                 child: Text(
// //                   'Add image here',
// //                   textScaleFactor: 1.2,
// //                   style: TextStyle(color: Colors.white),
// //                 ),
// //               ),
// //               // Image.asset(
// //               //   image,
// //               //   fit: BoxFit.cover,
// //               //   width: _w / 2.36,
// //               //   height: _w / 2.6),
// //               Container(
// //                 height: _w / 6,
// //                 width: _w / 2.36,
// //                 padding: EdgeInsets.symmetric(horizontal: _w / 25),
// //                 child: Column(
// //                   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
// //                   crossAxisAlignment: CrossAxisAlignment.start,
// //                   children: [
// //                     Text(
// //                       title,
// //                       textScaleFactor: 1.4,
// //                       maxLines: 1,
// //                       softWrap: true,
// //                       overflow: TextOverflow.ellipsis,
// //                       style: TextStyle(
// //                         color: Colors.black.withOpacity(.8),
// //                         fontWeight: FontWeight.w500,
// //                       ),
// //                     ),
// //                   ],
// //                 ),
// //               ),
// //             ],
// //           ),
// //         ),
// //       ),
// //     );
// //   }
// // }

// // class MyFadeRoute extends PageRouteBuilder {
// //   final Widget page;
// //   final Widget route;

// //   MyFadeRoute({required this.page, required this.route})
// //       : super(
// //           pageBuilder: (
// //             BuildContext context,
// //             Animation<double> animation,
// //             Animation<double> secondaryAnimation,
// //           ) =>
// //               page,
// //           transitionsBuilder: (
// //             BuildContext context,
// //             Animation<double> animation,
// //             Animation<double> secondaryAnimation,
// //             Widget child,
// //           ) =>
// //               FadeTransition(
// //             opacity: animation,
// //             child: route,
// //           ),
// //         );
// // }
