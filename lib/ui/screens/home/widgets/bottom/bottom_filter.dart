import 'package:flutter/material.dart';
import 'package:flutter_socket_log_client/ui/screens/home/widgets/bottom/check_box_widget.dart';
import 'package:flutter_socket_log_client/ui/screens/home/widgets/bottom/highlighted_log_controller_widget.dart';
import 'package:flutter_socket_log_client/ui/screens/home/widgets/bottom/search_box.dart';

class BottomFilter extends StatelessWidget {
  const BottomFilter({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: const [
        SearchBox(),
        HighLightedMessageControllerWidget(),
        CheckBoxWidget(),
      ],
    );
  }
}
