import 'package:blog_web_app/blog_page.dart';
import 'package:blog_web_app/blog_post.dart';
import 'package:blog_web_app/blog_scaffold.dart';
import 'package:blog_web_app/constrained_center.dart';
import 'package:blog_web_app/user.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final posts = context.watch<List<BlogPost>>();
    final user = context.watch<User>();
    return BlogScaffold(
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
          'Hello, I’m a human. I’m a Flutter developer and an avid human. Occasionally, I nap.',
          style: Theme.of(context).textTheme.bodyText2,
        ),
        SizedBox(height: 40.0),
        SelectableText(
          'Blog',
          style: Theme.of(context).textTheme.headline2,
        ),
        for (var post in posts) BlogListTile(post: post),
      ],
    );
  }
}

class BlogListTile extends StatelessWidget {
  final BlogPost post;

  const BlogListTile({Key? key, required this.post}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 20.0),
        InkWell(
          child: Text(
            post.title,
            style: TextStyle(color: Colors.blueAccent.shade700),
          ),
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) {
                  return BlogPage(blogPost: post);
                },
              ),
            );
          },
        ),
        SizedBox(height: 10.0),
        SelectableText(
          post.date,
          style: Theme.of(context).textTheme.caption,
        ),
      ],
    );
  }
}
