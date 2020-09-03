import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class DepositDialog extends StatefulWidget {
  DepositDialog({Key key, this.initial}) : super(key: key);
  final int initial;

  @override
  _DepositDialogState createState() => _DepositDialogState();
}
class _DepositDialogState extends State<DepositDialog> {
  TextEditingController _appCtrl;

  @override
  void initState() {
    super.initState();
    if (widget.initial == null) {
      _appCtrl = TextEditingController();
    } else {
      _appCtrl = TextEditingController(text: widget.initial.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    MaterialLocalizations localizations = MaterialLocalizations.of(context);
    final List<Widget> actions = [
      FlatButton(
        child: Text(localizations.cancelButtonLabel),
        onPressed: () => Navigator.pop(context),
      ),
      FlatButton(
        child: Text(localizations.okButtonLabel),
        onPressed: () {
          int _amount = int.tryParse(_appCtrl.text);
          Navigator.pop<int>(context, _amount);
        },
      ),
    ];
    final AlertDialog dialog = AlertDialog(
      title: Text('入金額'),
      content: TextField(
        controller: _appCtrl,
        decoration: InputDecoration(hintText: '半角数字で入力してください'),
        autofocus: true,
        keyboardType: TextInputType.number,
        inputFormatters: <TextInputFormatter> [
          WhitelistingTextInputFormatter.digitsOnly,
        ],
      ),
      actions: actions,
    );

    return dialog;
  }

  @override
  void dispose() {
    _appCtrl.dispose();
    super.dispose();
  }
}