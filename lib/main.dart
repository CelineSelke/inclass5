import 'package:flutter/material.dart';

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
  String mood = "Happy 😊";
  ThemeData _themeMode = ThemeData(primaryColor: Colors.green, appBarTheme: AppBarTheme(backgroundColor: Colors.green), scaffoldBackgroundColor: Colors.lightGreen);

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
    _updateMood();
  }

  // Increase hunger level slightly when playing with the pet
  void _updateHunger() {
    hungerLevel = (hungerLevel + 5).clamp(0, 100);
    if (hungerLevel > 100) {
      hungerLevel = 100;
      happinessLevel = (happinessLevel - 20).clamp(0, 100);
    }
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
            ],
          ),
        ),
    )
    );
  }
}
