import 'package:flutter/material.dart';
import 'package:gpp_app/models/provider/ppcam_profile.dart';
import 'package:gpp_app/util/my_logger.dart';
import 'package:gpp_app/widgets/rounded_button.dart';
import 'package:gpp_app/widgets/rounded_input_field.dart';
import 'package:provider/provider.dart';

class TextFieldDialog extends StatefulWidget {
  @override
  _TextFieldDialogState createState() => _TextFieldDialogState();
}

class _TextFieldDialogState extends State<TextFieldDialog> {
  PpcamProfile _ppcamProvider;
  String newIpAddress;
  @override
  void initState() {
    _ppcamProvider = Provider.of<PpcamProfile>(context, listen: false);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      backgroundColor: Colors.transparent,
      elevation: 0,
      child: Container(
        child: Wrap(
          children: [
            _input(),
            _button(context),
          ],
        ),
      ),
    );
  }

  Widget _input() {
    return RoundedInputField(
      icon: Icons.wifi,
      hintText: _ppcamProvider.ipAddress,
      onChanged: (value) {
        newIpAddress = value;
      },
    );
  }

  Widget _button(BuildContext context) {
    return RoundedButton(
      text: '확인',
      press: () async {
        if (newIpAddress == '' || newIpAddress == null) {
          MyLogger.debug('new ip address is null');
        } else {
          // GO

          await _ppcamProvider.updateIpAddress(context, newIpAddress);
          MyLogger.debug('Success to update new ip address');
          Navigator.of(context).pop();
          Navigator.of(context).pop();
        }
      },
    );
  }

  // Widget _alert() {
  //   return Container(
  //     padding: const EdgeInsets.symmetric(horizontal: 20.0),
  //     decoration: BoxDecoration(
  //       color: Colors.white,
  //       borderRadius: BorderRadius.circular(20.0),
  //     ),
  //     child: Wrap(
  //       children: [
  //         Icon(
  //           Icons.warning,
  //           color: Colors.orange,
  //         ),
  //         Text('올바른 주소를 입력하세요'),
  //       ],
  //     ),
  //   );
  // }
}
