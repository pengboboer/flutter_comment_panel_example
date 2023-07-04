import 'package:flutter/cupertino.dart';
import 'package:flutter_comment_panel_example/comment/list/model.dart';
import 'package:scroll_to_index/scroll_to_index.dart';

import '../../main.dart';
import '../../sliding_up_panel/panel.dart';

/// @author: pengboboer
/// @createDate: 2023/6/28
class CommentPanelModel extends ChangeNotifier {
  PanelController controller = PanelController();

  AutoScrollController? listSc = AutoScrollController();
  AutoScrollController? detailSc = AutoScrollController();

  bool _isDraggable = true;

  String? id;

  void init() {
    listSc = AutoScrollController();
    detailSc = AutoScrollController();
  }

  void clear() {
    controller.clear();
    listSc?.dispose();
    detailSc?.dispose();
    listSc = null;
    detailSc = null;
  }

  void open(String id) {
    this.id = id;
    notifyListeners();
    controller.open();
    AppGlobal.read<CommentListModel>().init();
  }

  void setPanelScToList() {
    controller.setScrollController(listSc!);
  }

  void setPanelScToDetail() {
    controller.setScrollController(detailSc!);
  }

  bool get isDraggable => _isDraggable;

  set isDraggable(bool value) {
    _isDraggable = value;
    notifyListeners();
  }
}
