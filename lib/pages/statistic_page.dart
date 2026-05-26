import 'package:flutter/material.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:world_skills/services/json_reader.dart';

class StatisticPage extends StatefulWidget {
  const StatisticPage({super.key});

  @override
  State<StatisticPage> createState() => _StatisticPageState();
}

class _StatisticPageState extends State<StatisticPage> {
  late final Future<List<dynamic>> _statisticFuture;

  @override
  void initState() {
    super.initState();
    _statisticFuture = JsonReader.readStatistic();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(32.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Statistic",
                style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
              ),
              Container(width: 32, height: 4, color: Color(0xffd50f67)),
            ],
          ),
        ),
        Expanded(
          child: FutureBuilder(
            future: _statisticFuture,
            builder: (context, asyncSnapshot) {
              if (asyncSnapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: SizedBox(width: 220, child: LinearProgressIndicator()),
                );
              }

              if (asyncSnapshot.hasError) {
                return Center(
                  child: Text(
                    "Failed to load statistics",
                    style: TextStyle(color: Colors.white),
                  ),
                );
              }

              final statistics = asyncSnapshot.data ?? const [];

              return Stack(
                children: [
                  Positioned.fill(child: Container(color: Color(0xff003764))),
                  Positioned(
                    bottom: 0,
                    height: 100,
                    left: 0,
                    right: 0,
                    child: Image.asset(
                      "assets/images/pattern-2.png",
                      width: 200,
                      repeat: ImageRepeat.repeatX,
                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "The number of WorldSkills competitors",
                        style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          for (int i = 0; i < statistics.length; i++)
                            Expanded(
                              child: TweenAnimationBuilder(
                                tween: IntTween(
                                  begin: 0,
                                  end: statistics[i]["competitors"],
                                ),
                                duration: 3.seconds,
                                builder: (context, value, child) {
                                  return Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Text(
                                        "$value",
                                        style: TextStyle(color: Colors.white),
                                      ),
                                      SizedBox(
                                        height: 300,
                                        child: Stack(
                                          alignment:
                                              AlignmentGeometry.bottomCenter,
                                          children: [
                                            Positioned(
                                              bottom: 0,
                                              child: Container(
                                                width: 16,
                                                height: 300,
                                                color: Color(0xff002846),
                                              ),
                                            ),
                                            Positioned(
                                              bottom: 0,
                                              child: Container(
                                                width: 16,
                                                height: (value / 1500) * 300,
                                                color: Colors.blue,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Text(
                                        statistics[i]["competition"],
                                        style: TextStyle(color: Colors.white),
                                      ),
                                      const Row(),
                                    ],
                                  );
                                },
                              ),
                            ),
                        ],
                      ),
                      SizedBox(),
                    ],
                  ),
                ],
              );
            },
          ),
        ),
      ],
    );
  }
}
