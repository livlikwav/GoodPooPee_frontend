// import 'package:flutter/material.dart';
// import 'package:flutter_vlc_player/flutter_vlc_player.dart';
// import 'package:flutter_vlc_player/vlc_player.dart';
// import 'package:flutter_vlc_player/vlc_player_controller.dart';

// void main() {
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       title: 'Flutter Demo',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//         visualDensity: VisualDensity.adaptivePlatformDensity,
//       ),
//       home: MyHomePage(title: 'Flutter Demo Home Page'),
//     );
//   }
// }

// class MyHomePage extends StatefulWidget {
//   MyHomePage({Key key, this.title}) : super(key: key);
//   final String title;

//   @override
//   _MyHomePageState createState() => _MyHomePageState();
// }

// class _MyHomePageState extends State<MyHomePage> {
//   String _streamUrl;
//   VlcPlayerController _vlcViewController;

//   @override
//   void initState() {
//     super.initState();
//     _vlcViewController = new VlcPlayerController();
//   }

//   void _incrementCounter() {
//     setState(() {
//       if (_streamUrl != null) {
//         _streamUrl = null;
//       } else {
//         _streamUrl = 'http://beachreachpeach.iptime.org:9981';
//       }
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(widget.title),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             _streamUrl == null
//                 ? Container(
//                     child: Center(
//                     child: RichText(
//                       text: TextSpan(children: [
//                         TextSpan(
//                             text: 'Stream Closed',
//                             style: TextStyle(
//                                 fontSize: 14.0,
//                                 fontWeight: FontWeight.bold,
//                                 color: Colors.black))
//                       ]),
//                     ),
//                   ))
//                 : new VlcPlayer(
//                     defaultHeight: 720,
//                     defaultWidth: 1280,
//                     url: _streamUrl,
//                     controller: _vlcViewController,
//                     placeholder: Container(),
//                   )
//           ],
//         ),
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: _incrementCounter,
//         tooltip: 'Increment',
//         child: Icon(_streamUrl == null ? Icons.play_arrow : Icons.pause),
//       ), // This trailing comma makes auto-formatting nicer for build methods.
//     );
//   }
// }
