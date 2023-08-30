import 'package:flutter/material.dart';

import 'form.dart';

class FormDropDownBtn extends StatefulWidget {
  const FormDropDownBtn(this.hosts, this.setHost, {super.key});

  final List<String> hosts;
  final Function setHost;

  @override
  State<FormDropDownBtn> createState() => _FormDropDownBtnState();
}

class _FormDropDownBtnState extends State<FormDropDownBtn> {
  String curHost = defaultHost;
  void setCurValue(String? val) {
    setState(() {
      curHost = val!;
    });
    widget.setHost(val);
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButton(
        onChanged: setCurValue,
        value: curHost,
        items: widget.hosts
            .map((host) => DropdownMenuItem(
                  value: host,
                  child: Text(host),
                ))
            .toList());
  }
}
