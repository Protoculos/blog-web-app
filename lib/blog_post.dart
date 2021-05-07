import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class BlogPost {
  final String title;
  final DateTime publishedDate;
  final String body;

  String get date => DateFormat('d MMMM y').format(publishedDate);

  BlogPost(
      {required this.title, required this.publishedDate, required this.body});

  factory BlogPost.fromDocument(DocumentSnapshot doc) {
    final map = doc.data();
    if (map == null) return null;

    return BlogPost(
      title: map['title'],
      publishedDate: map['published_date'].toDate(),
      body: map['body'],
    );
  }

  final timeStemp = Timestamp.fromDate(DateTime.now()).toDate();

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'body': body,
      'published_date': Timestamp.fromDate(publishedDate),
    };
  }
}
