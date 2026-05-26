import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/export.dart';
import 'package:get/route_manager.dart';
import 'package:world_skills/pages/about_page.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onPanUpdate: (details) {
          if (details.delta.dy < -10) {
            Get.to(
              () => AboutPage(),
              transition: Transition.downToUp,
              curve: Curves.easeIn,
              duration: 2.seconds,
            );
          }
        },
        child: Stack(
          children: [
            Positioned.fill(child: CustomPaint(painter: LampLight())),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Image.asset("assets/images/lamp.png", width: Get.width * .1),
                Text(
                  "Master Skills \n Change the World",
                  style: TextStyle(fontSize: 42, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
                Image.asset(
                  "assets/images/world-map.png",
                  width: Get.width * .6,
                ),
                Row(),
              ],
            ),
            RepeatingAnimationBuilder(
              repeatMode: RepeatMode.reverse,
              builder: (context, value, child) {
                return Align(alignment: Alignment(0, value), child: child);
              },
              animatable: Tween(begin: .8, end: .9),
              duration: 2.seconds,
              child: IconButton(
                onPressed: () {
                  Get.to(
                    () => AboutPage(),
                    transition: Transition.downToUp,
                    curve: Curves.easeIn,
                    duration: 2.seconds,
                  );
                },
                icon: Icon(Icons.arrow_downward),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class LampLight extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = Color(0xffd50f67)
      ..style = PaintingStyle.fill;
    final Path path = Path();
    path.moveTo(0, 0);
    path.lineTo(0, 0);
    path.lineTo(0, size.height * .8);
    path.lineTo(size.width * .5, 30);
    path.lineTo(size.width, size.height * .8);
    path.lineTo(size.width, 0);
    path.lineTo(0, 0);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
