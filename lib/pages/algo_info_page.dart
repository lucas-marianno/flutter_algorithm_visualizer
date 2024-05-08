import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
// import 'package:url_launcher/url_launcher.dart' as url_launcher;
// import 'package:url_launcher/url_launcher_string.dart';

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
        child: ReadmeMD('assets/algo_info/$formatted.md'),
      ),
    );
  }
}

class ReadmeMD extends StatelessWidget {
  const ReadmeMD(this.asset, {super.key});
  final String asset;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: rootBundle.loadString(asset),
      builder: (context, AsyncSnapshot<String> snapshot) {
        if (snapshot.hasData) {
          return Markdown(
            selectable: true,
            data: snapshot.data!,
            controller: ScrollController(),
            imageBuilder: (uri, title, alt) {
              return Image.asset(uri.toString());
            },
            styleSheet: MarkdownStyleSheet(
                blockSpacing: 12,
                textScaler: const TextScaler.linear(1.15),
                checkbox: TextStyle(color: Colors.blue[700])),
            onTapText: () {},
            onTapLink: (text, href, title) {
              // url_launcher.launchUrl(Uri.parse(href!), mode: LaunchMode.externalApplication);
            },
          );
        }

        return const Center(child: CircularProgressIndicator());
      },
    );
  }
}
