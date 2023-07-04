import 'package:flutter/material.dart';

/// @author: pengboboer
/// @createDate: 2023/5/29
class CommentInputWidget extends StatefulWidget {
  final ValueChanged<String> onCommit;
  final ValueChanged<String> onChanged;
  final TextEditingController controller;
  final String? hint;

  const CommentInputWidget({Key? key, required this.onCommit, required this.controller, required this.onChanged, this.hint})
      : super(key: key);

  @override
  State<CommentInputWidget> createState() => _CommentInputWidgetState();
}

class _CommentInputWidgetState extends State<CommentInputWidget> {
  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: PhysicalModel(
        elevation: 5,
        color: Colors.white,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          color: Colors.white,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              const SizedBox(height: 2),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Flexible(
                    flex: 6,
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(
                        maxHeight: 132,
                      ),
                      child: Scrollbar(
                        controller: _scrollController,
                        thumbVisibility: true,
                        child: TextField(
                          maxLines: 3,
                          scrollController: _scrollController,
                          controller: widget.controller,
                          // focusNode: widget.focusNode,
                          autofocus: true,
                          textAlignVertical: TextAlignVertical.top,
                          style: const TextStyle(fontSize: 14, color: Color(0xFF202020), height: 10 / 7),
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Color(0xFFF6F6F6),
                            hintText: widget.hint ?? 'say something at this moment~',
                            counterText: "",
                            hintStyle: const TextStyle(fontSize: 14, color: Color(0xFFC5C5C5), height: 10 / 7),
                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(6), borderSide: BorderSide.none),
                            contentPadding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                          ),
                          onChanged: (str) {
                            widget.onChanged(str);
                          },
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              InkWell(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        width: 73,
                        height: 29,
                        alignment: Alignment.center,
                        margin: EdgeInsets.only(top: 8),
                        decoration: BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: const Text(
                          'send',
                          style: TextStyle(
                            fontSize: 13,
                            color: Colors.white,
                          ),
                        ),
                      )
                    ],
                  ),
                  onTap: () async {
                    widget.onCommit(widget.controller.text);

                  }),
            ],
          ),
        ),
      ),
    );
  }
}
