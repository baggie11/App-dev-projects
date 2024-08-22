import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const Bmi(),
    );
  }
}

class Bmi extends StatefulWidget {
  const Bmi({super.key});

  @override
  State<Bmi> createState() => _BmiState();
}

class _BmiState extends State<Bmi> {

  final TextEditingController _height = TextEditingController();
  final TextEditingController _weight = TextEditingController();
  String _result = '';

  //bmi calculation logic
  void _calculate(){
    final double height = double.tryParse(_height.text) ?? 0.0;
    final double weight = double.tryParse(_weight.text) ?? 0.0;

    //calculate bmi
    double bmi = 0;

    if (height > 0){
      bmi = (weight/(height * height)) * 10000;
    }

    setState(() {
      if (bmi < 18.4){
        _result = '''You are underweight.
        Suggestion : Increase calorie intake with nutrient-rich foods and focus on strength training.''';
      }
      else if(bmi <= 24.9){
        _result = '''You are in the correct range.
        Suggestion : Maintain a balanced diet and regular exercise routine to sustain your weight.''';
      }
      else if (bmi <= 29.9){
        _result = '''You are overweight.
        Suggestion : Adopt a balanced diet with reduced calories and increase physical activity.''';
      }
      else{
        _result = '''You are obese.
        Suggestion :  Seek professional guidance to develop a comprehensive weight loss plan including diet, exercise, and lifestyle changes.''';
      }
    });


    //

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("BMI Calculator",style: TextStyle(
          color: Colors.white,
        ),),
        backgroundColor: Colors.purple,
        centerTitle: true,
      ),
      body: Padding(
          padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Use our BMI Calculator to find out your BMI and take corrective measures if necessary",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.black87),
              textAlign: TextAlign.center),
            SizedBox(height: 40,),
            TextField(
              controller: _height,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                hintText: 'Enter your height in cm',
              ),
            ),
            SizedBox(height: 20,),
            TextField(
              controller: _weight,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                hintText: 'Enter your weight in kg',
              ),
            ),
            SizedBox(height: 50,),
            Align(
              alignment: Alignment.center,
              child: OutlinedButton(onPressed: _calculate, child:Text("Calculate",style: TextStyle(fontSize: 20.0),),
              )
            ),
            SizedBox(height: 50,),
            Text(
              _result,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            )

          ],
        ),
      ),


    );
  }

  @override
  void dispose() {
    _weight.dispose();
    _height.dispose();
    super.dispose();
  }
}
