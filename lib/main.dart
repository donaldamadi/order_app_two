import 'package:flutter/material.dart';
import 'package:project_two/views/list_page.dart';
import 'package:splashscreen/splashscreen.dart';

void main() {
  runApp(MaterialApp(
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
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: IconButton(
              icon: Icon(Icons.refresh),
              tooltip: "Refresh",
              onPressed: (){
                Navigator.of(context).pushNamedAndRemoveUntil('/screen2', (Route<dynamic> route) => false);
              },
            ),
          ),
        ],
      ),
      body:ListPage(),
    );
  }
}
