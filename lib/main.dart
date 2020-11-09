import 'package:flutter/material.dart';
import 'package:project_two/views/list_page.dart';
import 'package:splashscreen/splashscreen.dart';
import 'package:firebase_core/firebase_core.dart';


void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    MaterialApp(
    debugShowCheckedModeBanner: false,
    home: MyApp(),
    theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
    routes: <String, WidgetBuilder>{
        '/screen1':(BuildContext context) => MyApp(),
        '/screen2':(BuildContext context) => MyHomePage(title: "My Orders")
      },
  ));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SplashScreen(
      seconds: 3,
      navigateAfterSeconds: Scaffold(body: MyHomePage(title: 'My Orders',)),
      title: Text('bubble',
      style: TextStyle(
        color: Colors.blue,
        fontFamily: 'Pacifico',
        fontSize: 40
      ),
      ),
      image: Image.asset('assets/images/clean (2).png',),
      photoSize: 100,
      backgroundColor: Colors.black,
      
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        automaticallyImplyLeading: false,
      ),
      body:ListPage(),
    );
  }
}