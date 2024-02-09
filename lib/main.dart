import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

 class User{
  User({
    required this.name,
    required this.surname,
  })  ;
  final String name;
  final String surname;

  factory User.fromJson(Map<String, dynamic> json ) => User(
    name: json['name'],
    surname: json['surname'],
  );

  Map<String, dynamic> toJson(){
    return{
      'name': name,
      'surname': surname,
    };
  }

 }

  
class Person {
  Person({
    required this.age,
    required this.interests,
    required this.isMale,
    required this.name,
    required this.raiting,
    required this.surname,
    // required this.user,
  });
  String name;
  int age;
  bool isMale;
  List<String> interests;
  int raiting;
  String surname;
  // User user;

  factory Person.fromJson(Map<String, dynamic> json) => Person(
    age: json['age'], 
    interests: json['interests'], 
    isMale: json['isMale'], 
    name: json['name'], 
    raiting: json['raiting'], 
    surname: json['surname'],
    // user: User.fromJson(json['user']),
    );

     Map<String, dynamic> toJson(){
    return{
      'name': name,
      'surname': surname,
      'age': age,
      'interests': interests,
      'isMale': isMale,
      'raiting': raiting,
      // 'user': User.toJson(json['user']),

    };
  }
}




class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

 

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  
  double progress = 0.0;

  String percentString = "0%";

    @override
    void initState(){
      initPercentIndicatorProgress();
      Person max = Person(
        name: 'Maxim', 
        surname: 'Nikolaev', 
        age: 19, 
        interests: [
        'flutter', 
        'games', 
        'PUBG Mobile'
        ], 
        isMale: true, 
        raiting: 4329, 
      // user: User(name: 'J', surname: 'surname')
      );
      String json = jsonEncode(max.toJson());
      print(json);
 
      Person max2 = Person.fromJson(jsonDecode(json));
 
      print(max2);
      
      super.initState();
    }

  void initPercentIndicatorProgress(){
    Timer.periodic(const Duration(milliseconds: 50), (timer) {
      if(progress < 1.0){
        setState(() {
          progress = double.parse((progress + 0.01).toStringAsFixed(2));
          percentString = '${(progress * 100).toStringAsFixed(2)}%';
        });
      } else if(progress == 1){
        timer.cancel();
      }
    });

  }


  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(
        title:const Text(' Lib and JSON TO MODEL'),
        centerTitle: true,
        backgroundColor: Colors.purpleAccent,
      ),
      body: Center(
        child: CircularPercentIndicator(
                  radius: 60.0,
                  lineWidth: 5.0,
                  percent: progress,
                  center: Text(percentString),
                  progressColor: Colors.purpleAccent,
                ),
      ),
    );
  }
}
