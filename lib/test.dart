// import 'dart:io';
// import 'dart:typed_data';

// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:mak_past_papers/model/college_model.dart';
// import 'package:firebase_storage/firebase_storage.dart';
// import 'package:file_picker/file_picker.dart';
// import 'package:http/http.dart'as http;
// import 'package:mak_past_papers/model/pdf_provider.dart';
// import 'package:mak_past_papers/screens/pdfstore.dart';
// import 'package:mak_past_papers/screens/viewpdf.dart';
// import 'package:provider/provider.dart';

// class paper extends StatefulWidget {
//   final String courseunitname;
//   final String coursename;
// final String collegename;
//   paper({required this.courseunitname,required this.coursename,required this.collegename});
//   @override
//   _paperState createState() => _paperState();
// }

// class _paperState extends State<paper>
//     with SingleTickerProviderStateMixin {
//   late AnimationController _controller;
//   late Animation<double> _animation;
// late Future<ListResult> futureFiles;
// var storage = FirebaseStorage.instance;
// FilePickerResult? result;
// String name= '';
// //late var pdfProvider = Provider.of<pdfprovider>(context,listen: false);
// String pdfurl = 'https://firebasestorage.googleapis.com/v0/b/papers-1ddd0.appspot.com/o/COCIS%2FComputer%20Science(BCSC)%2FMathematics%20for%20Computer%20Science%2FMPP_Research%20Methodology_Test%20I.pdf?alt=media&token=d5b99e15-1fef-4343-bd5a-5566a57775c0';
// //late Future<String> pdfpaths;
//  String? changedString;
// late String pdfName;
// //late final pdfProvider = Provider.of<pdfprovider>(context,listen: false);
// //String paperpath = 'COCIS/Computer Science(BCSC)/'+widget.courseunitname;
// var file;
//   @override
//   void initState() {
    
//     super.initState();
// futureFiles=  FirebaseStorage.instance.ref(widget.collegename+'/'+widget.coursename+'/'+widget.courseunitname).listAll();
//     _controller = AnimationController(
//       vsync: this,
//       duration: Duration(seconds: 1),
//     );

//     _animation = Tween<double>(begin: 0, end: 1)
//         .animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut))
//       ..addListener(() {
//         setState(() {});
//       });

//     _controller.forward();
//   }
// pickpapers() async {
//   result = (await FilePicker.platform.pickFiles(
//         withReadStream: true, allowMultiple: true,))!;
//               if(result == null){
//                 ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('No paper has been selected')));
                
//               }
              
//      file = result!.files.first ;
//      final path = result!.files.single.path!;
//     final fileName = result!.files.single.name;
    
//     uploadfile(path,fileName);
//    // loadselectedfiles(result!.files);
//     setState(() {
      
//     });

// }
// Future<void> uploadfile(
//  String filepath,
//  String fileName
// ) async {
//  File file = File(filepath);

//  try{var snapshot = await storage.ref()
//         .child(widget.collegename+'/'+widget.coursename+'/'+widget.courseunitname+'/'+fileName)
//         .putFile(file).whenComplete((){print('==============file uploaded successful=============');});
//    //UploadTask uploadTask = (await storage.ref(widget.collegename+'/'+widget.coursename+'/'+widget.courseunitname).putFile(file)) as UploadTask;
//    String url = await ( snapshot).ref.getDownloadURL();
  

// print(url);

//  }  catch (e) {
// print(e);

//  }


// }
//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     double _w = MediaQuery.of(context).size.width;
//     return Scaffold(
//       backgroundColor: Color(0xffF5F5F5),
//       appBar: PreferredSize(
//           preferredSize: Size.fromHeight(120.0), // here the desired height
//           child: SafeArea(
//               child: AppBar(
//                   backgroundColor: Color(0xffF5F5F5),
//                   automaticallyImplyLeading: false,
//                   flexibleSpace: searchBar()))),
//       body: FutureBuilder<ListResult>(
//         future: futureFiles,
//         builder:(context, snapshot) {
//           if (snapshot.hasData){
//                   final files = snapshot.data!.items;
                 
//                  return ListView.builder(
//                   itemCount: files.length,
//                   itemBuilder: (context,index){
//                    // setState(()
//                     //async 
//                     //{
//                       //pdfurl = await files[index].getDownloadURL();
//                    // });
                    
//                    // pdfProvider.getpdfurl(files[index].getDownloadURL(),);
//                     pdfName =files[index].name;
//                     file = files[index];
//                   // if(file.name.){}
//                    // pdfpaths = files[index].getDownloadURL();
//                    if(name.isEmpty){
//                               return ListTile(
//                       title: Text(file.name),
                      
//                       //onPressed: () async { }
//                       onTap: () async {
//                        // pdfurl = await files[index].getDownloadURL();
//                   //        print('=================');
//                   //   print(pdfurl);
//                   //   print('=================');
//                   //  //    open
//                         Navigator.push(
//                 context,
//                 MaterialPageRoute(
//                   builder: (context) => viewpdf(
//                     pdfurl: pdfurl,
                  
//                   ),
//                 ));

                        
                
//                       },
//                     );
                    
//                    }
//                    if(file.name.toString().toLowerCase().contains(name.toLowerCase())
//                    //startsWith(name.toLowerCase())
                   
//                    ){

//                      return ListTile(
//                       title: Text(file.name),

//                       onTap: () async {
                  
//                         Navigator.push(
//                 context,
//                 MaterialPageRoute(
//                   builder: (context) => viewpdf(
//                     pdfurl: pdfurl,
                  
