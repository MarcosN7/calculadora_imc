import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class IMC {
  double weight = 0;
  double height = 0;
  double result = 0;
  String interpretation = "";

  IMC(this.weight, this.height);
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
  IMC imc = IMC(0, 0);
  List<IMC> imcList = [];

  void calculateBMI() {
    if (imc.weight > 0 && imc.height > 0) {
      double bmi = imc.weight / (imc.height * imc.height);
      setState(() {
        imc.result = bmi;

        if (bmi < 16) {
          imc.interpretation = "Magreza grave";
        } else if (bmi < 17) {
          imc.interpretation = "Magreza moderada";
        } else if (bmi < 18.5) {
          imc.interpretation = "Magreza leve";
        } else if (bmi < 25) {
          imc.interpretation = "Saudável";
        } else if (bmi < 30) {
          imc.interpretation = "Sobrepeso";
        } else if (bmi < 35) {
          imc.interpretation = "Obesidade Grau I";
        } else if (bmi < 40) {
          imc.interpretation = "Obesidade Grau II";
        } else {
          imc.interpretation = "Obesidade Grau III";
        }

        imcList.add(imc);
        imc = IMC(0, 0); // Limpa os campos após o cálculo
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
                onChanged: (value) => imc.weight = double.tryParse(value) ?? 0,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'Peso (kg)',
                ),
              ),
              const SizedBox(height: 16.0),
              TextField(
                onChanged: (value) => imc.height = double.tryParse(value) ?? 0,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
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
                'IMC: ${imc.result.toStringAsFixed(1)}',
                style: const TextStyle(fontSize: 24),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8.0),
              Text(
                imc.interpretation,
                style: const TextStyle(fontSize: 18),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16.0),
              ListView.builder(
                shrinkWrap: true,
                itemCount: imcList.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(
                        'IMC: ${imcList[index].weight} / ${imcList[index].height}'),
                    subtitle: Text(
                        'Resultado: ${imcList[index].result.toStringAsFixed(1)} - ${imcList[index].interpretation}'),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
