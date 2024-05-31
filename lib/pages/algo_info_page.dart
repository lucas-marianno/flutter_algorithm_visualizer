import 'package:algovis/widgets/md_reader.dart';
import 'package:flutter/material.dart';

class AlgoInfoPage extends StatelessWidget {
  const AlgoInfoPage(this.algo, {super.key});
  final String algo;

  @override
  Widget build(BuildContext context) {
    String formatted = algo.replaceAll(' ', '_').toLowerCase();
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: MdReader('assets/algo_info/$formatted.md'),
      ),
    );
  }
}
