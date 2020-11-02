import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PrivacyPolicy extends StatefulWidget {
  @override
  _PrivacyPolicyState createState() => _PrivacyPolicyState();
}

class _PrivacyPolicyState extends State<PrivacyPolicy> {
  @override
  Widget build(BuildContext context) {
    ValueNotifier provider = Provider.of<ValueNotifier<bool>>(context);
    return Row(
      children: [
        Expanded(
          child: Text(
            '이용약관 및 개인정보처리방침에 동의합니다.',
            textAlign: TextAlign.center,
          ),
        ),
        Checkbox(
            value: provider.value,
            onChanged: (bool val) {
              setState(() {
                provider.value = val;
              });
            }),
      ],
    );
  }
}
