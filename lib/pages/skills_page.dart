import 'package:flutter/material.dart';

class SkillsPage extends StatefulWidget {
  const SkillsPage({super.key});

  @override
  State<SkillsPage> createState() => _SkillsPageState();
}

class _SkillsPageState extends State<SkillsPage> {
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
      ],
    );
  }
}
