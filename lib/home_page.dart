import 'package:blog_web_app/blog_entry_page.dart';
import 'package:blog_web_app/blog_list_tile.dart';
import 'package:blog_web_app/blog_post.dart';
import 'package:blog_web_app/blog_scaffold.dart';
import 'package:blog_web_app/constrained_center.dart';
import 'package:blog_web_app/login_dialog.dart';
import 'package:blog_web_app/user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final isUserLoggedin = context.watch<bool>();
    final posts = context.watch<List<BlogPost>>();
    final user = context.watch<BlogUser>();

    return BlogScaffold(
        appBar: AppBar(
          actions: [
            TextButton(
              child: Text(
                isUserLoggedin ? '🚪' : '🔐',
                style: TextStyle(fontSize: 30),
              ),
              onPressed: () {
                if (isUserLoggedin) {
                  FirebaseAuth.instance.signOut();
                } else {
                  //login dialog
                  showDialog(
                    context: context,
                    builder: (context) {
                      return LoginDialog();
                    },
                  );
                }
              },
            ),
          ],
        ),
        children: [
          ConstrainedCenter(
            child: CircleAvatar(
              backgroundImage: NetworkImage(user.profilePicture),
              radius: 72,
            ),
          ),
          SizedBox(height: 18.0),
          ConstrainedCenter(
            child: SelectableText(
              user.name,
              // context.watch<String>(),
              style: Theme.of(context).textTheme.headline1,
            ),
          ),
          SizedBox(height: 40.0),
          SelectableText(
            'Hello, I’m a human.',
            style: Theme.of(context).textTheme.bodyText2,
          ),
          SizedBox(height: 40.0),
          SelectableText(
            'Blog',
            style: Theme.of(context).textTheme.headline2,
          ),
          for (var post in posts) BlogListTile(post: post),
        ],
        floatingActionButton: isUserLoggedin
            ? FloatingActionButton.extended(
                label: Text('New blog'),
                icon: Icon(Icons.add),
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) {
                      return BlogEntryPage();
                    },
                  ));
                },
              )
            : SizedBox());
  }
}
