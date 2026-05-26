import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:world_skills/pages/photos_page.dart';
import 'package:world_skills/pages/skills_page.dart';
import 'package:world_skills/pages/statistic_page.dart';
import 'package:world_skills/services/json_reader.dart';

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

class _AboutPageContent extends StatefulWidget {
  const _AboutPageContent();

  @override
  State<_AboutPageContent> createState() => _AboutPageContentState();
}

class _AboutPageContentState extends State<_AboutPageContent> {
  int _expandedTileIndex = -1;
  late final Future<List> _aboutFuture;

  @override
  void initState() {
    super.initState();
    _aboutFuture = JsonReader.readAbout();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List>(
      future: _aboutFuture,
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const SizedBox.shrink();
        }

        final aboutItems = snapshot.data!;

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
                  final tiles = <_AboutTileConfig>[
                    _AboutTileConfig(
                      title: aboutItems[0]['title'] as String,
                      description: aboutItems[0]['content'] as String,
                      imagePath: "assets/images/inspire.jpg",
                      color: Colors.blue.withAlpha(150),
                      top: 0,
                      left: 0,
                      width: constraints.maxWidth * .7,
                      height: constraints.maxHeight * .5,
                    ),
                    _AboutTileConfig(
                      title: aboutItems[1]['title'] as String,
                      description: aboutItems[1]['content'] as String,
                      imagePath: "assets/images/develop.jpg",
                      color: Colors.deepPurple.withAlpha(150),
                      bottom: 0,
                      left: 0,
                      width: constraints.maxWidth * .7,
                      height: constraints.maxHeight * .5,
                    ),
                    _AboutTileConfig(
                      title: aboutItems[2]['title'] as String,
                      description: aboutItems[2]['content'] as String,
                      imagePath: "assets/images/influence.jpg",
                      color: Colors.pink.withAlpha(150),
                      bottom: 0,
                      right: 0,
                      width: constraints.maxWidth * .3,
                      height: constraints.maxHeight,
                    ),
                  ];

                  final indices = List.generate(tiles.length, (index) => index)
                    ..sort((a, b) {
                      if (a == _expandedTileIndex) {
                        return 1;
                      }
                      if (b == _expandedTileIndex) {
                        return -1;
                      }
                      return 0;
                    });

                  return Stack(
                    clipBehavior: Clip.none,
                    children: indices
                        .map(
                          (index) => _buildTile(
                            config: tiles[index],
                            isExpanded: _expandedTileIndex == index,
                            maxWidth: constraints.maxWidth,
                            maxHeight: constraints.maxHeight,
                            onTap: () {
                              setState(() {
                                _expandedTileIndex = _expandedTileIndex == index
                                    ? -1
                                    : index;
                              });
                            },
                          ),
                        )
                        .toList(),
                  );
                },
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildTile({
    required _AboutTileConfig config,
    required bool isExpanded,
    required double maxWidth,
    required double maxHeight,
    required VoidCallback onTap,
  }) {
    final baseLeft =
        config.left ?? (maxWidth - (config.right ?? 0) - config.width);
    final baseTop =
        config.top ?? (maxHeight - (config.bottom ?? 0) - config.height);

    return AnimatedPositioned(
      duration: const Duration(milliseconds: 350),
      curve: Curves.easeInOut,
      left: isExpanded ? 0 : baseLeft,
      top: isExpanded ? 0 : baseTop,
      width: isExpanded ? maxWidth : config.width,
      height: isExpanded ? maxHeight : config.height,
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: onTap,
        child: Stack(
          children: [
            Positioned.fill(
              child: Image.asset(config.imagePath, fit: BoxFit.cover),
            ),
            Positioned.fill(
              child: Container(
                color: config.color,
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        config.title,
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 32,
                        ),
                      ),
                      if (isExpanded) ...[
                        const SizedBox(height: 16),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 24.0),
                          child: Text(
                            config.description,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _AboutTileConfig {
  const _AboutTileConfig({
    required this.title,
    required this.description,
    required this.imagePath,
    required this.color,
    required this.width,
    required this.height,
    this.top,
    this.bottom,
    this.left,
    this.right,
  });

  final String title;
  final String description;
  final String imagePath;
  final Color color;
  final double width;
  final double height;
  final double? top;
  final double? bottom;
  final double? left;
  final double? right;
}
