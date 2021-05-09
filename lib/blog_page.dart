import 'package:blog_web_app/blog_post.dart';
import 'package:blog_web_app/blog_scaffold.dart';
import 'package:blog_web_app/constrained_center.dart';
import 'package:blog_web_app/user.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BlogPage extends StatelessWidget {
  final BlogPost blogPost;

  const BlogPage({Key? key, required this.blogPost}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final user = context.watch<User>();
    return BlogScaffold(
      children: [
        ConstrainedCenter(
          child: CircleAvatar(
            backgroundImage: NetworkImage(user.profilePicture),
            radius: 54,
          ),
        ),
        SizedBox(height: 18.0),
        ConstrainedCenter(
          child: SelectableText(
            user.name,
            // context.watch<String>(),
            style: Theme.of(context).textTheme.headline5,
          ),
        ),
        SizedBox(height: 40.0),
        SelectableText(blogPost.title,
            style: Theme.of(context).textTheme.headline1),
        SizedBox(height: 40.0),
        SelectableText(
          blogPost.date,
          style: Theme.of(context).textTheme.caption,
        ),
        SizedBox(height: 20.0),
        SelectableText(blogPost.body),
      ],
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
      ),
    );
  }
}
