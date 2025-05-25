import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ManageCards extends StatefulWidget {
  const ManageCards({super.key});

  @override
  State<ManageCards> createState() => _ManageCardsState();
}

class _ManageCardsState extends State<ManageCards> {
  final DatabaseReference _cardsRef = FirebaseDatabase.instance.ref('authorized_cards');
  final TextEditingController _uidController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  Map<dynamic, dynamic> _cards = {};
  bool _isLoading = true; // Initialize in your state

  @override
  void initState() {
    super.initState();
    _loadCards();
  }

  Future<void> _loadCards() async {
    DatabaseEvent event = await _cardsRef.once();
    setState(() {
      _cards = event.snapshot.value as Map<dynamic, dynamic>? ?? {};
      _isLoading = false;
    });
  }

  Future<void> _addCard() async {
    if (_uidController.text.isNotEmpty && _nameController.text.isNotEmpty) {
      await _cardsRef.child(_uidController.text).set(_nameController.text);
      _uidController.clear();
      _nameController.clear();
      await _loadCards().whenComplete(() => Fluttertoast.showToast(
            msg: "Card Added/Updated successfully!",
            toastLength: Toast.LENGTH_LONG,
            backgroundColor: Colors.black.withOpacity(0.7),
          ));
    }
  }

  Future<void> _removeCard(String uid) async {
    await _cardsRef.child(uid).remove();
    await _loadCards().whenComplete(() => Fluttertoast.showToast(
          msg: "Card Deleted Successfully!",
          toastLength: Toast.LENGTH_LONG,
          backgroundColor: Colors.black.withOpacity(0.7),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 201, 223, 248),
      appBar: AppBar(
        title: Text("Manage Cards",
            style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontFamily: 'Poppins',
                color: Colors.black,
                fontSize: 18)),
        centerTitle: true,
        backgroundColor: Color.fromARGB(255, 164, 202, 247),
        elevation: 10,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: _uidController,
                    cursorColor: Color.fromARGB(255, 36, 71, 116),
                    style: const TextStyle(
                        fontFamily: 'Poppins', fontWeight: FontWeight.w600),
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      labelText: 'Card UID',
                      hintText: "Example: 93F08A0C",
                      labelStyle: const TextStyle(
                          color: Color.fromARGB(255, 55, 108, 177),
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          fontFamily: 'Poppins'),
                      prefixIcon: const Icon(CupertinoIcons.rectangle_dock,
                          size: 25, color: Color.fromARGB(255, 97, 84, 72)),
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 50, vertical: 20),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: const BorderSide(
                              color: Color.fromARGB(255, 36, 71, 116),
                              width: 2),
                          gapPadding: 10),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: const BorderSide(
                              color: Color.fromARGB(255, 36, 71, 116),
                              width: 2),
                          gapPadding: 10),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: _nameController,
                    cursorColor: Color.fromARGB(255, 36, 71, 116),
                    style: const TextStyle(
                        fontFamily: 'Poppins', fontWeight: FontWeight.w600),
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      labelText: 'Owner Name',
                      hintText: "Enter Card's Owner Name",
                      labelStyle: const TextStyle(
                          color: Color.fromARGB(255, 55, 108, 177),
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          fontFamily: 'Poppins'),
                      prefixIcon: const Icon(CupertinoIcons.person_crop_circle,
                          size: 25, color: Color.fromARGB(255, 97, 84, 72)),
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 50, vertical: 20),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: const BorderSide(
                              color: Color.fromARGB(255, 36, 71, 116),
                              width: 2),
                          gapPadding: 10),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: const BorderSide(
                              color: Color.fromARGB(255, 36, 71, 116),
                              width: 2),
                          gapPadding: 10),
                    ),
                  ),
                ),
                SizedBox(height: 16),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    backgroundColor:
                        Color.fromARGB(255, 55, 108, 177), // background color
                  ),
                  onPressed: _addCard,
                  child: Text(
                    'Add Card',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Poppins'),
                  ),
                ),
              ],
            ),
          ),
          Center(
            child: Text(
              "List Of Cards",
              style: TextStyle(
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.bold,
                  fontSize: 24),
            ),
          ),
          Expanded(
            child: _isLoading
                ? Center(child: CircularProgressIndicator( valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),))
                : ListView.builder(
                    itemCount: _cards.length,
                    itemBuilder: (context, index) {
                      String uid = _cards.keys.elementAt(index);
                      String name = _cards[uid];
                      return Container(
                        margin:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                        decoration: BoxDecoration(
                          border: Border.all(
                              color: Color.fromARGB(255, 36, 71, 116),
                              width: 2),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: ListTile(
                          title: Text(
                            name,
                            style: TextStyle(
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.bold),
                          ),
                          subtitle: Text(
                            "UID: $uid",
                            style: TextStyle(
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.bold),
                          ),
                          trailing: IconButton(
                            icon: Icon(Icons.delete),
                            onPressed: () => _removeCard(uid),
                          ),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
