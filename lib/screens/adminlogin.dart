import 'package:flutter/material.dart';

class AdminLogin extends StatefulWidget {
  const AdminLogin({Key? key}) : super(key: key);

  @override
  _AdminLoginState createState() => _AdminLoginState();
}

class _AdminLoginState extends State<AdminLogin> {
  String email = "", password = "";
  // change these admin email and password . using these as it is is insecure.
  // makesure to create an api and check admin credientials from there
  // thus you can remove these and create https request to check validation.
  // since this is just a project demo , i am not doing so.
  String adminemail = "admin@admin.com";
  String adminpassword = "admin@123";
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Admin Login"),
        ),
        resizeToAvoidBottomInset: true,
        body: SafeArea(
          child: ListView(
            physics: const BouncingScrollPhysics(),
            children: [
              SizedBox(
                height: 300,
                child: ListView(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(0.0),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(0),
                        child: SizedBox(
                          width: 100,
                          height: 200,
                          child: Image.asset(
                            "assets/screen1.png",
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                    const Text(
                      "\n Welcome, Admin",
                      style: TextStyle(
                        fontSize: 25,
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        "Please stay away if you are not the admin.",
                        style: TextStyle(
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 50,
              ),
              Center(
                child: Row(
                  children: [
                    const Center(
                      child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: FloatingActionButton(
                          onPressed: null,
                          backgroundColor: Colors.black,
                          child: Icon(
                            Icons.email,
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(18.0),
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
                          height: 74,
                          child: TextField(
                            keyboardType: TextInputType.emailAddress,
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.all(20),
                              label: Text("Enter Admin email"),
                            ),
                            onChanged: (text) {
                              email = text;
                            },
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Center(
                child: Row(
                  children: [
                    const Center(
                      child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: FloatingActionButton(
                          onPressed: null,
                          backgroundColor: Colors.black,
                          child: Icon(
                            Icons.security_rounded,
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(18.0),
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
                          height: 74,
                          child: TextField(
                            keyboardType: TextInputType.text,
                            obscureText: true,
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.all(20),
                              label: Text("Enter Admin Password"),
                            ),
                            onChanged: (text) {
                              password = text;
                            },
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Center(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: FloatingActionButton(
                    onPressed: () {
                      if (email == adminemail && password == adminpassword) {
                        Navigator.of(context).pushNamed("/admin/dashboard");
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text("Incorrect Username and Password."),
                            backgroundColor: Colors.red,
                          ),
                        );
                      }
                    },
                    backgroundColor: Colors.black,
                    child: const Icon(
                      Icons.arrow_forward,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
