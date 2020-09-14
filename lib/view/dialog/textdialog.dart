import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TextDialog extends StatefulWidget {
  TextDialog({Key key, this.title, this.value}) : super(key: key);
  final String title;
  final String value;

  @override
  _TextDialogState createState() => _TextDialogState();
}
class _TextDialogState extends State<TextDialog> {
  TextEditingController _appCtrl = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.value != null) {
      _appCtrl = TextEditingController(text: widget.value);
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
          Navigator.pop<String>(context, _appCtrl.text);
        },
      ),
    ];
    final AlertDialog dialog = AlertDialog(
      title: Text(widget.title),
      content: TextField(
        controller: _appCtrl,
        decoration: InputDecoration(hintText: '入力してください'),
        autofocus: true,
        keyboardType: TextInputType.text,
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