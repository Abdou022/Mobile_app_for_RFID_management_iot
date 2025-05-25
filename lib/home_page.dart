import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:safe_pass/change_color.dart';
import 'package:safe_pass/control_led.dart';
import 'package:safe_pass/history.dart';
import 'package:safe_pass/manage_cards.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: Color.fromARGB(255, 201, 223, 248),
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              const SizedBox(height: 60),
            Image.asset(
              "assets/images/safe_pass_name.png",
              width: 250,
            ),
            Expanded(child: SizedBox(), flex: 1,),

              Card(
                color: Color.fromARGB(255, 164, 202, 247),
                elevation: 8,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                margin: const EdgeInsets.all(24),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(
                        height: 40,
                        width: 200,
                        child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                backgroundColor: Color.fromARGB(255, 55, 108, 177), // background color
                                ),
                        onPressed: () {
                          Navigator.push(context, CupertinoPageRoute(builder: (context) => const ManageCards()));
                        },
                        child: const Text('Manage Cards', style: TextStyle(color: Colors.white,fontSize: 16,fontWeight: FontWeight.bold,fontFamily: 'Poppins'),),
                      ),
                      ),
                      const SizedBox(height: 20),
                      SizedBox(
                        height: 40,
                        width: 200,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  backgroundColor: Color.fromARGB(255, 55, 108, 177), // background color
                                  ),
                          onPressed: () {
                            Navigator.push(context, CupertinoPageRoute(builder: (context) =>  ControlLED()));
                          },
                          child: const Text('Control LED', style: TextStyle(color: Colors.white,fontSize: 16,fontWeight: FontWeight.bold,fontFamily: 'Poppins'),),
                        ),
                      ),
                      const SizedBox(height: 20),
                      SizedBox(
                        height: 40,
                        width: 200,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  backgroundColor: Color.fromARGB(255, 55, 108, 177), // background color
                                  ),
                          onPressed: () {
                            Navigator.push(context, CupertinoPageRoute(builder: (context) => const ChangeColor()));
                          },
                          child: const Text('Change Color', style: TextStyle(color: Colors.white,fontSize: 16,fontWeight: FontWeight.bold,fontFamily: 'Poppins'),),
                        ),
                      ),
                      const SizedBox(height: 20),
                      SizedBox(
                        height: 40,
                        width: 200,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  backgroundColor: Color.fromARGB(255, 55, 108, 177), // background color
                                  ),
                          onPressed: () {
                            Navigator.push(context, CupertinoPageRoute(builder: (context) => const History()));
                          },
                          child: const Text('History', style: TextStyle(color: Colors.white,fontSize: 16,fontWeight: FontWeight.bold,fontFamily: 'Poppins'),),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(child: SizedBox(), flex: 2,),
            ],
          ),
        ),
      ),
    );
  }
}