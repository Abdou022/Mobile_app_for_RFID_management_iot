import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';

class ControlLED extends StatefulWidget {
  @override
  _ControlLEDState createState() => _ControlLEDState();
}

class _ControlLEDState extends State<ControlLED> {
  final DatabaseReference _dbRef = FirebaseDatabase.instance.ref('settings');
  bool _ledState = true;
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey = GlobalKey<RefreshIndicatorState>();

  @override
  void initState() {
    super.initState();
    _loadInitialState();
  }

  Future<void> _loadInitialState() async {
    final snapshot = await _dbRef.child('led_state').once();
    if (snapshot.snapshot.value != null) {
      setState(() {
        _ledState = snapshot.snapshot.value as bool;
      });
    }
  }

  Future<void> _toggleLED() async {
    final newState = !_ledState;
    await _dbRef.child('led_state').set(newState);
    setState(() {
      _ledState = newState;
    });
  }

  Future<void> _refreshData() async {
    await _loadInitialState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 201, 223, 248),
      appBar: AppBar(
        title: Text("Control LED",
            style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontFamily: 'Poppins',
                color: Colors.black,
                fontSize: 18)),
        centerTitle: true,
        backgroundColor: Color.fromARGB(255, 164, 202, 247),
        elevation: 10,
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () => _refreshIndicatorKey.currentState?.show(),
          ),
        ],
      ),
      body: RefreshIndicator(
        key: _refreshIndicatorKey,
        onRefresh: _refreshData,
        color: Colors.blue,
        backgroundColor: Colors.white,
        child: SingleChildScrollView(
          physics: AlwaysScrollableScrollPhysics(),
          child: Container(
            height: MediaQuery.of(context).size.height,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'RGB LED State',
                    style: TextStyle(
                      fontSize: 24, 
                      fontFamily: 'Poppins', 
                      fontWeight: FontWeight.bold
                    ),
                  ),
                  SizedBox(height: 20),
                  Switch(
                    value: _ledState,
                    onChanged: (value) => _toggleLED(),
                    activeColor: Colors.blue,
                  ),
                  SizedBox(height: 10),
                  Text(
                    _ledState ? 'ON' : 'OFF',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: _ledState ? Colors.green : Colors.red,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}