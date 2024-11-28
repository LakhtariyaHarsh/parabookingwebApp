import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:parabooking_webapp/classicbookparaglading.dart';
import 'package:parabooking_webapp/crosscountry.dart';
import 'package:parabooking_webapp/dharmshalaparagliding.dart';
import 'package:parabooking_webapp/kullumanaliparagrlliding.dart';
import 'package:parabooking_webapp/primeparagliding.dart';
import 'package:parabooking_webapp/shimalaparagliding.dart';
import 'topbar/topbarcontent.dart';
import 'chooseflight.dart';
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ParaBooking',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    var Screensize = MediaQuery.of(context).size;
    // var deviceType = getDeviceType(Screensize);
    return Scaffold(
        backgroundColor: Colors.black,
        body: SingleChildScrollView(
          padding: EdgeInsets.zero,
          child: Column(
            children: [
              SizedBox(
                height: Screensize.height,
                width: Screensize.width,
                child: Topbarcontent(),
              ),
              Container(
                color: Color(0xff2377af),
                height: 380,
                width: Screensize.width,
                child: Chooseflight(),
              ),
              Container(
                height: 630,
                width: Screensize.width,
                child: Classicbookparaglading(),
              ),
               Container(
                height: 630,
                width: Screensize.width,
                child: Primeparagliding(),
              ),
              Container(
                height: 630,
                width: Screensize.width,
                child: Crosscountry(),
              ),
               Container(
                height: 630,
                width: Screensize.width,
                child: Kullumanaliparagrlliding(),
              ),
              Container(
                height: 630,
                width: Screensize.width,
                child: Dharmshalaparagliding(),
              ),
               Container(
                height: 630,
                width: Screensize.width,
                child: Shimalaparagliding(),
              ),
            ],
          ),
        ));
  }
}
