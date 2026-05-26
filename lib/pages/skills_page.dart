import 'package:flutter/material.dart';
import 'package:world_skills/services/json_reader.dart';

class SkillsPage extends StatefulWidget {
  const SkillsPage({super.key});

  @override
  State<SkillsPage> createState() => _SkillsPageState();
}

class _SkillsPageState extends State<SkillsPage> {
  final PageController pageController = PageController(viewportFraction: 0.78);
  int selectedIndex = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  void goToPrevious(int currentIndex) {
    if (currentIndex <= 0) {
      return;
    }

    pageController.previousPage(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOut,
    );
  }

  void goToNext(int currentIndex, int itemCount) {
    if (currentIndex >= itemCount - 1) {
      return;
    }

    pageController.nextPage(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(32.0),
          child: Column(
            children: [
              Text(
                "Skills",
                style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
              ),
              Container(width: 32, height: 4, color: Color(0xffd50f67)),
            ],
          ),
        ),
        FutureBuilder<List<dynamic>>(
          future: JsonReader.readSkills(),
          builder: (context, asyncSnapshot) {
            if (asyncSnapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }

            if (asyncSnapshot.hasError || !asyncSnapshot.hasData) {
              return const Center(child: Text("Failed to load skills"));
            }

            final skills = asyncSnapshot.data!;

            if (skills.isEmpty) {
              return const Center(child: Text("No skills available"));
            }

            return Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  width: MediaQuery.sizeOf(context).width * .7,
                  height: MediaQuery.sizeOf(context).height * .5,
                  child: PageView.builder(
                    onPageChanged: (value) {
                      // setState(() {
                      selectedIndex = value;
                      // });
                    },
                    itemCount: skills.length,
                    itemBuilder: (context, index) {
                      final item = skills[index] as Map<String, dynamic>;
                      return AnimatedBuilder(
                        animation: pageController,
                        builder: (context, child) {
                          double page = selectedIndex.toDouble();

                          if (pageController.hasClients &&
                              pageController.position.hasPixels) {
                            page =
                                pageController.page ?? selectedIndex.toDouble();
                          }

                          final distance = (index - page).abs();
                          final cardOpacity = (1 - (distance * 0.45)).clamp(
                            0.4,
                            1.0,
                          );

                          return Opacity(
                            opacity: cardOpacity,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                              ),
                              child: child,
                            ),
                          );
                        },
                        child: Stack(
                          children: [
                            Positioned.fill(
                              child: Image.asset(
                                "assets/images/${item["image"]}",
                                fit: BoxFit.cover,
                              ),
                            ),
                            Positioned(
                              right: 0,
                              height: 200,
                              width: 300,
                              bottom: 0,
                              child: Stack(
                                children: [
                                  Container(
                                    color: const Color(0xffd50f68),
                                    child: Padding(
                                      padding: const EdgeInsets.all(16.0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            item["skill"] as String,
                                            style: const TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 24,
                                            ),
                                          ),
                                          Flexible(
                                            child: Text(
                                              item["description"] as String,
                                              style: const TextStyle(
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    top: 0,
                                    right: 0,
                                    height: 100,
                                    child: Image.asset(
                                      "assets/images/pattern.png",
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                    controller: pageController,
                  ),
                ),
                SizedBox(
                  height: 48,
                  child: AnimatedBuilder(
                    animation: pageController,
                    builder: (context, value) {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          IconButton(
                            style: ButtonStyle(
                              shape: const WidgetStatePropertyAll(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(256),
                                  ),
                                  side: BorderSide(
                                    color: Color(0xffd50f68),
                                    width: 4,
                                  ),
                                ),
                              ),
                            ),
                            onPressed: selectedIndex == 0
                                ? null
                                : () => goToPrevious(selectedIndex),
                            icon: const Icon(
                              Icons.arrow_back_ios,
                              color: Color(0xffd50f68),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Row(
                            children: [
                              for (int i = 0; i < skills.length; i++)
                                AnimatedContainer(
                                  duration: const Duration(milliseconds: 200),
                                  margin: const EdgeInsets.symmetric(
                                    horizontal: 4,
                                  ),
                                  width: 12,
                                  height: 12,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: selectedIndex == i
                                        ? const Color(0xffd50f68)
                                        : const Color(
                                            0xffd50f68,
                                          ).withAlpha(100),
                                  ),
                                ),
                            ],
                          ),
                          const SizedBox(width: 8),
                          IconButton(
                            style: ButtonStyle(
                              shape: const WidgetStatePropertyAll(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(256),
                                  ),
                                  side: BorderSide(
                                    color: Color(0xffd50f68),
                                    width: 4,
                                  ),
                                ),
                              ),
                            ),
                            onPressed: selectedIndex == skills.length - 1
                                ? null
                                : () => goToNext(selectedIndex, skills.length),
                            icon: const Icon(
                              Icons.arrow_forward_ios,
                              color: Color(0xffd50f68),
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ),
                Row(),
              ],
            );
          },
        ),
      ],
    );
  }
}
