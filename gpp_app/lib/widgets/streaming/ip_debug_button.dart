import 'package:flutter/material.dart';
import 'package:gpp_app/widgets/update_ip_dialog.dart';

class IpDebugButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showDialog(
          barrierDismissible: true,
          context: context,
          builder: (context) => TextFieldDialog(),
        );
      },
      child: Padding(
        padding: const EdgeInsets.fromLTRB(
          20.0, // LEFT
          0.0,
          0.0,
          20.0, // BOTTOM
        ),
        child: Icon(
          Icons.settings_input_antenna,
          color: Colors.grey.withOpacity(0.5),
        ),
      ),
    );
  }
}
