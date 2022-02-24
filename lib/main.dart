import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  TextEditingController _peopleController = TextEditingController();
  TextEditingController _totalController = TextEditingController();

  var dropdownvalue = 0;
  var items = [0, 5, 7];
  double get perPerson {
    if (_peopleController.text == "") {
      return 0;
    }
    return actualAmount / int.parse(_peopleController.text);
  }

  double get actualAmount {
    if (_totalController.text == "") {
      return 0.0;
    }
    var total = int.parse(_totalController.text);
    return total + (total * dropdownvalue / 100);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("SplitMoney"),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 12, right: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _peopleController,
              onChanged: (value) {
                setState(() {});
              },
              keyboardType: TextInputType.number,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              decoration: const InputDecoration(
                  icon: Icon(
                    Icons.people,
                    color: Colors.blue,
                  ),
                  label: Text("Number of People")),
            ),
            const SizedBox(
              height: 12,
            ),
            TextField(
              controller: _totalController,
              onChanged: (value) {
                setState(() {});
              },
              keyboardType: TextInputType.number,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              decoration: const InputDecoration(
                  icon: Icon(Icons.attach_money, color: Colors.green),
                  label: Text("Total Amount")),
            ),
            const SizedBox(
              height: 12,
            ),
            Row(
              children: [
                const Expanded(child: Text("Tax Percentage")),
                Expanded(
                    child: DropdownButton<int>(
                  isExpanded: true,
                  value: dropdownvalue,
                  items: items.map((int items) {
                    return DropdownMenuItem(
                      value: items,
                      child: Center(
                          child: Text(
                        items.toString(),
                        textAlign: TextAlign.center,
                      )),
                    );
                  }).toList(),
                  onChanged: (int? newValue) {
                    //var total = int.parse(_totalController.text);
                    setState(() {
                      dropdownvalue = newValue!;
                      //actualAmount = total + (total * newValue / 100);
                    });
                  },
                )),
              ],
            ),
            const SizedBox(
              height: 12,
            ),
            Text("Actual Amount is $actualAmount"),
            const SizedBox(
              height: 12,
            ),
            Text("Split money per person is $perPerson")
          ],
        ),
      ),
    );
  }
}
