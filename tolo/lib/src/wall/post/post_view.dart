import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:tolo/model/post.dart';
import 'package:tolo/src/wall/post/post_bloc.dart';

class PostView extends StatefulWidget {
  Post post;
  PostView({Key? key, required this.post}) : super(key: key);

  @override
  _PostViewState createState() => _PostViewState();
}

class _PostViewState extends State<PostView> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PostBloc, PostState>(
      builder: (context, state) {
        return _postBuilder();
      },
    );
  }

  Widget _postBuilder() {
    return Text(
      widget.post.title,
      maxLines: 5,
      style: TextStyle(fontSize: 20, color: Colors.black),
    );
  }
}
