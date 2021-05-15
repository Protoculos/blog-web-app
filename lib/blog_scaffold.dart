import 'package:flutter/material.dart';

class BlogScaffold extends StatelessWidget {
  final List<Widget> children;
  final Widget floatingActionButton;
  final AppBar? appBar;

  const BlogScaffold(
      {Key? key,
      required this.children,
      required this.floatingActionButton,
      this.appBar})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar ?? AppBar(),
      body: Align(
        child: SingleChildScrollView(
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
      ),
      floatingActionButton: floatingActionButton,
    );
  }
}
