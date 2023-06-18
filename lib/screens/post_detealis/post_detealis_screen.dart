import 'package:flutter/material.dart';

import '../homescreen/model/posts_response.dart';

class PostDetailsScreen extends StatelessWidget {
    PostDetailsScreen({Key? key,required this.post}) : super(key: key);
    final Post post ;
  @override
  Widget build(BuildContext context) {
    return   Scaffold(
      appBar: AppBar(title: Text(post.description??"")),
    );
  }
}