//                   ),
//                 ));

                        
                
//                       },
//                     );
                    
//                    }
//                     return Container();
//           });}
// else if(snapshot.hasError){
//                   return const Center(child: Text('error'),);
//                 }else{
//                   return const Center(child: CircularProgressIndicator(),);
//                 }

//         })
//          ,
//          bottomNavigationBar: Container(
//   color:Colors.white,
//   padding: EdgeInsets.all(10.0),
//   child: Row(
//     crossAxisAlignment: CrossAxisAlignment.center, // Optional
//     mainAxisAlignment: MainAxisAlignment.spaceEvenly, // Change to your own spacing
//     children: [
//      ElevatedButton.icon(
//     onPressed: (){
//       pickpapers();


//     }, 
//     icon: Icon(Icons.add),  
//     label: Text(""),
//     style:  ElevatedButton.styleFrom(
//               primary: Colors.red,
//             ).copyWith(elevation: ButtonStyleButton.allOrNull(0.0)),//label text 
// )
//     ],
//   ),
// ),
//          );
        
      
    
//   }

//   Widget searchBar() {
//     double _w = MediaQuery.of(context).size.width;
//     return Padding(
//       padding: EdgeInsets.fromLTRB(_w / 20, _w / 25, _w / 20, 0),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Container(
//             alignment: Alignment.center,
//             height: _w / 8.5,
//             width: _w / 1.36,
//             padding: EdgeInsets.symmetric(horizontal: _w / 60),
//             decoration: BoxDecoration(
//               color: Colors.white,
//               borderRadius: BorderRadius.circular(99),
//               boxShadow: [
//                 BoxShadow(
//                   color: Colors.black.withOpacity(.1),
//                   blurRadius: 30,
//                   offset: Offset(0, 15),
//                 ),
//               ],
//             ),
//             child: TextField(
//               onChanged:(value) {
//                 setState(() {
//                   name = value;
//                 });
                
//               },
//               maxLines: 1,
//               decoration: InputDecoration(
//                 fillColor: Colors.transparent,
//                 filled: true,
//                 hintStyle: TextStyle(
//                     color: Colors.black.withOpacity(.4),
//                     fontWeight: FontWeight.w600,
//                     fontSize: _w / 22),
//                 prefixIcon:
//                     Icon(Icons.search, color: Colors.black.withOpacity(.6)),
//                 hintText: 'Search for paper.....',
//                 border: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(10),
//                     borderSide: BorderSide.none),
//                 contentPadding: EdgeInsets.zero,
//               ),
//             ),
//           ),
//           SizedBox(height: _w / 14),
//           Container(
//             width: _w / 1.15,
//             child: Text(
//               widget.courseunitname,
//               textScaleFactor: 1.4,
//               style: TextStyle(
//                 fontWeight: FontWeight.w600,
//                 color: Colors.black.withOpacity(.7),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget card(String title) {
//     double _w = MediaQuery.of(context).size.width;
//     return Opacity(
//       opacity: _animation.value,
//       child: InkWell(
//         highlightColor: Colors.transparent,
//         splashColor: Colors.transparent,
//         onTap: () {
//           //Navigator.of(context).push(MyFadeRoute(route: route, page: 4));
//         },
//         child: Container(
//           width: _w / 2.36,
//           height: _w / 1.8,
//           decoration: BoxDecoration(
//             color: Colors.white,
//             borderRadius: BorderRadius.circular(20),
//             boxShadow: [
//               BoxShadow(color: Colors.black.withOpacity(.05), blurRadius: 50),
//             ],
//           ),
//           child: Column(
//             children: [
//               Container(
//                 width: _w / 2.36,
//                 height: _w / 2.6,
//                 decoration: BoxDecoration(
//                   color: Color(0xff5C71F3),
//                   borderRadius: BorderRadius.vertical(
//                     top: Radius.circular(20),
//                   ),
//                 ),
//                 alignment: Alignment.center,
//                 child: Text(
//                   'Add image here',
//                   textScaleFactor: 1.2,
//                   style: TextStyle(color: Colors.white),
//                 ),
//               ),
//               // Image.asset(
//               //   image,
//               //   fit: BoxFit.cover,
//               //   width: _w / 2.36,
//               //   height: _w / 2.6),
//               Container(
//                 height: _w / 6,
//                 width: _w / 2.36,
//                 padding: EdgeInsets.symmetric(horizontal: _w / 25),
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       title,
//                       textScaleFactor: 1.4,
//                       maxLines: 1,
//                       softWrap: true,
//                       overflow: TextOverflow.ellipsis,
//                       style: TextStyle(
//                         color: Colors.black.withOpacity(.8),
//                         fontWeight: FontWeight.w500,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
  
// //   void change(pdfpaths) async{
    
// // changedString = await pdfpaths;

// // //print(changedString);

// //   }
  
//   // void openpdf(
//   //   //BuildContext context, File file
//   //   ) {print('============');
//   //     print(changedString);
//   //     print('============');

//   // }
// }

// class MyFadeRoute extends PageRouteBuilder {
//   final Widget page;
//   final Widget route;

//   MyFadeRoute({required this.page, required this.route})
//       : super(
//           pageBuilder: (
//             BuildContext context,
//             Animation<double> animation,
//             Animation<double> secondaryAnimation,
//           ) =>
//               page,
//           transitionsBuilder: (
//             BuildContext context,
//             Animation<double> animation,
//             Animation<double> secondaryAnimation,
//             Widget child,
//           ) =>
//               FadeTransition(
//             opacity: animation,
//             child: route,
//           ),
//         );
// }