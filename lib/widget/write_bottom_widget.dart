import 'package:flutter/material.dart';

/// @author: pengboboer
/// @createDate: 2023/5/29
class WriteBottomWidget extends StatelessWidget {
  final VoidCallback onClick;

  const WriteBottomWidget({Key? key, required this.onClick}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onClick,
      child: Container(
        padding: EdgeInsets.only(left: 18, right: 18, top: 10, bottom: 10 + MediaQuery.of(context).padding.bottom),
        decoration: const BoxDecoration(
            color: Colors.white, boxShadow: [BoxShadow(offset: Offset(0, -0.5), color: Color(0xffe6e6e6))]),
        child: Container(
          height: 38,
          decoration: BoxDecoration(
            color: const Color(0xfff6f6f6),
            borderRadius: BorderRadius.circular(19),
          ),
          child: Row(
            children: [
              const SizedBox(width: 14),
              Container(
                margin: const EdgeInsets.only(top: 2),
                child: const Icon(
                  Icons.edit,
                  size: 16,
                  color: Color(0xffc5c5c5),
                ),
              ),
              const SizedBox(width: 8),
              const Text(
                "write comment",
                style: TextStyle(
                  fontSize: 14,
                  color: Color(0xffc5c5c5),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
