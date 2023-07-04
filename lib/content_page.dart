import 'package:flutter/material.dart';
import 'package:flutter_comment_panel_example/comment/panel/model.dart';
import 'package:flutter_comment_panel_example/comment/panel/panel.dart';

import 'comment/detail/model.dart';
import 'main.dart';

/// @author: pengboboer
/// @createDate: 2023/5/29
class ContentPage extends StatefulWidget {

  const ContentPage({Key? key}) : super(key: key);

  @override
  State<ContentPage> createState() => _ContentPageState();
}

class _ContentPageState extends State<ContentPage> {

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => _willPanelPop(),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Stack(
          children: [
            Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    'content',
                  ),
                  const SizedBox(height: 30),
                  ElevatedButton(
                    onPressed: () {
                      AppGlobal.read<CommentPanelModel>().open("adb");
                    },
                    child: const Icon(Icons.edit_note),
                  )
                ],
              ),
            ),
            const CommentPanel()
          ],
        ),
      ),
    );
  }

  Future<bool> _willPanelPop() async {
    // Existence details page partial route pops up to the initial page
    CommentDetailModel detailModel = AppGlobal.read<CommentDetailModel>();
    if (detailModel.currentNavigatorContext != null) {
      Navigator.popUntil(detailModel.currentNavigatorContext!, (route) => route.isFirst);
      return false;
    }
    // If the comment panel is open, close it
    CommentPanelModel panelModel = AppGlobal.read<CommentPanelModel>();
    if (panelModel.controller.isPanelOpen) {
      panelModel.controller.close();
      return false;
    }

    return true;
  }
}
