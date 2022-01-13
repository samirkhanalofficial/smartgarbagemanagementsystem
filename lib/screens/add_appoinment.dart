import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sgms/functions/CustomArguments.dart';

class AddAppoinment extends StatefulWidget {
  const AddAppoinment({Key? key}) : super(key: key);

  @override
  _AddAppoinmentState createState() => _AddAppoinmentState();
}

class _AddAppoinmentState extends State<AddAppoinment> {
  String _name = "", _phone = "", _house = "";
  DateTime _date = DateTime.now();
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as CustomArguments;

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Request Pickup"),
          leading: IconButton(
              onPressed: () => Navigator.of(context).pop(),
              icon: Transform.rotate(
                angle: -40,
                child: const Icon(
                  Icons.add,
                ),
              )),
        ),
        body: ListView(
          children: [
            Center(
              child: SizedBox(
                height: 200,
                child: Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: Image.asset("assets/homepick.jpg"),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text("Registration no : " + args.rn.toString()),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 18.0, vertical: 8),
              child: Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(25)),
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 25,
                      color: Colors.black12,
                      spreadRadius: 1,
                    ),
                  ],
                ),
                height: 65,
                child: TextField(
                  keyboardType: TextInputType.name,
                  onChanged: (val) {
                    _name = val;
                  },
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                    alignLabelWithHint: true,
                    label: Text("Enter Your Name"),
                  ),
                ),
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 18.0, vertical: 8),
              child: Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(25)),
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 25,
                      color: Colors.black12,
                      spreadRadius: 1,
                    ),
                  ],
                ),
                height: 65,
                child: TextField(
                  onChanged: (val) {
                    _phone = val;
                  },
                  keyboardType: TextInputType.phone,
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                    alignLabelWithHint: true,
                    label: Text("Enter Your phone"),
                  ),
                ),
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 18.0, vertical: 8),
              child: Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(25)),
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 25,
                      color: Colors.black12,
                      spreadRadius: 1,
                    ),
                  ],
                ),
                height: 65,
                child: TextField(
                  onChanged: (val) {
                    _house = val;
                  },
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                    alignLabelWithHint: true,
                    label: Text("Enter House No."),
                  ),
                ),
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 18.0, vertical: 8),
              child: Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(25)),
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 25,
                      color: Colors.black12,
                      spreadRadius: 1,
                    ),
                  ],
                ),
                height: 65,
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: () {
                      showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime.now(),
                        lastDate: DateTime(
                          DateTime.now().year,
                          DateTime.now().month + 1,
                          DateTime.now().day,
                        ),
                        currentDate: DateTime.now(),
                      ).then(
                        (value) {
                          setState(() {
                            _date =
                                DateTime(value!.year, value.month, value.day);
                          });
                        },
                      );
                    },
                    child: Center(
                        child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12.0),
                          child: Text(
                            "Date (MM/DD): ${_date.month.toString()} / ${_date.day.toString()}  ",
                            style: const TextStyle(
                              fontSize: 16,
                              color: Colors.black54,
                            ),
                          ),
                        ),
                      ],
                    )),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(18.0),
              child: ElevatedButton(
                onPressed: () {
                  CollectionReference pickups =
                      FirebaseFirestore.instance.collection('pickups');
                  pickups.add({
                    "id": args.rn,
                    "name": _name,
                    "phone": _phone,
                    "house": _house,
                    "year": _date.year,
                    "month": _date.month,
                    "day": _date.day,
                    "status": "pending"
                  }).then(
                    (value) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("Successfully requested for pickup."),
                          backgroundColor: Colors.greenAccent,
                        ),
                      );
                      Navigator.of(context).pop();
                    },
                  ).catchError((err) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("Internet Connection Error"),
                        backgroundColor: Colors.red,
                      ),
                    );
                  });
                },
                child: const Text("Request Pickup"),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.all(18),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
