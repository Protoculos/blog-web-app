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
        StreamProvider<List<BlogPost>>(
          create: (context) => blogPosts(),
          initialData: [],
        ),
        Provider<User>(
          create: (context) => User(
            name: 'Flutter Dev',
            profilePicture:
                'https://thumbs.dreamstime.com/b/panda-avatar-illustration-45383457.jpg',
          ),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Dev Blog',
        theme: theme,
        home: HomePage(),
      ),
    );
  }
}

Stream<List<BlogPost>> blogPosts() {
  return FirebaseFirestore.instance
      .collection('blogs')
      .snapshots()
      .map((snapshot) {
    return snapshot.docs.map((doc) {
      if (doc.exists) {
        return BlogPost.fromDocument(doc);
      } else {
        throw Exception('Document does not exist on the database');
      }
    }).toList()
      ..sort((first, last) {
        final firstDate = first.publishedDate;
        final lastDate = last.publishedDate;
        return -firstDate.compareTo(lastDate);
      });
  });
}
