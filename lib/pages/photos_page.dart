import 'package:flutter/material.dart';

class PhotosPage extends StatefulWidget {
  const PhotosPage({super.key});

  @override
  State<PhotosPage> createState() => _PhotosPageState();
}

class _PhotosPageState extends State<PhotosPage> {
  void _openPhoto(String imagePath) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => FullscreenImagePage(imagePath: imagePath),
        fullscreenDialog: true,
      ),
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
                "Photos",
                style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
              ),
              Container(width: 32, height: 4, color: Color(0xffd50f67)),
            ],
          ),
        ),

        Expanded(
          child: LayoutBuilder(
            builder: (context, constraints) {
              const double spacing = 12;
              return Stack(
                children: [
                  //1
                  Positioned(
                    left: spacing,
                    top: spacing,
                    height: (constraints.maxHeight / 3) - spacing,
                    width: (constraints.maxWidth / 4) - spacing,
                    child: GestureDetector(
                      onTap: () => _openPhoto("assets/images/photo-3.jpg"),
                      child: Hero(
                        tag: "assets/images/photo-3.jpg",
                        child: Image.asset(
                          "assets/images/photo-3.jpg",
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  //2
                  Positioned(
                    left: (constraints.maxWidth / 4) + spacing,
                    top: spacing,
                    height: (constraints.maxHeight / 3) - spacing,
                    width: (constraints.maxWidth / 4) - spacing,
                    child: GestureDetector(
                      onTap: () => _openPhoto("assets/images/photo-4.jpg"),
                      child: Hero(
                        tag: "assets/images/photo-4.jpg",
                        child: Image.asset(
                          "assets/images/photo-4.jpg",
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  //3
                  Positioned(
                    left: (constraints.maxWidth / 4) + spacing,
                    top: (constraints.maxHeight / 3) + spacing,
                    height: (constraints.maxHeight / 3) - spacing,
                    width: (constraints.maxWidth / 4) - spacing,
                    child: GestureDetector(
                      onTap: () => _openPhoto("assets/images/photo-6.jpg"),
                      child: Hero(
                        tag: "assets/images/photo-6.jpg",
                        child: Image.asset(
                          "assets/images/photo-6.jpg",
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  //4
                  Positioned(
                    left: spacing,
                    top: (constraints.maxHeight / 3) + spacing,
                    height: (constraints.maxHeight / 3) - spacing,
                    width: (constraints.maxWidth / 4) - spacing,
                    child: GestureDetector(
                      onTap: () => _openPhoto("assets/images/photo-5.jpg"),
                      child: Hero(
                        tag: "assets/images/photo-5.jpg",
                        child: Image.asset(
                          "assets/images/photo-5.jpg",
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  //5
                  Positioned(
                    left: spacing,
                    top: (constraints.maxHeight / 3) * 2 + spacing,
                    height: (constraints.maxHeight / 3) - spacing,
                    width: (constraints.maxWidth / 2) - spacing,
                    child: GestureDetector(
                      onTap: () => _openPhoto("assets/images/photo-2.jpg"),
                      child: Hero(
                        tag: "assets/images/photo-2.jpg",
                        child: Image.asset(
                          "assets/images/photo-2.jpg",
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    left: (constraints.maxWidth / 2) + spacing,
                    top: spacing,
                    height: (constraints.maxHeight / 3) * 2 - spacing,
                    width: (constraints.maxWidth / 2) - spacing,
                    child: GestureDetector(
                      onTap: () => _openPhoto("assets/images/photo-1.jpg"),
                      child: Hero(
                        tag: "assets/images/photo-1.jpg",
                        child: Image.asset(
                          "assets/images/photo-1.jpg",
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),

                  //7
                  Positioned(
                    left: (constraints.maxWidth / 4) * 2 + spacing,
                    top: (constraints.maxHeight / 3) * 2 + spacing,
                    height: (constraints.maxHeight / 3) - spacing,
                    width: (constraints.maxWidth / 4) - spacing,
                    child: GestureDetector(
                      onTap: () => _openPhoto("assets/images/photo-7.jpg"),
                      child: Hero(
                        tag: "assets/images/photo-7.jpg",
                        child: Image.asset(
                          "assets/images/photo-7.jpg",
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  //8
                  Positioned(
                    left: (constraints.maxWidth / 4) * 3 + spacing,
                    top: (constraints.maxHeight / 3) * 2 + spacing,
                    height: (constraints.maxHeight / 3) - spacing,
                    width: (constraints.maxWidth / 4) - spacing,
                    child: GestureDetector(
                      onTap: () => _openPhoto("assets/images/photo-8.jpg"),
                      child: Hero(
                        tag: "assets/images/photo-8.jpg",
                        child: Image.asset(
                          "assets/images/photo-8.jpg",
                          fit: BoxFit.cover,
                        ),
                      ),
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

class FullscreenImagePage extends StatelessWidget {
  final String imagePath;

  const FullscreenImagePage({super.key, required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Stack(
          children: [
            Center(
              child: Hero(
                tag: imagePath,
                child: InteractiveViewer(
                  child: Image.asset(imagePath, fit: BoxFit.contain),
                ),
              ),
            ),
            Positioned(
              top: 8,
              right: 8,
              child: IconButton(
                icon: const Icon(Icons.close, color: Colors.white, size: 30),
                onPressed: () => Navigator.of(context).pop(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
