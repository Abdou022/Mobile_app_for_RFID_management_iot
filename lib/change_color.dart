import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:firebase_database/firebase_database.dart';

class ChangeColor extends StatefulWidget {
  const ChangeColor({super.key});

  @override
  State<ChangeColor> createState() => _ChangeColorState();
}

class _ChangeColorState extends State<ChangeColor> {
  Color color = Colors.white;
  final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey = GlobalKey<ScaffoldMessengerState>();

  @override
  Widget build(BuildContext context) {
    return ScaffoldMessenger(
      key: scaffoldMessengerKey,
      child: Scaffold(
        backgroundColor: Color.fromARGB(255, 201, 223, 248),
        appBar: AppBar(
          title: Text("Change Color",
              style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Poppins',
                  color: Colors.black,
                  fontSize: 18)),
          centerTitle: true,
          backgroundColor: Color.fromARGB(255, 164, 202, 247),
          elevation: 10,
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: color,
                ),
                width: 120,
                height: 120,
              ),
              SizedBox(height: 20),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(horizontal: 24),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  backgroundColor: Color.fromARGB(255, 55, 108, 177),
                ),
                onPressed: () => pickColor(context),
                child: Text(
                  "Pick Color",
                  style: TextStyle(
                    fontSize: 24, 
                    fontFamily: 'Poppins', 
                    color: Colors.white
                  ),
                )
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget buildColorPicker() => ColorPicker(
    pickerColor: color,
    enableAlpha: false,
    onColorChanged: (color) => setState(() => this.color = color),
  );

  Future<void> pickColor(BuildContext context) async {
    final newColor = await showDialog<Color>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          "Pick Your Color:", 
          style: TextStyle(
            color: Colors.black, 
            fontFamily: 'Poppins', 
            fontWeight: FontWeight.bold
          ),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            buildColorPicker(),
            TextButton(
              onPressed: () => Navigator.pop(context, color),
              child: Text(
                'SELECT',
                style: TextStyle(
                  fontSize: 20, 
                  fontFamily: 'Poppins', 
                  color: Colors.black
                ),
              )
            ),
          ],
        ),
      ),
    );

    if (newColor != null) {
      setState(() => color = newColor);
      try {
        await FirebaseDatabase.instance.ref("settings/led_color").set({
          "red": newColor.red,
          "green": newColor.green,
          "blue": newColor.blue,
        });
        scaffoldMessengerKey.currentState?.showSnackBar(
          SnackBar(
            backgroundColor: Color.fromARGB(255, 16, 119, 30),
            content: Text("Color saved successfully!", style: TextStyle(fontFamily: 'Poppins', color: Colors.white,fontSize: 16),))
        );
      } catch (e) {
        scaffoldMessengerKey.currentState?.showSnackBar(
          SnackBar(
            backgroundColor: Color.fromARGB(255, 187, 7, 7),
            content: Text("Failed to save color: $e", style: TextStyle(fontFamily: 'Poppins', color: Colors.white,fontSize: 16),))
        );
      }
    }
  }
}