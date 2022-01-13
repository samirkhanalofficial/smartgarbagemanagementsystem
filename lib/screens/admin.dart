import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Admin extends StatefulWidget {
  const Admin({Key? key}) : super(key: key);

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Admin> {
  var history = [];

  bool isloading = true;
  refresh() async {
    CollectionReference pickups =
        FirebaseFirestore.instance.collection('pickups');
    pickups.get().then((value) {
      history = value.docs;
      isloading = false;
      setState(() {});
    }).catchError((err) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Internet Connection Error"),
          backgroundColor: Colors.red,
        ),
      );
      isloading = false;
      setState(() {});
    });
  }

  @override
  void initState() {
    refresh();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Smart Garbage Management"),
        actions: [
          IconButton(
            onPressed: () {
              isloading = true;
              setState(() {});
              refresh();
            },
            icon: const Icon(
              Icons.refresh,
            ),
          )
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () {
          return refresh();
        },
        child: isloading
            ? const Center(
                child: SizedBox(
                  height: 50,
                  width: 50,
                  child: CircularProgressIndicator.adaptive(),
                ),
              )
            : history.isEmpty
                ? Center(
                    child: SizedBox(
                      height: 300,
                      child: Center(
                        child: Column(
                          children: [
                            Center(
                              child: SizedBox(
                                  height: 200,
                                  child: Image.asset("assets/bin.jpg")),
                            ),
                            const Center(
                                child: Text(
                                    " No History of Garbage Collections.")),
                          ],
                        ),
                      ),
                    ),
                  )
                : ListView.builder(
                    itemCount: history.length,
                    itemBuilder: (context, i) {
                      var temp = history[i];
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Card(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                const Icon(Icons.agriculture_sharp),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        const Text(
                                          "Name : ",
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Text(temp["name"].toString()),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        const Text(
                                          "Pickup Date : ",
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Text(temp["month"].toString() +
                                            " / " +
                                            temp["day"].toString()),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        const Text(
                                          "Phone : ",
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Text(temp["phone"].toString()),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        const Text(
                                          "House No. : ",
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Text(temp["house"].toString()),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        const Text(
                                          "Status : ",
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Text(
                                          temp["status"].toString(),
                                          style: TextStyle(
                                            color: temp["status"].toString() ==
                                                    "pending"
                                                ? Colors.black
                                                : temp["status"].toString() ==
                                                        "accepted"
                                                    ? Colors.blue
                                                    : temp["status"]
                                                                .toString() ==
                                                            "done"
                                                        ? Colors.green
                                                        : Colors.red,
                                            decoration:
                                                TextDecoration.underline,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        elevation: 0,
                                      ),
                                      onPressed: temp["status"].toString() ==
                                              "pending"
                                          ? () {
                                              FirebaseFirestore.instance
                                                  .collection("pickups")
                                                  .doc(history[i].id.toString())
                                                  .update({
                                                'status': 'accepted'
                                              }).then((value) {
                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(
                                                  const SnackBar(
                                                    content: Text(
                                                        "Accepeted Successfully"),
                                                    backgroundColor:
                                                        Colors.green,
                                                  ),
                                                );
                                                isloading = true;
                                                setState(() {});
                                                refresh();
                                              }).onError((error, stackTrace) {
                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(
                                                  const SnackBar(
                                                    content:
                                                        Text("Error Accepting"),
                                                    backgroundColor: Colors.red,
                                                  ),
                                                );
                                              });
                                            }
                                          : null,
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Wrap(
                                          alignment: WrapAlignment.center,
                                          crossAxisAlignment:
                                              WrapCrossAlignment.center,
                                          children: [
                                            Icon(
                                              Icons.check,
                                              color:
                                                  temp["status"].toString() ==
                                                          "pending"
                                                      ? Colors.green
                                                      : Colors.grey,
                                            ),
                                            const Text(
                                              "Accept",
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        elevation: 0,
                                      ),
                                      onPressed: temp["status"].toString() ==
                                              "pending"
                                          ? () {
                                              FirebaseFirestore.instance
                                                  .collection("pickups")
                                                  .doc(history[i].id.toString())
                                                  .update({
                                                'status': 'rejected'
                                              }).then((value) {
                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(
                                                  const SnackBar(
                                                    content: Text(
                                                        "Rejected Successfully"),
                                                    backgroundColor:
                                                        Colors.green,
                                                  ),
                                                );
                                                isloading = true;
                                                setState(() {});
                                                refresh();
                                              }).onError((error, stackTrace) {
                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(
                                                  const SnackBar(
                                                    content:
                                                        Text("Error Rejecting"),
                                                    backgroundColor: Colors.red,
                                                  ),
                                                );
                                              });
                                            }
                                          : null,
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Wrap(
                                          alignment: WrapAlignment.center,
                                          crossAxisAlignment:
                                              WrapCrossAlignment.center,
                                          children: [
                                            Icon(
                                              Icons.delete,
                                              color:
                                                  temp["status"].toString() ==
                                                          "pending"
                                                      ? Colors.red
                                                      : Colors.grey,
                                            ),
                                            const Text(
                                              "Reject",
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        elevation: 0,
                                      ),
                                      onPressed: temp["status"].toString() ==
                                              "accepted"
                                          ? () {
                                              FirebaseFirestore.instance
                                                  .collection("pickups")
                                                  .doc(history[i].id.toString())
                                                  .update({
                                                'status': 'done'
                                              }).then((value) {
                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(
                                                  const SnackBar(
                                                    content: Text(
                                                        "Completed  Successfully"),
                                                    backgroundColor:
                                                        Colors.green,
                                                  ),
                                                );
                                                isloading = true;
                                                setState(() {});
                                                refresh();
                                              }).onError((error, stackTrace) {
                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(
                                                  const SnackBar(
                                                    content: Text(
                                                        "Error Completing"),
                                                    backgroundColor: Colors.red,
                                                  ),
                                                );
                                              });
                                            }
                                          : null,
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Wrap(
                                          alignment: WrapAlignment.center,
                                          crossAxisAlignment:
                                              WrapCrossAlignment.center,
                                          children: [
                                            Icon(
                                              Icons.check_circle,
                                              color:
                                                  temp["status"].toString() ==
                                                          "accepted"
                                                      ? Colors.green
                                                      : Colors.grey,
                                            ),
                                            const Text(
                                              "Complete",
                                            ),
                                          ],
                                        ),
                                      ),
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
    );
  }
}
