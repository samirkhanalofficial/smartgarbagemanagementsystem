import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sgms/functions/CustomArguments.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  var history = [];
  late CustomArguments args;
  int attempt = 0;
  bool isloading = true;
  refresh() async {
    var temp = "nodata";
    if (attempt != 0) {
      temp = args.rn;
      CollectionReference pickups =
          FirebaseFirestore.instance.collection('pickups');
      pickups.where('id', isEqualTo: temp.toString()).get().then((value) {
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
  }

  @override
  void initState() {
    refresh();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    args = ModalRoute.of(context)!.settings.arguments as CustomArguments;
    if (attempt == 0) {
      attempt++;
      refresh();
    }

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
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context)
              .pushNamed(
            "/dashboard/add",
            arguments: CustomArguments(args.rn),
          )
              .then((value) {
            isloading = true;
            setState(() {});
            refresh();
          });
        },
        child: const Icon(Icons.add),
        backgroundColor: Colors.black,
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
                                InkWell(
                                  onTap: temp["status"].toString() == "pending"
                                      ? () {
                                          FirebaseFirestore.instance
                                              .collection("pickups")
                                              .doc(history[i].id.toString())
                                              .delete()
                                              .then((value) {
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(
                                              const SnackBar(
                                                content: Text(
                                                    "Deleted Successfully"),
                                                backgroundColor: Colors.green,
                                              ),
                                            );
                                            isloading = true;
                                            setState(() {});
                                            refresh();
                                          }).onError((error, stackTrace) {
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(
                                              const SnackBar(
                                                content: Text("Error Deleting"),
                                                backgroundColor: Colors.red,
                                              ),
                                            );
                                          });
                                        }
                                      : null,
                                  child: Padding(
                                    padding: const EdgeInsets.all(18.0),
                                    child: Wrap(
                                      alignment: WrapAlignment.center,
                                      crossAxisAlignment:
                                          WrapCrossAlignment.center,
                                      children: [
                                        Icon(
                                          Icons.delete,
                                          color: temp["status"].toString() ==
                                                  "pending"
                                              ? Colors.red
                                              : Colors.grey,
                                        ),
                                        const Text(
                                          "Delete",
                                        ),
                                      ],
                                    ),
                                  ),
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
