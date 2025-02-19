import 'package:flutter/material.dart';
import 'dart:async';

void main() {
  runApp(MaterialApp(
    home: DigitalPetApp(),
  ));
}

class DigitalPetApp extends StatefulWidget {
  @override
  _DigitalPetAppState createState() => _DigitalPetAppState();
}

class _DigitalPetAppState extends State<DigitalPetApp> {
  String petName = "Your Pet";
  int happinessLevel = 50;
  int hungerLevel = 50;
  int energyLevel = 50;
  String mood = "Happy 😊";
  ThemeData _themeMode = ThemeData(primaryColor: Colors.green, appBarTheme: AppBarTheme(backgroundColor: Colors.green), scaffoldBackgroundColor: Colors.lightGreen);
  Timer? winTimer;
  Timer? timer;
  var activities = ['Fetch','Walk','Sleep'];
  String dropdownValue = "Fetch";

  @override
  void initState() {
    super.initState();
    _startTimer();
    _startWinTimer();
  }

  // Function to increase happiness and update hunger when playing with the pet
  void _playWithPet() {
    setState(() {
      happinessLevel = (happinessLevel + 10).clamp(0, 100);
      _updateMood();
      _updateHunger();
    });
  }

  // Function to decrease hunger and update happiness when feeding the pet
  void _feedPet() {
    setState(() {
      hungerLevel = (hungerLevel - 10).clamp(0, 100);
      _updateHappiness();
    });
  }

  // Update happiness based on hunger level
  void _updateHappiness() {
    if (hungerLevel < 30) {
      happinessLevel = (happinessLevel - 20).clamp(0, 100);
    } else {
      happinessLevel = (happinessLevel + 10).clamp(0, 100);
    }
    _checkLoss();
    _updateMood();
  }

  // Increase hunger level slightly when playing with the pet
  void _updateHunger() {
    hungerLevel = (hungerLevel + 5).clamp(0, 100);
    if (hungerLevel >= 100) {
      hungerLevel = 100;
      happinessLevel = (happinessLevel - 20).clamp(0, 100);
    }
    _checkLoss();
  }

  void _startTimer() {
    Timer.periodic(Duration(seconds: 30), (timer) {
      if (mounted) {
        _updateHunger();
        _checkLoss();
      }
    });
  }

  void _startWinTimer() {
    winTimer = Timer(Duration(seconds: 300), () {
      _showDialog("You Win!", "You're a good pet owner!");
      _resetGame();
    });
  }

  void _checkLoss() {
    if (hungerLevel >= 100 && happinessLevel <= 10) {
      _showDialog("Game Over", "Your pet is gone.");
      _resetGame();
    }
  }

  void _showDialog(String title, String content) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(content),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  void _resetGame() {
    setState(() {
      hungerLevel = 50;
      happinessLevel = 50;
    });
    dispose();
    _restartTimers();
  }

  void _restartTimers() {
    _startTimer();
    _startWinTimer(); // Restart the timer
  }

  @override
  void dispose() {
    // Cancel the timer when the widget is disposed to prevent memory leaks
    timer?.cancel();
    winTimer?.cancel();
    super.dispose();
  }


  void _updateMood(){
      if (happinessLevel > 70){
          setState(() {          
              mood = "Happy 😊";
              _updateTheme();

          });
      }
      else if (happinessLevel >= 30 && happinessLevel <= 70){
          setState(() {
              mood = "Neutral 😐";
              _updateTheme();

          });
      }
      else{
          setState(() {
              mood = "Unhappy ☹️";
              _updateTheme();
          });
      }
  }

  void _updateTheme(){
      if (mood == "Happy 😊"){
          setState(() {
              _themeMode = ThemeData(primaryColor: Colors.green, appBarTheme: AppBarTheme(backgroundColor: Colors.green),scaffoldBackgroundColor: Colors.lightGreen[100]);
          });
      }

      if (mood == "Neutral 😐"){
          setState(() {
              _themeMode = ThemeData(primaryColor: Colors.yellow, appBarTheme: AppBarTheme(backgroundColor: Colors.yellow),scaffoldBackgroundColor: Colors.yellow[100]);
          });
      }

      if (mood == "Unhappy ☹️"){
          setState(() {
              _themeMode = ThemeData(primaryColor: Colors.red, appBarTheme: AppBarTheme(backgroundColor: Colors.red), scaffoldBackgroundColor: Colors.red[100]);
          });
      }
  }

  void _activity(){
      if(dropdownValue == "Fetch"){
          happinessLevel = (happinessLevel + 20).clamp(0, 100);
          hungerLevel = (hungerLevel + 10).clamp(0, 100);
      }
      if(dropdownValue == "Walk"){
          happinessLevel = (happinessLevel + 10).clamp(0, 100);
          hungerLevel = (hungerLevel + 20).clamp(0, 100);
      }
      if(dropdownValue == "Sleep"){
          energyLevel = (energyLevel + 30).clamp(0, 100);
  }


  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      theme: _themeMode,

      home:Scaffold(
        appBar: AppBar(
        title: Text('Digital Pet'),
  
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text("Mood: $mood", style: TextStyle(fontSize: 20,),),
              Text(
                'Name: $petName',
                style: TextStyle(fontSize: 20.0),
              ),
              SizedBox(height: 16.0),
              Text(
                'Happiness Level: $happinessLevel',
                style: TextStyle(fontSize: 20.0),
              ),
              SizedBox(height: 16.0),
              Text(
                'Hunger Level: $hungerLevel',
                style: TextStyle(fontSize: 20.0),
              ),
              SizedBox(height: 32.0),
              ElevatedButton(
                onPressed: _playWithPet,
                child: Text('Play with Your Pet'),
              ),
              SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: _feedPet,
                child: Text('Feed Your Pet'),
              ),
              SizedBox(width: 300, height: 100, 
                child: TextField(textAlign: TextAlign.center,
                onChanged: (value){
                
                setState((){
                    petName = value;
                });
                },
                decoration: InputDecoration(hintText: "Change Pet Name"),
            

                ),
                
            ), 
            DropdownButton(value: dropdownValue,
            icon: const Icon(Icons.keyboard_arrow_down),
            items: activities.map((String items) {
                return DropdownMenuItem(
                  value: items,
                  child: Text(items),
                );
              }).toList(),
            onChanged: (String? newval) {
              setState(() {
                  dropdownValue = newval!;
                  _activity();
              });
            },

            ),
            ],
          ),
        ),
    )
    );
  }
}}
