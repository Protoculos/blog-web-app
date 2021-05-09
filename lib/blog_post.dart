import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class BlogPost {
  final String title;
  final DateTime publishedDate;
  final String body;
  final String? id;

  String get date => DateFormat('d MMMM y').format(publishedDate);

  BlogPost(
      {this.id,
      required this.title,
      required this.publishedDate,
      required this.body});

  factory BlogPost.fromDocument(DocumentSnapshot<Map<String, dynamic>> doc) {
    final map = doc.data();

    if (map != null) {
      return BlogPost(
        title: map['title'],
        publishedDate: map['published_date'].toDate(),
        body: map['body'],
        id: doc.id,
      );
    } else {
      throw Exception('Document does not exist on the database');
    }
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'body': body,
      'published_date': Timestamp.fromDate(publishedDate),
    };
  }
}
