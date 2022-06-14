import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/services.dart';
import 'home_screen.dart';

class SecondScreen extends StatefulWidget{
  const SecondScreen({Key? key}) : super(key: key);

  @override
  State<SecondScreen> createState() => _SecondScreenState();
}

class _SecondScreenState extends State<SecondScreen> {

  final controllerPercent = TextEditingController();

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
        title: const Text("Settings")
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
            controller: controllerPercent,
            style: const TextStyle(fontWeight: FontWeight.bold),
            cursorColor: Colors.red,
            decoration: const InputDecoration(labelText: "Set Percent", 
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
          ElevatedButton(
          style: ButtonStyle(backgroundColor: MaterialStateProperty.all<Color>(Colors.red)),
          onPressed: (){
            setState(() {
              double percent = double.parse(controllerPercent.text);

              setDefaultValues(percent);
            });

          }, 
          child: const Text("Save")),
        ],
      )),
  );
  }
}