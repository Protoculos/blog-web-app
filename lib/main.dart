import 'package:blog_web_app/blog_post.dart';
import 'package:blog_web_app/home_page.dart';
import 'package:blog_web_app/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

var theme = ThemeData(
  primarySwatch: Colors.blue,
  textTheme: TextTheme(
    headline1: TextStyle(
      fontSize: 45,
      fontWeight: FontWeight.w800,
      color: Colors.black,
    ),
    headline2: TextStyle(
      fontSize: 27,
      fontWeight: FontWeight.w700,
      color: Colors.black,
    ),
    bodyText2: TextStyle(fontSize: 22, height: 1.4),
    caption: TextStyle(fontSize: 18, height: 1.4),
  ),
  appBarTheme: AppBarTheme(
      color: Colors.transparent,
      elevation: 0,
      iconTheme: IconThemeData(color: Colors.black)),
);
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        FutureProvider<List<BlogPost>>(
          create: (context) => blogPosts(),
          initialData: [],
        ),
        Provider<List<BlogPost>>(create: (context) => _blogPosts),
        Provider<User>(
          create: (context) => User(
            name: 'Flutter Dev',
            profilePicture:
                'https://thumbs.dreamstime.com/b/panda-avatar-illustration-45383457.jpg',
          ),
        )
      ],
      child: MaterialApp(
        title: 'Flutter Dev Blog',
        theme: theme,
        home: HomePage(),
      ),
    );
  }
}

final _blogPosts = [
  BlogPost(
    title: 'What is multi-provider?',
    publishedDate: DateTime(2020, 1, 2),
    body:
        'A wrapper around Inherited Widget to make them easier to use and more reusable.',
  ),
  BlogPost(
    title: 'What is provider?',
    publishedDate: DateTime(2020, 2, 3),
    body:
        'A provider that merges multiple providers into a single linear widget tree. It is used to improve readability and reduce boilerplate code of having to nest multiple layers of providers.',
  ),
];

Future<List<BlogPost>> blogPosts() {
  return FirebaseFirestore.instance.collection('blogs').get().then((query) {
    return query.docs.map((doc) => BlogPost.fromDocument(doc)).toList();
  });
}