import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calculadora IMC',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  TextEditingController weightController = TextEditingController();
  TextEditingController heightController = TextEditingController();

  String result = "";
  String interpretation = "";

  void calculateBMI() {
    double weight = double.tryParse(weightController.text) ?? 0;
    double height = double.tryParse(heightController.text) ?? 0;

    if (weight > 0 && height > 0) {
      double bmi = weight / (height * height);
      setState(() {
        result = bmi.toStringAsFixed(1);

        if (bmi < 16) {
          interpretation = "Magreza grave";
        } else if (bmi < 17) {
          interpretation = "Magreza moderada";
        } else if (bmi < 18.5) {
          interpretation = "Magreza leve";
        } else if (bmi < 25) {
          interpretation = "Saudável";
        } else if (bmi < 30) {
          interpretation = "Sobrepeso";
        } else if (bmi < 35) {
          interpretation = "Obesidade Grau I";
        } else if (bmi < 40) {
          interpretation = "Obesidade Grau II";
        } else {
          interpretation = "Obesidade Grau III";
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Calculadora IMC'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 16.0),
              TextField(
                key: const Key('weightTextField'),
                controller: weightController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Peso (kg)',
                ),
              ),
              const SizedBox(height: 16.0),
              TextField(
                key: const Key('heightTextField'),
                controller: heightController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Altura (m)',
                ),
              ),
              const SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: calculateBMI,
                child: const Text('Calcular'),
              ),
              const SizedBox(height: 16.0),
              Text(
                'IMC: $result',
                style: TextStyle(fontSize: 24),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8.0),
              Text(
                interpretation,
                style: TextStyle(fontSize: 18),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
