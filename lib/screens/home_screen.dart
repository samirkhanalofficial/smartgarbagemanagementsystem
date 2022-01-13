import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sgms/functions/CustomArguments.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  late Animation<double> left, left1;
  late TextEditingController rn;
  late AnimationController controller;
  late AnimationController controller2;
  animate() {
    controller =
        AnimationController(duration: const Duration(seconds: 2), vsync: this);
    controller2 =
        AnimationController(duration: const Duration(seconds: 2), vsync: this);
    Tween<double> tween = Tween(begin: 0, end: 1);
    left = tween.animate(controller)
      ..addListener(() {
        setState(() {});
      });
    left1 = tween.animate(controller2)
      ..addListener(() {
        setState(() {});
      });

    controller.forward();
    Future.delayed(const Duration(milliseconds: 1500), () {
      controller2.forward();
    });
  }

  @override
  void initState() {
    rn = TextEditingController();
    animate();
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  navigate(BuildContext context) {
    if (rn.text.isEmpty || rn.text == "") {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Please Provide correct registration number."),
        ),
      );
      return;
    }
    Navigator.of(context).pushNamed(
      "/dashboard",
      arguments: CustomArguments(rn.text),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        body: SafeArea(
          child: ListView(
            physics: const BouncingScrollPhysics(),
            children: [
              const SizedBox(
                height: 58,
              ),
              SizedBox(
                height: 300,
                child: Stack(
                  children: [
                    Positioned(
                      top: 1,
                      left: left.value * 50 - 50,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(999),
                          child: SizedBox(
                            width: 100,
                            height: 100,
                            child: Image.asset(
                              "assets/screen1.png",
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      top: 120,
                      left: left.value * 70 - 70,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "Hello,",
                          style: GoogleFonts.pacifico(
                            textStyle: const TextStyle(
                              fontSize: 25,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      top: 150,
                      left: left.value * 120 - 120,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "I am Smart Garbage \nManagement System.",
                          style: GoogleFonts.pacifico(
                            textStyle: const TextStyle(
                              fontSize: 25,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      top: 150,
                      left: left1.value * 1000 - 1000,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "\n\n\nPlease, enter your Registration Number:",
                          style: GoogleFonts.pacifico(
                            textStyle: const TextStyle(
                              fontSize: 20,
                            ),
                          ),
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
                            controller: rn,
                            onSubmitted: (val) {
                              navigate(context);
                            },
                            keyboardType: TextInputType.number,
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.all(20),
                              label: Text("Enter Registration Number"),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: FloatingActionButton(
                          onPressed: () {
                            navigate(context);
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
              const SizedBox(
                height: 100,
              ),
              Center(
                child: InkWell(
                  onTap: () {
                    Navigator.of(context).pushNamed("/admin");
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: Wrap(
                      crossAxisAlignment: WrapCrossAlignment.center,
                      children: const [
                        Icon(
                          Icons.admin_panel_settings,
                        ),
                        Text("Admin Panel"),
                      ],
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
