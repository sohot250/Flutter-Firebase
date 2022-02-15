import 'package:flutter/material.dart';
import 'package:lec8/screen/display.dart';
import 'package:lec8/screen/formscreen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        child: Scaffold(
          body: TabBarView(children: [FormScreen(), DisplayScreen()]),
          bottomNavigationBar: TabBar(tabs: [
            Tab(text: 'บันทึกอุณหภูมิ'),
            Tab(text: 'รายชื่อนักเรียน')
          ]),
          backgroundColor: Colors.blue,
        ));
  }
}
