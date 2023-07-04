import 'package:flutter/cupertino.dart';
import 'package:flutter_comment_panel_example/comment/panel/model.dart';

import '../../main.dart';

/// @author: pengboboer
/// @createDate: 2023/6/28
class CommentListModel extends ChangeNotifier {

  List<String> list = [];

  void init() {
    CommentPanelModel model = AppGlobal.read<CommentPanelModel>();
    model.setPanelScToList();
    _request();
  }

  Future<void> _request() async {
    await Future.delayed(const Duration(milliseconds: 100));
    list.clear();
    for (int i = 0; i < 20; i++) {
      list.add(i.toString());
    }
    notifyListeners();
  }
}