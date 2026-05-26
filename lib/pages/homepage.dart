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
            TweenAnimationBuilder(
              builder: (context, value, child) {
                return Opacity(opacity: value, child: child);
              },
              tween: Tween<double>(begin: 1, end: 0),
              duration: 3.seconds,
              child: Container(color: Color(0xffd50f67)),
            ),
            TweenAnimationBuilder(
              builder: (context, value, child) {
                return Opacity(opacity: value, child: child);
              },
              tween: Tween<double>(begin: 0, end: 1),
              duration: 3.seconds,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(height: 120),
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
            ),
            Align(
              alignment: Alignment(0, -1),
              child: TweenAnimationBuilder(
                builder: (context, value, child) {
                  return Transform.translate(
                    offset: Offset(0, value),
                    child: child,
                  );
                },
                tween: Tween<double>(begin: -100, end: 0),
                duration: 2.seconds,
                child: Image.asset(
                  "assets/images/lamp.png",
                  width: Get.width * .1,
                ),
              ),
            ),
            RepeatingAnimationBuilder(
              repeatMode: RepeatMode.reverse,
              builder: (context, value, child) {
                return Align(alignment: Alignment(0, value), child: child);
              },
              animatable: Tween(begin: .7, end: .9),
              duration: 2.seconds,
              curve: Curves.easeInBack,
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
