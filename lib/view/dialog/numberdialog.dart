import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class NumberDialog extends StatefulWidget {
  NumberDialog({Key key, this.title, this.value}) : super(key: key);
  final String title;
  final int value;

  @override
  _NumberDialogState createState() => _NumberDialogState();
}

class _NumberDialogState extends State<NumberDialog> {
  TextEditingController _appCtrl = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.value != null) {
      _appCtrl = TextEditingController(text: widget.value.toString());
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
          Navigator.pop<int>(context, int.tryParse(_appCtrl.text));
        },
      ),
    ];
    final AlertDialog dialog = AlertDialog(
      title: Text(widget.title),
      content: TextField(
        controller: _appCtrl,
        decoration: InputDecoration(hintText: '半角数字で入力してください'),
        autofocus: true,
        keyboardType: TextInputType.number,
        inputFormatters: <TextInputFormatter>[
          FilteringTextInputFormatter.digitsOnly,
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
