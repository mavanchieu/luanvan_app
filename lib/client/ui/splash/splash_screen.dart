import 'package:app_lv/client/ui/login/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:lottie/lottie.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // return Container(
    //   width: MediaQuery.of(context).size.width,
    //   height: MediaQuery.of(context).size.height,
    //   child: AnimatedSplashScreen(
    //     splash: SizedBox(
    //       width: 300,
    //       height: 300,
    //       child: Lottie.asset(
    //         "assets/video/nike.mp4",
    //         width: 300,
    //       ),
    //     ),
    //     nextScreen: const LoginScreen(),
    //     backgroundColor: Color.fromARGB(255, 198, 136, 136),
    //   ),
    // );

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Shop Quần Áo",
          style: GoogleFonts.robotoCondensed(
            fontSize: 25,
            color: Colors.white,
          ),
        ),
        backgroundColor: Color.fromARGB(255, 0, 212, 240),
        centerTitle: true,
        //leading: const Icon(Icons.arrow_back),
        actions: const [
          // Icon(Icons.search),
        ],
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(3000),
          ),
        ),

        bottom: const PreferredSize(
          preferredSize: Size.fromHeight(30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
          ),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [],
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 60),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black,
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const LoginScreen(),
                  ),
                );
              },
              child: Text(
                "Tiếp theo",
                style: GoogleFonts.aBeeZee(
                  fontSize: 17,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
