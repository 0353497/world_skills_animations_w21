import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:world_skills/pages/photos_page.dart';
import 'package:world_skills/pages/skills_page.dart';
import 'package:world_skills/pages/statistic_page.dart';

class AboutPage extends StatefulWidget {
  const AboutPage({super.key});

  @override
  State<AboutPage> createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> {
  final PageController _pageController = PageController();
  int _selectedIndex = 0;

  final List<String> _sections = const [
    'About',
    'Statistic',
    'Photos',
    'Skills',
  ];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _selectPage(int index) {
    if (_selectedIndex == index) {
      return;
    }

    setState(() {
      _selectedIndex = index;
    });

    _pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 350),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          _AboutSidebar(
            selectedIndex: _selectedIndex,
            sections: _sections,
            onSelected: _selectPage,
          ),
          Expanded(
            child: PageView(
              controller: _pageController,
              scrollDirection: Axis.vertical,
              onPageChanged: (index) {
                setState(() {
                  _selectedIndex = index;
                });
              },
              children: const [
                _AboutPageContent(),
                StatisticPage(),
                PhotosPage(),
                SkillsPage(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _AboutSidebar extends StatelessWidget {
  const _AboutSidebar({
    required this.selectedIndex,
    required this.sections,
    required this.onSelected,
  });

  final int selectedIndex;
  final List<String> sections;
  final ValueChanged<int> onSelected;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: Get.width * .15,
      child: Column(
        spacing: 24,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.asset("assets/images/logo_pink.png", width: Get.width * .2),
          Stack(
            children: [
              Positioned(
                left: 0,
                top: 40.0 * selectedIndex,
                child: Container(
                  width: 4,
                  height: 30,
                  decoration: BoxDecoration(
                    color: const Color(0xffd50f67),
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
              ),
              Column(
                spacing: 24,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: List.generate(sections.length, (index) {
                  return InkWell(
                    onTap: () => onSelected(index),
                    child: Text(
                      sections[index],
                      style: TextStyle(
                        fontWeight: selectedIndex == index
                            ? FontWeight.bold
                            : null,
                      ),
                    ),
                  );
                }),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _AboutPageContent extends StatelessWidget {
  const _AboutPageContent();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.all(32.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "About",
                style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 0),
              SizedBox(
                width: 32,
                height: 4,
                child: ColoredBox(color: Color(0xffd50f67)),
              ),
            ],
          ),
        ),
        Expanded(
          child: LayoutBuilder(
            builder: (context, constraints) {
              return Stack(
                children: [
                  Positioned(
                    left: 0,
                    height: constraints.maxHeight * .5,
                    top: 0,
                    width: constraints.maxWidth * .7,
                    child: Stack(
                      children: [
                        SizedBox(
                          width: constraints.maxWidth * .7,
                          height: constraints.maxHeight * .5,
                          child: Image.asset(
                            "assets/images/inspire.jpg",
                            fit: BoxFit.cover,
                          ),
                        ),
                        Positioned.fill(
                          child: Container(
                            color: Colors.blue.withAlpha(150),
                            child: const Center(
                              child: Text(
                                "Inspire",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 32,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    left: 0,
                    height: constraints.maxHeight * .5,
                    bottom: 0,
                    width: constraints.maxWidth * .7,
                    child: Stack(
                      children: [
                        SizedBox(
                          width: constraints.maxWidth * .7,
                          height: constraints.maxHeight * .5,
                          child: Image.asset(
                            "assets/images/develop.jpg",
                            fit: BoxFit.cover,
                          ),
                        ),
                        Positioned.fill(
                          child: Container(
                            color: Colors.deepPurple.withAlpha(150),
                            child: const Center(
                              child: Text(
                                "Develop",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 32,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    right: 0,
                    height: constraints.maxHeight,
                    bottom: 0,
                    width: constraints.maxWidth * .3,
                    child: Stack(
                      children: [
                        SizedBox(
                          width: constraints.maxWidth * .3,
                          height: constraints.maxHeight,
                          child: Image.asset(
                            "assets/images/influence.jpg",
                            fit: BoxFit.cover,
                          ),
                        ),
                        Positioned.fill(
                          child: Container(
                            color: Colors.pink.withAlpha(150),
                            child: const Center(
                              child: Text(
                                "Influence",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 32,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
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
