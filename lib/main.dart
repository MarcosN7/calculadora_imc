import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart' as path_provider;
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final appDocumentDir = await path_provider.getApplicationDocumentsDirectory();
  Hive.init(
      appDocumentDir.path); // Use appDocumentDir.path instead of appDocumentDir
  await Hive.openBox<IMCData>('imcBox');
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

@HiveType(typeId: 1)
class IMCData extends HiveObject {
  @HiveField(0)
  double weight = 0;

  @HiveField(1)
  double height = 0;

  @HiveField(2)
  double result = 0;

  @HiveField(3)
  String interpretation = '';
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  TextEditingController weightController = TextEditingController();
  TextEditingController heightController = TextEditingController();

  // ...

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
              // ... Other widgets

              Expanded(
                child: ValueListenableBuilder<Box<IMCData>>(
                  valueListenable: Hive.box<IMCData>('imcBox').listenable(),
                  builder: (context, box, _) {
                    return ListView.builder(
                      itemCount: box.length,
                      itemBuilder: (context, index) {
                        IMCData imcData = box.getAt(index)!;
                        return ListTile(
                          title:
                              Text('IMC: ${imcData.result.toStringAsFixed(1)}'),
                          subtitle: Text(imcData.interpretation),
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
