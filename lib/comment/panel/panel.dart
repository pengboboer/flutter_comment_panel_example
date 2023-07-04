import 'package:flutter/cupertino.dart';
import 'package:flutter_comment_panel_example/comment/detail/model.dart';
import 'package:flutter_comment_panel_example/comment/list/list_page.dart';
import 'package:flutter_comment_panel_example/comment/panel/model.dart';
import 'package:provider/provider.dart';

import '../../main.dart';
import '../../sliding_up_panel/panel.dart';

/// @author: pengboboer
/// @createDate: 2023/5/29
class CommentPanel extends StatefulWidget {
  const CommentPanel({Key? key}) : super(key: key);

  @override
  State<CommentPanel> createState() => _CommentPanelState();
}

class _CommentPanelState extends State<CommentPanel> {
  final GlobalKey _key = GlobalKey();
  CommentPanelModel model = AppGlobal.read<CommentPanelModel>();

  @override
  void initState() {
    super.initState();
    model.init();
  }

  @override
  void dispose() {
    model.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double height = screenHeight - MediaQuery.of(context).padding.top - MediaQuery.of(context).padding.bottom - 60;
    return Consumer<CommentPanelModel>(builder: (ctx, r, _) {
      return SlidingUpPanel(
        minHeight: 0,
        maxHeight: height,
        parallaxEnabled: false,
        defaultPanelState: PanelState.CLOSED,
        controller: model.controller,
        borderRadius: const BorderRadius.only(topLeft: Radius.circular(8), topRight: Radius.circular(8)),
        panelBuilder: (sc) => _buildPanelWidget(sc),
        backdropEnabled: true,
        isDraggable: model.isDraggable,
        onPanelClosed: () {
          // If there are comment details in the panel, the local route pops up
          // For example, pull down the details page, close the panel, and exit to the list page
          CommentDetailModel detailModel = AppGlobal.read<CommentDetailModel>();
          if (detailModel.currentNavigatorContext != null) {
            Navigator.popUntil(detailModel.currentNavigatorContext!, (route) => route.isFirst);
          }
        },
      );
    });
  }

  Widget _buildPanelWidget(ScrollController sc) {
    return Navigator(
      key: _key,
      pages: const [
        CupertinoPage(child: CommentListPage()),
      ],
      observers: [CommentDetailNavigator()],
      onPopPage: (Route<dynamic> route, dynamic result) {
        return route.didPop(result);
      },
    );
  }
}

class CommentDetailNavigator extends NavigatorObserver {
  @override
  void didPop(Route<dynamic> route, Route<dynamic>? previousRoute) {
    AppGlobal.read<CommentPanelModel>().isDraggable = true;
  }

  @override
  void didStartUserGesture(Route<dynamic> route, Route<dynamic>? previousRoute) {
    AppGlobal.read<CommentPanelModel>().isDraggable = false;
    AppGlobal.read<CommentPanelModel>().controller.panelPosition = 1.0;
  }

  @override
  void didStopUserGesture() {
    AppGlobal.read<CommentPanelModel>().isDraggable = true;
  }
}
