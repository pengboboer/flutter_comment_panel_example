import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_comment_panel_example/comment/list/model.dart';
import 'package:flutter_comment_panel_example/comment/panel/model.dart';
import 'package:flutter_comment_panel_example/widget/item_widget.dart';
import 'package:provider/provider.dart';
import 'package:scroll_to_index/scroll_to_index.dart';

import 'dart:math' as math;

import '../../main.dart';
import '../../widget/comment_input_widget.dart';
import '../../widget/write_bottom_widget.dart';
import '../detail/detail_page.dart';

/// @author: pengboboer
/// @createDate: 2023/5/29
class CommentListPage extends StatefulWidget {
  const CommentListPage({Key? key}) : super(key: key);

  @override
  State<CommentListPage> createState() => _CommentListPageState();
}

class _CommentListPageState extends State<CommentListPage> with WidgetsBindingObserver {
  final TextEditingController textEditingController = TextEditingController();
  bool isShowTextField = false;
  int index = -1;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeMetrics() {
    // delay 300 milliseconds sliding animation is more natural
    if (index != -1) {
      Future.delayed(const Duration(milliseconds: 300), () {
        CommentPanelModel model = AppGlobal.read<CommentPanelModel>();
        model.controller.setScrollEnable(true);
        model.listSc?.scrollToIndex(index);
      });
    }
    super.didChangeMetrics();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<CommentListModel>(
      builder: (context, provider, child) {
        return ClipRRect(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(8),
            topRight: Radius.circular(8),
          ),
          child: Column(
            children: [
              _buildContentWidget(),
              _buildWriteWidget(),
            ],
          ),
        );
      },
    );
  }

  Widget _buildContentWidget() {
    return Expanded(
      child: Stack(
        children: [
          Column(
            children: [
              _buildTopBarWidget(),
              _buildListWidget(),
            ],
          ),
          isShowTextField
              ? InkWell(
                  onTap: () {
                    setShowInput(false);
                  },
                  child: Container(
                    color: const Color(0xff000000).withOpacity(0.4),
                  ),
                )
              : const SizedBox()
        ],
      ),
    );
  }

  Widget _buildTopBarWidget() {
    return Listener(
      behavior: HitTestBehavior.opaque,
      onPointerMove: (p) => AppGlobal.read<CommentPanelModel>().controller.onChildWidgetPointerMove(p),
      child: Container(
        height: 57,
        color: Colors.white,
        child: Stack(
          children: [
            Positioned(
              left: 0,
              child: InkWell(
                onTap: () {
                  AppGlobal.read<CommentPanelModel>().controller.close();
                },
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Transform.rotate(
                    angle: -math.pi / 2,
                    child: const Icon(
                      Icons.arrow_back_ios_new,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
            ),
            const Positioned.fill(
              child: Center(
                child: Text(
                  "CommentList",
                  style: TextStyle(fontSize: 20, color: Colors.black, fontWeight: FontWeight.bold),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildListWidget() {
    return Expanded(
      child: MediaQuery.removePadding(
        removeTop: true,
        context: context,
        child: ListView.separated(
          controller: AppGlobal.read<CommentPanelModel>().listSc,
          itemCount: AppGlobal.read<CommentListModel>().list.length,
          itemBuilder: (context, index) => _buildItem(index),
          separatorBuilder: (context, index) => Container(height: 8, color: const Color(0xfff5f5f5)),
        ),
      ),
    );
  }

  Widget _buildItem(int index) {
    return AutoScrollTag(
      key: ValueKey(index),
      controller: AppGlobal.read<CommentPanelModel>().listSc!,
      index: index,
      child: CommentItemWidget(
        index: index,
        onClickItem: (index) {
          this.index = index;
          setShowInput(true);
        },
        onClickReply: (index) => _toDetailPage(index),
      ),
    );
  }

  void _toDetailPage(int index) {
    double offset = AppGlobal.read<CommentPanelModel>().listSc?.offset ?? 0;
    AppGlobal.read<CommentPanelModel>().setPanelScToDetail();
    Navigator.push(
      context,
      CupertinoPageRoute(
        builder: (context) {
          return CommentDetailPage(id: AppGlobal.read<CommentListModel>().list[index]);
        },
      ),
    ).then((value) {
      AppGlobal.read<CommentPanelModel>().setPanelScToList();
      // When the panel is pulled down on the details page, _scrollingEnabled will be changed to false,
      // which will cause the original position not to be restored, so set it to true first
      AppGlobal.read<CommentPanelModel>().controller.setScrollEnable(true);
      AppGlobal.read<CommentPanelModel>().listSc?.jumpTo(offset);
    });
  }

  Widget _buildWriteWidget() {
    return Stack(
      children: [
        WriteBottomWidget(
          onClick: () {
            index = -1;
            setShowInput(true);
          },
        ),
        isShowTextField
            ? CommentInputWidget(
                controller: textEditingController,
                hint: index == -1 ? null : "reply: user name $index",
                onCommit: (value) {
                  textEditingController.clear();
                  setShowInput(false);
                },
                onChanged: (value) {},
              )
            : const SizedBox()
      ],
    );
  }

  void setShowInput(bool isShow) {
    AppGlobal.read<CommentPanelModel>().isDraggable = !isShow;
    isShowTextField = isShow;
    if (mounted) setState(() {});
  }
}
