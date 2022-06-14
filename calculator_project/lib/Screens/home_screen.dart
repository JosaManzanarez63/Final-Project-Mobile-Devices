import 'package:calculator_project/Screens/second_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';


class HomeScreen extends StatefulWidget{
  const HomeScreen({Key? key}) : super(key: key);
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  final controllerAmount = TextEditingController();
  final controllerPercent = TextEditingController();
  double tip = 0;

void setDefaultValues(double value)async{
  final prefs = await SharedPreferences.getInstance();
  await prefs.setDouble('percent', value);
}

Future<double?>getDefaultValues()async{
  final prefs = await SharedPreferences.getInstance();
  final double percent = prefs.getDouble('percent')?? 15;

  return percent;
}

  @override
  Widget build(BuildContext context) {
    getDefaultValues().then((value) => {
      controllerPercent.text = value.toString()
    });

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: const Text("Home Screen")
      ),
      drawer: Drawer(
    child: ListView(
      padding: EdgeInsets.zero,
      children: <Widget>[
        const DrawerHeader(
          decoration: BoxDecoration(
            color: Colors.red,
          ),
          child: Text(
            'Menu',
            style: TextStyle(
              color: Colors.white,
              fontSize: 24,
            ),
          ),
        ),
        ListTile(
          leading: const Icon(Icons.home),
          title: const Text('Home Screen'),
          onTap: (){
          final route = MaterialPageRoute(builder: (context) => const HomeScreen());
          Navigator.push(context, route);
          },
        ),
        ListTile(
          leading: const Icon(Icons.settings),
          title: const Text('Settings'),
          onTap: (){
          final route = MaterialPageRoute(builder: (context) => const SecondScreen());
          Navigator.push(context, route);
          },
        ),
      ],
    ),
  ),
      body: Container(
          padding: const EdgeInsets.all(40.0),
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          TextField(
            controller: controllerAmount,
            style: const TextStyle(fontWeight: FontWeight.bold),
            cursorColor: Colors.red,
            decoration: const InputDecoration(labelText: "Amount", 
            labelStyle: TextStyle(
            color: Color.fromARGB(255, 144, 40, 33),  
            fontSize: 25, 
            fontWeight: FontWeight.bold
            ),
            focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.red, width: 1.5)),
            ),
            keyboardType: TextInputType.number,
            inputFormatters: <TextInputFormatter>[
            FilteringTextInputFormatter.digitsOnly
            ], // Only numbers can be entered
          ),

          TextField(
            controller: controllerPercent,
            style: const TextStyle(fontWeight: FontWeight.bold),
            cursorColor: Colors.red,
            decoration: const InputDecoration(labelText: "Porcent",
            labelStyle: TextStyle(
            color: Color.fromARGB(255, 144, 40, 33),
            fontSize: 25, 
            fontWeight: FontWeight.bold
            ),
            focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.red, width: 1.5))
            ),
            keyboardType: TextInputType.number,
            inputFormatters: <TextInputFormatter>[
            FilteringTextInputFormatter.digitsOnly
            ], // Only numbers can be entered
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
            child: Text("Tip to pay \$$tip"),
          ),
          
          
          ElevatedButton(
          style: ButtonStyle(backgroundColor: MaterialStateProperty.all<Color>(Colors.red)),
          onPressed: (){
            setState(() {
              double amount = double.parse(controllerAmount.text);
              double percent = double.parse(controllerPercent.text);

              tip = amount*percent/100;
              setDefaultValues(percent);
            });

          }, 
          child: const Text("Calculate")),
        ],
      )),
    );
  }
}