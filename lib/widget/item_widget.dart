import 'package:flutter/material.dart';

/// @author: pengboboer
/// @createDate: 2023/5/29

String commentContent =
    "A draggable Flutter widget that makes implementing a SlidingUpPanel much easier! Based on the Material Design bottom sheet component, this widget works on both Android & iOS.";

class CommentItemWidget extends StatelessWidget {
  final int index;
  final bool isShowMoreBtn;
  final ValueChanged<int>? onClickItem;
  final ValueChanged<int>? onClickReply;

  const CommentItemWidget(
      {Key? key, required this.index, this.isShowMoreBtn = true, this.onClickItem, this.onClickReply})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onClickItem?.call(index),
      child: Container(
        padding: const EdgeInsets.all(12),
        color: Colors.white,
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 35,
                  height: 35,
                  decoration: BoxDecoration(
                    color: const Color(0xffe2e2e2),
                    borderRadius: BorderRadius.circular(100),
                  ),
                  child: const Icon(
                    Icons.person,
                    size: 35,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: 35,
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "user name $index",
                          style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                        ),
                      ),
                      Text(
                        commentContent,
                        style: const TextStyle(
                          fontSize: 10,
                        ),
                      ),
                      Visibility(
                        visible: isShowMoreBtn,
                        child: InkWell(
                          onTap: () => onClickReply?.call(index),
                          child: const Padding(
                            padding: EdgeInsets.only(top: 6, bottom: 6, right: 10),
                            child: Text(
                              "look more",
                              style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
