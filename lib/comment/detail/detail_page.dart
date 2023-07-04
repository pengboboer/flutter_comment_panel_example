import 'package:flutter/material.dart';
import 'package:flutter_comment_panel_example/comment/panel/model.dart';
import 'package:flutter_comment_panel_example/main.dart';
import 'package:scroll_to_index/scroll_to_index.dart';

import '../../widget/comment_input_widget.dart';
import '../../widget/item_widget.dart';
import '../../widget/write_bottom_widget.dart';
import 'model.dart';

/// @author: pengboboer
/// @createDate: 2023/5/29
class CommentDetailPage extends StatefulWidget {
  final String id;

  const CommentDetailPage({Key? key, required this.id}) : super(key: key);

  @override
  State<CommentDetailPage> createState() => _CommentDetailPageState();
}

class _CommentDetailPageState extends State<CommentDetailPage> with WidgetsBindingObserver {
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
    AppGlobal.read<CommentDetailModel>().currentNavigatorContext = null;
    super.dispose();
  }

  @override
  void didChangeMetrics() {
    // delay 300 milliseconds sliding animation is more natural
    if (index != -1) {
      Future.delayed(const Duration(milliseconds: 300), () {
        CommentPanelModel model = AppGlobal.read<CommentPanelModel>();
        model.controller.setScrollEnable(true);
        model.detailSc?.scrollToIndex(index);
      });
    }
    super.didChangeMetrics();
  }

  @override
  Widget build(BuildContext context) {
    AppGlobal.read<CommentDetailModel>().currentNavigatorContext = context;
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
      onPointerMove: (p) {
        if (!AppGlobal.read<CommentPanelModel>().isDraggable) return;
        AppGlobal.read<CommentPanelModel>().controller.onChildWidgetPointerMove(p);
      },
      child: Container(
        height: 57,
        color: Colors.white,
        child: Stack(
          children: [
            Positioned(
              left: 0,
              child: InkWell(
                onTap: () {
                  Navigator.of(context).pop();
                },
                child: const Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Icon(
                    Icons.arrow_back_ios_new,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
            const Positioned.fill(
              child: Center(
                child: Text(
                  "CommentDetail",
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
        controller: AppGlobal.read<CommentPanelModel>().detailSc,
        itemCount: 20,
        itemBuilder: (context, index) => _buildItem(index),
        separatorBuilder: (context, index) => Container(height: 8, color: const Color(0xfff5f5f5)),
      ),
    ));
  }

  Widget _buildItem(int index) {
    return AutoScrollTag(
      key: ValueKey(index),
      controller: AppGlobal.read<CommentPanelModel>().detailSc!,
      index: index,
      child: CommentItemWidget(
        index: index,
        isShowMoreBtn: false,
        onClickItem: (index) {
          this.index = index;
          setShowInput(true);
        },
      ),
    );
  }

  Widget _buildWriteWidget() {
    return Stack(
      children: [
        WriteBottomWidget(
          onClick: () => setShowInput(true),
        ),
        isShowTextField
            ? CommentInputWidget(
                controller: textEditingController,
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
