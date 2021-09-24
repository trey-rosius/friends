import 'package:flutter/cupertino.dart';

abstract class PostListItem{
  buildPostItem(BuildContext context);
  buildCommentItem(BuildContext context);
}