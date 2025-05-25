import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';


class History extends StatefulWidget {
  const History({super.key});

  @override
  State<History> createState() => _historyState();
}

class _historyState extends State<History> {
  //final Future<FirebaseApp> _fApp = Firebase.initializeApp();
  final DatabaseReference = FirebaseDatabase.instance.ref("scans");
  bool _isLoading = true;

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: Color.fromARGB(255, 201, 223, 248),
      appBar: AppBar(
        title: Text(
          "History",
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontFamily: 'Poppins',
            color: Colors.black,
            fontSize: 18,
          ),
        ),
        centerTitle: true,
        backgroundColor: Color.fromARGB(255, 164, 202, 247),
        elevation: 10,
      ),
      body: RefreshIndicator(
        color: Colors.blue,
        onRefresh: () async {
          await Future.delayed(const Duration(seconds: 1));
          setState(() {});
          return Future.value();
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16.0),
          child: FirebaseAnimatedList(
            query: DatabaseReference.orderByChild('timestamp').limitToLast(100),
          sort: (a, b) => b.key!.compareTo(a.key!), // Tri inverse
          duration: Duration(milliseconds: 300),
          defaultChild: Center(
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
            ),
          ),
            itemBuilder: (context, snapshot, animation, index) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                child: Container(
                  clipBehavior: Clip.antiAlias,
                  height: 100,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.black,
                      width: 1,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: const Color.fromARGB(255, 220, 198, 170).withOpacity(0.5),
                        spreadRadius: 2,
                        blurRadius: 3,
                        offset: const Offset(0, 0),
                      ),
                    ],
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white, // Added background color for better visibility
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(right: 8.0, top: 5, bottom: 5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Image.asset(
                                snapshot.child("access").value.toString()=="granted" ?
                                "assets/images/check.png" :"assets/images/cancel.png",
                                width: 80,
                              ),
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  snapshot.child("access").value.toString()=="granted" ?
                                  snapshot.child("owner").value.toString()+"'s Card Detected"
                                  : "Alert! Unknown Tag!",
                                  style: const TextStyle(
                                    fontFamily: 'Poppins',
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600),
                                ),
                                const SizedBox(height: 4), // Added vertical spacing
                                Text(
                                  "Card id: "+snapshot.child("uid").value.toString(),
                                  style: const TextStyle(
                                    fontFamily: 'Poppins',
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600),
                                ),
                                const SizedBox(height: 4), // Added vertical spacing
                                Text(
                                  "Date: " + snapshot.child("date").value.toString() + "   Time: "+snapshot.child("timestamp").value.toString(),
                                  style: const TextStyle(
                                    fontFamily: 'Poppins',
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
