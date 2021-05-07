import 'package:flutter/material.dart';

class BlogScaffold extends StatelessWidget {
  final List<Widget> children;

  const BlogScaffold({Key? key, required this.children}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Align(
        child: Container(
          alignment: Alignment.topCenter,
          padding: const EdgeInsets.symmetric(horizontal: 18),
          width: 612,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: children,
          ),
        ),
      ),
    );
  }
}
